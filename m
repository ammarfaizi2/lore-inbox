Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293129AbSBWM1X>; Sat, 23 Feb 2002 07:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293130AbSBWM1N>; Sat, 23 Feb 2002 07:27:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:22791 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293129AbSBWM1E>;
	Sat, 23 Feb 2002 07:27:04 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel 
In-Reply-To: Your message of "Sat, 23 Feb 2002 05:11:36 CDT."
             <200202231011.g1NABaU10984@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Feb 2002 23:26:52 +1100
Message-ID: <25097.1014467212@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002 05:11:36 -0500, 
Pete Zaitcev <zaitcev@redhat.com> wrote:
>>> The attached patch implements C exceptions in the kernel,

Kernel code already has exception tables to handle invalid addresses,
invalid opcodes etc.  See copy_to_user and wrmsr_eio for examples.
Apart from that, the kernel code assumes that it knows what it is doing
and does not need exceptions, any unexpected exceptions quite correctly
fall into the oops handler.

The kernel model is "get it right the first time, so we don't need
exception handlers".  You have not given any reason why the existing
mechanisms are failing.

>do we support setjump/longjump
>in kernel? The patch as I saw it does reimplement a similar thing
>(check out its assembler fragments).

Standard kernel code does not support setjmp/longjmp.  AFAIK the only
code that does is the kdb patch where I need the extra protection, when
kdb is entered it is a fair bet that something has already gone wrong.

