Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTDNXMZ (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 19:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTDNXMY (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 19:12:24 -0400
Received: from post2.inre.asu.edu ([129.219.110.73]:22971 "EHLO
	post2.inre.asu.edu") by vger.kernel.org with ESMTP id S263879AbTDNXMW (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 19:12:22 -0400
Date: Mon, 14 Apr 2003 16:23:50 -0700 (MST)
From: Shesha@asu.edu
Subject: Re: readprofile ; Meaning of "Length of procedure"
In-reply-to: <1050360396.1192.20.camel@andyp.pdx.osdl.net>
To: Andy Pfiffer <andyp@osdl.org>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304141615360.9127-100000@general2.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot Andy, one this that is bothering me is,
Say if the load of procedures by executing the command mentioned by you is as
follows in descending order....

2604	__geneic_copy_to_user 		40.6875
1705	csum_patrial_copy_generic	6.8750
370	__generic_copy_from_user	3.75
764	do_annonymous_page		3.1754
176	handle_IRQ_event		1.5714
31	remove_wait_queue		0.96

the list goes on

are these procedures condidered as load on the CPU? how much of a load ?
very high, high, moderate .....

If you can throw some light on this, it will be great.
Thanking You
Shesha 


On Mon, 14 Apr 2003, Andy Pfiffer wrote:

> On Mon, 2003-04-14 at 15:17, Shesha@asu.edu wrote:
> >  Hello Linux ppl,
> >  
> >  I have copuple of questions, I request you to share the information if you
> > know ....
> 
> I have a partial answer.
> 
> > --
> > 1
> > --
> >  In the readprofile man page load=(# of clk ticks) / (length of the procedure)
> >  
> >  What does "length of procedure" means.
> 
> My understanding after a quick read of the source is that "length of the
> procedure" means the length, in bytes, of the function.  For most
> architectures, there is not a correlation between lines of code in
> assembler and number of executable bytes.
> 
> On ARM all instructions are 4 bytes long (not counting "Thumb" style
> instruction encoding), but that does not mean 1 line of assembler source
> code is equal to 4 bytes worth of instructions.
> 
> As far as I can tell, the "length of the procedure" is determined by the
> difference between sucessive symbols found in System.map:
> 
>         .
>         .
>         .
>         c0109414 T sys_fork
>         c010943c T sys_clone
>         c0109474 T sys_vfork
>         c01094a0 T sys_execve
>         .
>         .
>         .
> 
> sys_clone(), on my system, is 56 bytes long, including any alignment
> padding (0xc0109474-0xc010943c = 56).
> 
> 
> 
> > Does that mean the # of ASM lines of
> >  the procedure code? What is the units of the load. It cannot be %. because 
> > -----------------------------------------------------------
> >  152495 default_idle                             3176.9792 
> > -----------------------------------------------------------
> >  the above line indicates,  more than 100% of times CPU is idle. This cannot
> > happen.
> 
> It is not a percentage.  The value is computed by:
> 
> 	"load" = ticks_attributed_to_the_proc / length_of_proc
> 
> >From your example above:
> 
> 	3176.9792 = 152495 / length_of_proc
> 
> therefore length_of_proc = 48 bytes.  48 looks reasonable when cross
> checked with my x86 system (default_idle() is 52 bytes long on my
> system).
> 
> 
> >  What value of the procedure load is considered to be a potential CPU
> > intensive procedure/ high load procedure.
> 
> There is no magic number.  However, from the readprofile man page, some
> likely "high load" candidates could be found by:
> 
> 	readprofile | sort -nr +2 | head -20
> 
> 
> Regards,
> Andy
> 
> 

