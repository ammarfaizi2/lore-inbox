Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbWBORqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWBORqi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 12:46:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWBORqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 12:46:38 -0500
Received: from [195.23.16.24] ([195.23.16.24]:57990 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751100AbWBORqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 12:46:38 -0500
Message-ID: <43F368FA.7000000@grupopie.com>
Date: Wed, 15 Feb 2006 17:46:34 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Trap flag handling change in 2.6.10-bk5 broke Kylix  debugger
References: <200602142220_MC3-1-B866-DF84@compuserve.com>
In-Reply-To: <200602142220_MC3-1-B866-DF84@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> On Tue, 14 Feb 2006 at 20:21:08 +0000, Paulo Marques wrote:
> 
>>>+                   regs->eflags &= ~TF_MASK;
>>>+                   tsk->ptrace &= ~PT_DTRACE;
>>>+                   if (!tsk->ptrace & PT_DTRACE)
> 
>                             ^^^^^^^^^^^^^^^^^^^^^^^^
>   Looks like this is always true because that bit was cleared one line above.
> Maybe it should be testing PT_DTRACED instead?  And it's missing parens too,
> so try:
>                         if (!(tsk->ptrace & PT_DTRACED))

Yes, this does look funny :P

However, this is the piece of code that I don't put in in order to make 
the debugger work, and it doesn't exist on the vanilla 2.6.16-rc kernel 
anymore.

What I did try to do was to add the:

-           if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
-                   goto clear_TF;

condition to the 2.6.16-rc kernel, but that didn't work anyway :(

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
