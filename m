Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUCaOW1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUCaOW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:22:27 -0500
Received: from ns.suse.de ([195.135.220.2]:2473 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261950AbUCaOW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:22:26 -0500
Subject: Re: [PATCH] barrier patch set
From: Chris Mason <mason@suse.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1080742105.1991.40.camel@sisko.scot.redhat.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com> <4069F2FC.90003@pobox.com>
	 <1080742105.1991.40.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1080742895.3547.139.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Mar 2004 09:21:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 09:08, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, 2004-03-30 at 23:21, Jeff Garzik wrote:
> 
> > For IDE, O_DIRECT and O_SYNC can use special "FUA" commands, which don't 
> > return until the data is on the platter.
> 
> fsync() is still really nasty, because that can require that we wait on
> IO that was submitted by the VM before we knew that there was a
> synchronous IO wait coming.  

Yes, it gets ugly in a hurry.  Jeff, look at the whole thread about the
O_DIRECT read vs buffered write races.  I don't think we can use FUA for
fsync or O_SYNC without using it for every write.

We might be able to get away with using it on O_DIRECT.

-chris


