Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277308AbRJEFsv>; Fri, 5 Oct 2001 01:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277315AbRJEFsn>; Fri, 5 Oct 2001 01:48:43 -0400
Received: from rj.sgi.com ([204.94.215.100]:41700 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S277308AbRJEFsg>;
	Fri, 5 Oct 2001 01:48:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets 
In-Reply-To: Your message of "Thu, 04 Oct 2001 08:36:54 MST."
             <3BBC8216.4B708192@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Oct 2001 15:48:58 +1000
Message-ID: <4054.1002260938@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Oct 2001 08:36:54 -0700, 
george anzinger <george@mvista.com> wrote:
>The symbol name IMHO should contain both the member name and the
>structure name.  Otherwise there may be a problem if two structures use
>the same member name (flags comes to mind).

The asm symbol name is arch defined, I am defining the standard method,
not the asm names.  It is up to the arch maintainers to pick suitable
names, e.g. ia64 does

DEFINE(IA64_SWITCH_STACK_AR_BSPSTORE_OFFSET, offsetof(struct switch_stack, ar_bspstore),);

>This is way down on the list, but is it possible to generate a separate
>file for each *.S AND put the "required symbols" in the *.S.  

That works for a small number of mappings but not when there are a
large number that are required in several places.  Take a look at
arch/ia64/tools/print_offsets.c, 130+ mappings used by 5 or 6 different
asm sources.  There are also technical reasons (to do with the kernel
CONFIG system) why a single asm-offsets file is easier to maintain.

