Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUHaS1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUHaS1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 14:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUHaS1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 14:27:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265768AbUHaS1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 14:27:15 -0400
Date: Tue, 31 Aug 2004 11:26:59 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jakub Jelinek <jakub@redhat.com>
cc: Roland McGrath <roland@redhat.com>, Michael Kerrisk <mtk-lkml@gmx.net>,
       akpm@osdl.org, drepper@redhat.com, linux-kernel@vger.kernel.org,
       michael.kerrisk@gmx.net, Tonnerre <tonnerre@thundrix.ch>
Subject: Re: [PATCH] waitid system call
In-Reply-To: <20040831062656.GU11465@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0408311122430.2295@ppc970.osdl.org>
References: <12606.1093348262@www48.gmx.net> <200408310604.i7V64k7o010652@magilla.sf.frob.com>
 <20040831062656.GU11465@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Aug 2004, Jakub Jelinek wrote:
> 
> Is it really necessary to check the exit code after each put_user?

More importantly, is there really any reason to care at all?

There's no real reason to generate extra code to check an error value that 
is pointless. It should probably just use

	(void) clear_user(infop, sizeof(*infop))

and be done with it.

		Linus
