Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130738AbQJ1CSj>; Fri, 27 Oct 2000 22:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130742AbQJ1CS3>; Fri, 27 Oct 2000 22:18:29 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:31759 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130738AbQJ1CSX>;
	Fri, 27 Oct 2000 22:18:23 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Alan Cox <alan@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make agpsupport work with modversions 
In-Reply-To: Your message of "Fri, 27 Oct 2000 14:25:48 BST."
             <20075.972653148@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Oct 2000 13:18:16 +1100
Message-ID: <5122.972699496@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000 14:25:48 +0100, 
David Woodhouse <dwmw2@infradead.org> wrote:
>But in the case where there _aren't_ any functions which could usefully be 
>shared between the modules, you've got a whole extra gratuitous module 
>(What's that, 32KiB on some ARM boxen?) just to hold the registration 
>functions, which aren't needed if you just use get_module_symbol().
>
>Provide generic code for registering such stuff and it might be acceptable. 
>Otherwise, get_module_symbol is better. There's no fundamental flaw with 
>get_module_symbol() - just one or two of the current usages of it.

cc list trimmed.  Nobody has come up with a "must have" reason for
get_module_symbol and that interface is broken as designed.  I will be
adding generic inter-object registration code and removing all vestiges
of get_module_symbol this weekend.  The inter-object registration code
will allow two objects to pass data to each other, it will not matter
whether the objects are both modules, one module and one built in (in
either order) or both built in.  When modules are involved there will
be full module locking.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
