Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157502AbQGaRNr>; Mon, 31 Jul 2000 13:13:47 -0400
Received: by vger.rutgers.edu id <S157445AbQGaRMy>; Mon, 31 Jul 2000 13:12:54 -0400
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:6343 "EHLO tomcat.admin.navo.hpc.mil") by vger.rutgers.edu with ESMTP id <S157402AbQGaRLp>; Mon, 31 Jul 2000 13:11:45 -0400
Date: Mon, 31 Jul 2000 12:31:47 -0500 (CDT)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200007311731.MAA158912@tomcat.admin.navo.hpc.mil>
To: kaih@khms.westfalen.de (Kai Henningsen), linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
X-Mailer: [XMailTool v3.1.2b]
Sender: owner-linux-kernel@vger.rutgers.edu

---------  Received message begins Here  ---------

> 
> pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard)  wrote on 27.07.00 in <200007271531.KAA89926@tomcat.admin.navo.hpc.mil>:
> 
> > Might I suggest creating a "/lib/include" that works something like
> > the /lib/modules where the kernel name is used to generate the directory
> > for the kernel include files?
> >
> > That way the "uname -r" command could be used to set a symbolic link
> > to point to the correct include files at boot time (or install time).
> 
> Correct for what?
> 
> I think this is silly.
> 
> There are two versions of header files people tend to be interested in:
> 
> a. The ones corresponding to the libc version their linker will link  
> against. This will be good for 99% of the situations.
> 
> b. A special version for some kernel-version-dependant executable. Exact  
> version depends on what they plan to do with that executable - could be  
> most advanced kernel version available, least advanced version available,  
> a specific version whose significance depends on the configuration of a  
> different machine, whatever.
> 
> There is no reason to assume that the currently running kernel version is  
> any more relevant than any of the other arguments for b.
> 
> > This way the kernel that is active would be selecting the correct includes.
> 
> Correct for what?

I said (which got dropped) for things like the RSBAC project, which has
applications that are dependant on the current kernel for proper operation.
The RSBAC project implements multi-level security (among other things) and
supports system calls for manipulating the security labels on the kernel,
and disk files (login, init, ...). The system call list varies depending
on the kernel version, some of the data structures also depends on the
kernel version. The symbolic link would allow a boot time selection of
the correct include files if I need to rebuild/debug them.

When I boot an older/test kernel, the executables used are no longer
valid. Building new executables during test would also invalidate the
older/current ones.

I see using a symbolic link (which I may do on my own) as a way to
preserve system level consistancy, by having different versions of the
executables in my search path/cron job search path.

I can see this also providing advantages for module initialization - well
only the ones that require external hardware initialization. Things like
some wide area net cards, terminal multiplexors...

Some of these require compatablility between module and hardware microcode
for proper functionality. An older kernel will require an older module, and
that older module may require older microcode (not to mention, and older
loader application). Using a version link would simplify the automatic
selection of the proper initialization code.

Now I can do all this on my own, but it might be usefull for more than
just what I see; and others might see pitfalls that I missed.
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
