Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291492AbSBMKQc>; Wed, 13 Feb 2002 05:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291502AbSBMKQW>; Wed, 13 Feb 2002 05:16:22 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:8458 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291492AbSBMKQM>; Wed, 13 Feb 2002 05:16:12 -0500
Date: Wed, 13 Feb 2002 10:15:51 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Improved ksymoops output
Message-ID: <20020213101550.A11052@flint.arm.linux.org.uk>
In-Reply-To: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202130805.g1D85st16817@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Feb 13, 2002 at 10:05:55AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 10:05:55AM -0200, Denis Vlasenko wrote:
> Ksymoops with file names and optionally regexp matched email addrs
> ==================================================================
> Warning (compare_maps): ksyms_base symbol ... not found in System.map.  Ignoring ksyms_base entry
> ...<<tons of similar warnings>>...

Eww.  You get these warnings because ksymoops is no longer able to match
up System.map with the kernel ksyms (since you effectively changed the
name of every symbol in System.map).

> Call Trace: [<c0130e00>] [<c01459cf>] [<c0113ee7>] [<c0113e38>] [<c021049f>]
>    [<c0145d05>] [<c0146002>] [<c010644e>] [<c011b432>] [<c011b7e3>] [<c01071ff>]
> Warning (Oops_read): Code line not seen, dumping what data is available
> Trace; c0130e00 <__get_free_pages(mm/page_alloc.c)+10/1c>
> Trace; c01459cf <__pollwait(fs/select.c:viro@math.psu.edu,tester3@host.org)+33/90>

I don't call this format "better" nor "improved".

It might be better to have something like this following at the end:

File; __get_free_pages: mm/page_alloc.c
File; __pollwait: fs/select.c
File; do_select: fs/select.c
File; process_timeout: kernel/sched.c
File; restore_sigcontext: arch/i386/kernel/signal.c
File; sock_poll: net/socket.c
File; sys_gettimeofday: kernel/time.c
File; sys_select: fs/select.c
File; sys_setitimer: kernel/itimer.c

Maintainer; fs/select.c <viro@math.psu.edu> <tester3@host.org>

Yes, this would involve modifications to ksymoops.  Note how we grouped
the email addresses together, and also how we sorted the symbol to file
list.

This way you don't have to go around cutting random bits of text out of the
middle of lines, and the lines don't wrap column at 80; in other words, it
is more readable.

You also remove some duplication of information, which is always a bonus
IMHO.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

