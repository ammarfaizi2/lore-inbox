Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268228AbUHTPQ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268228AbUHTPQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 11:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268174AbUHTPGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 11:06:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60367 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267243AbUHTPEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 11:04:14 -0400
Date: Fri, 20 Aug 2004 11:02:57 -0400
From: Alan Cox <alan@redhat.com>
To: Oliver Neukum <oliver@neukum.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Hugh Dickins <hugh@veritas.com>, arjanv@redhat.com, alan@redhat.com,
       greg@kroah.com, linux-kernel@vger.kernel.org, riel@redhat.com,
       sct@redhat.com
Subject: Re: PF_MEMALLOC in 2.6
Message-ID: <20040820150257.GC6812@devserv.devel.redhat.com>
References: <Pine.LNX.4.44.0408191320320.17508-100000@localhost.localdomain> <4125B111.2040308@yahoo.com.au> <20040820014005.73383a43@lembas.zaitcev.lan> <200408201650.07513.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408201650.07513.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 04:50:07PM +0200, Oliver Neukum wrote:
> > This is what made me suspect that it's the diry memory writeout problem.
> > It's just like how it was on 2.4 before Alan added PF_MEMALLOC.
> 
> If we add PF_MEMALLOC, do we solve the issue or make it only less
> likely? Isn't there a need to limit users of the reserves in number?

PF_MEMALLOC won't recurse. You might run out of memory however. The old
world scsi drivers run in the thread of the I/O so are protected already
by PF_MEMALLOC in those cases, its the thread nature of the USB driver which
makes it more fun. Unless 2.6 vm is radically different I think PF_MEMALLOC
is the right thing to set although it would always eventually be better to
find out who is guilty of the blocking allocation that recurses.

Are any of the VM guys considering PF_LOGALLOC so you can trace it down 8)

