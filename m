Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbTFEBnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 21:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbTFEBnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 21:43:23 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:4234 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264377AbTFEBnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 21:43:22 -0400
Date: Wed, 4 Jun 2003 18:56:52 -0700
From: Andrew Morton <akpm@digeo.com>
To: shemminger@osdl.org, jgarzik@pobox.com, davem@redhat.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk+ broken networking
Message-Id: <20030604185652.31958d1f.akpm@digeo.com>
In-Reply-To: <3EDE7FEB.2C7FAEC7@digeo.com>
References: <20030604161437.2b4d3a79.shemminger@osdl.org>
	<3EDE7FEB.2C7FAEC7@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Jun 2003 01:56:52.0736 (UTC) FILETIME=[BC1D1800:01C32B05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> Stephen Hemminger wrote:
> > 
> > Test machine running 2.5.70-bk latest can't boot because eth2 won't
> > come up.  The same machine and configuration successfully brings up
> > all the devices and runs on 2.5.70.
> 
> kjournald is stuck waiting for IO to complete against some buffer
> during transaction commit.
> 
> I'd be suspecting block layer or device drivers.  What device driver
> is handling your /var/log?

I take that back.

Your sysrq-T woke up syslogd which did a synchronous write which poked
kjournald.  You happened to catch it in mid-commit.  So that's all normal
and sane.

Something is up with netdevice initialisation.  My eth0 (e100) is in a
strange half-there state and won't come up.  Reverting the post-2.5.70 e100
changes does not help.  It's something which went into the tree today I
think.


