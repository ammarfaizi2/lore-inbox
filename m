Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310193AbSCPJuz>; Sat, 16 Mar 2002 04:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310194AbSCPJuq>; Sat, 16 Mar 2002 04:50:46 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5392 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S310193AbSCPJud>;
	Sat, 16 Mar 2002 04:50:33 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devexit fixes in i82092.c 
In-Reply-To: Your message of "Sat, 16 Mar 2002 00:13:21 -0800."
             <Pine.LNX.4.33.0203160010510.2448-100000@home.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 16 Mar 2002 20:50:22 +1100
Message-ID: <15665.1016272222@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 00:13:21 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>On Sat, 16 Mar 2002, Keith Owens wrote:
>>
>> Does that mean that we also get rid of the initcall methods?  If
>> shutdown follows a device tree then startup should also use that tree.
>
>You cannot _build_ the tree without the initcall methods - it's populating
>the tree that the initcalls mostly do, after all.

Confusion of names.  I read 'device tree' and thought you were talking
about an initialization tree that was built from PCI and USB data,
independent of kernel link order.  If your 'device tree' is just the
existing initcall list derived from $(obj-y) then I agree that we
should bot have separate shutdown functions.  module_exit should be
retained for objects that are built into the kernel and the shutdown
code should run the module_exit functions in reverse order to
initialization.

The question of separating register and probe is independent of the
above.  It is definitely a good idea to separate register and probe, if
only to avoid all the existing races on module unload (using
__this_module and mod_inc_count everywhere in mainline code is not a
perfect solution).

