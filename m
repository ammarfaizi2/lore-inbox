Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVDKHCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDKHCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 03:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVDKHCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 03:02:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:7364 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261711AbVDKHCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 03:02:51 -0400
Date: Sun, 10 Apr 2005 23:51:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: jlan@engr.sgi.com, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, efocht@hpce.nec.com, linuxram@us.ibm.com,
       gh@us.ibm.com, elsa-devel@lists.sourceforge.net, aquynh@gmail.com,
       dean-list-linux-kernel@arctic.org, pj@sgi.com
Subject: Re: [patch 2.6.12-rc1-mm4] fork_connector: add a fork connector
Message-Id: <20050410235124.2addd7d9.akpm@osdl.org>
In-Reply-To: <20050411104456.A31664@2ka.mipt.ru>
References: <4255B6D2.7050102@engr.sgi.com>
	<4255B868.6040600@engr.sgi.com>
	<1112955840.28858.236.camel@uganda>
	<1112957563.28858.240.camel@uganda>
	<4256E940.9050306@engr.sgi.com>
	<425700CD.5040906@engr.sgi.com>
	<20050409021856.39e99bef@zanzibar.2ka.mipt.ru>
	<42574C88.9080601@engr.sgi.com>
	<20050409102926.0cbf031c@zanzibar.2ka.mipt.ru>
	<425A0E7C.8080900@engr.sgi.com>
	<20050411104456.A31664@2ka.mipt.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> On Sun, Apr 10, 2005 at 10:43:24PM -0700, Jay Lan (jlan@engr.sgi.com) wrote:
> > I based my listen program on the fclisten.c posted by Kaigai Kohei
> > with my own modification. Unfortunately i lost my test machine in the
> > lab. I will recreate the listen program Monday. The original listener
> > did not validate sequence number. It also prints length of data and
> > sequence number of every message it receives. My listener prints
> > only out-of-sequence error messages.
> > 
> > The fork generator fork-test.c was yours? I called it fork-test
> > and let it run continuously in while-loop:
> > 
> > # while 1
> > # ./fork-test 10000000
> > # sleep 1
> > # end
> > 
> > I let it do 10,000,000 times of fork continuously while the system
> > is running AIM7 and/or ubench.
> > 
> > The original fclisten.c and fork-test.c are attached for your reference.
> 
> It is pretty normal to see duplicated numbers in a fork test - 
> I observed it too, since counter is incremented without locks
> we can catch situation when it is incremented simultaneously 
> on both processors, the latest version of the fork connector
> from Guillaume contains processor id in the message and per cpu counters, 
> so one can destinguish messages which sequence numbers will flow
> in a very similar way now.

Oh come on, that's just daft.  Evgeniy, put a lock in there and fix it up.
