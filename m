Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268238AbUIPS1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268238AbUIPS1C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 14:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268228AbUIPSXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 14:23:43 -0400
Received: from dmz.tecosim.com ([195.135.152.162]:15793 "EHLO dmz.tecosim.de")
	by vger.kernel.org with ESMTP id S268145AbUIPSVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 14:21:47 -0400
Date: Thu, 16 Sep 2004 20:21:39 +0200
From: Utz Lehmann <lkml@de.tecosim.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Utz Lehmann <lkml@de.tecosim.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] flexmmap: optimise mmap_base gap for hard limited stack
Message-ID: <20040916182139.GA21870@de.tecosim.com>
References: <20040916165613.GA10825@de.tecosim.com> <20040916174529.GA16439@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916174529.GA16439@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven [arjanv@redhat.com] wrote:
> On Thu, Sep 16, 2004 at 06:56:13PM +0200, Utz Lehmann wrote:
> > Hi
> > 
> > With the flexmmap memory layout there is at least a 128 MB gap between
> > mmap_base and TASK_SIZE. I think this is for the case that a running process
> > can expand it's stack soft rlimit.
> > 
> > If there is a hard limit for the stack this minium gap is just a waste of
> > space. This patch reduce the gap to the hard limit + 1 MB hole. If a process
> > has a 8192 KB hard limit it have additional 119 MB space available over the
> > current behavior.
> 
> 
> I'm not so convinced this is the right approach... a bit of room for the
> apps to increase their stack sounds useful. (and a "reasonable" amount is
> SuS specified afaik, 128Mb is quite reasonable)

This is only for a hard limited (rlim_max) stack. A non-root application
can not increase it anyway.
The default (rlim_cur = ~8MB, rlim_max = ulimited) is unchanged and get a
gap of 128MB.

A check for CAP_SYS_RESOURCE can be added. But i dont think it's worth.
