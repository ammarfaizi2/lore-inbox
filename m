Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289005AbSAUCba>; Sun, 20 Jan 2002 21:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289011AbSAUCbV>; Sun, 20 Jan 2002 21:31:21 -0500
Received: from rj.sgi.com ([204.94.215.100]:30358 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S289005AbSAUCbL>;
	Sun, 20 Jan 2002 21:31:11 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away? 
In-Reply-To: Your message of "Mon, 21 Jan 2002 02:13:55 -0000."
             <20020121021355.GA60801@compsoc.man.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 Jan 2002 13:31:00 +1100
Message-ID: <386.1011580260@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002 02:13:55 +0000, 
John Levon <movement@marcelothewonderpenguin.com> wrote:
>On Mon, Jan 21, 2002 at 12:53:28PM +1100, Keith Owens wrote:
>> Guess why these entries are in /proc/ksyms?
>> 
>> c48a2300 __insmod_3c589_cs_S.bss_L4	[3c589_cs]
>
>and quite often the user has unloaded / loaded modules in the meantime
>and the oops is useless.

/var/log/ksymoops.  I added the code and documented it nicely, man
insmod or ksymoops.  It's not my fault if nobody reads the docs!

>It would be nice if klogd's oops detection just passed everything to ksymoops
>untouched, and stored everything somewhere using -m

It would be better if klogd got out of the way completely.  Everything
is stored, just created /var/log/ksymoops.

>I don't see any reason why the internal profiler can't have an extended EIP
>range to catch module samples either. Perhaps I'm missing something. Perhaps
>no one cares enough ...

IMNSHO the profiler should use kallsyms.  Then it gets every symbol
from the kernel and from all modules, instead of only being able to
report on exported symbols.

int kallsyms_address_to_symbol(
        unsigned long     address,      /* Address to lookup */
        const char      **mod_name,     /* Set to module name */
        unsigned long    *mod_start,    /* Set to start address of module */
        unsigned long    *mod_end,      /* Set to end address of module */
        const char      **sec_name,     /* Set to section name */
        unsigned long    *sec_start,    /* Set to start address of section */
        unsigned long    *sec_end,      /* Set to end address of section */
        const char      **sym_name,     /* Set to full symbol name */
        unsigned long    *sym_start,    /* Set to start address of symbol */
        unsigned long    *sym_end       /* Set to end address of symbol */
        )

We have the technology.

