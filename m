Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbVKNPfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbVKNPfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 10:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVKNPfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 10:35:53 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:14779 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751146AbVKNPfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 10:35:53 -0500
Subject: Re: 2.6.xx:  dirty pages never being sync'd to disk?
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Lord <lkml@rtr.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4378ADB2.7040905@rtr.ca>
References: <4378ADB2.7040905@rtr.ca>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 16:35:49 +0100
Message-Id: <1131982550.2821.41.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-14 at 10:30 -0500, Mark Lord wrote:
> Okay, this one's been nagging me since I first began using 2.6.xx.
> 
> My Notebook computer has 2GB of RAM, and the 2.6.xx kernel seems quite
> happy to leave hundreds of MB of dirty unsync'd pages laying around
> more or less indefinitely.  This worries me, because that's a lot of data
> to lose should the kernel crash (which it has once quite recently)
> or the battery die.
> 
> /proc/sys/vm/dirty_expire_centisecs = 3000 (30 seconds)
> /proc/sys/vm/dirty_writeback_centisecs = 500 (5 seconds)
> 
> My understanding (please correct if wrong) is that this means
> that any (file data) page which is dirtied, should get flushed
> back to disk after 30 seconds or so.

do you have laptop mode enabled? That changes the behavior bigtime in
this regard and makes the kernel behave quite different.

also if these are files written to by mmap, the kernel only really sees
those as dirty when the mapping gets taken down (eg the propagation from
the pagetable dirty bit to the per page dirty bit goes a bit lazy)


