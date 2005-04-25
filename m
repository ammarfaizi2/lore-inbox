Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVDYP4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVDYP4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVDYPzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:55:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:12959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262668AbVDYPxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:53:49 -0400
Date: Mon, 25 Apr 2005 08:55:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>, Roland McGrath <roland@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: handle iret faults better
In-Reply-To: <20050425153310.GB16828@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0504250849370.18901@ppc970.osdl.org>
References: <200504240050.j3O0obqR032684@magilla.sf.frob.com>
 <20050425153310.GB16828@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Andi Kleen wrote:
> 
> But I really hate your is_iret hack in traps.c. 

I agree.

Why don't you just do

	pushl $0
	pushl $do_iret_error
	jmp error_code

And just have a "do_iret_error()" handler in traps.c which does the right
thing? That seems like the _sane_ thing to do, and that way there is never
any confusion about what is going on.

		Linus
