Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRACWJi>; Wed, 3 Jan 2001 17:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131203AbRACWJ2>; Wed, 3 Jan 2001 17:09:28 -0500
Received: from user-143-42.jakinternet.co.uk ([212.187.143.42]:17672 "HELO
	opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S130669AbRACWJR>; Wed, 3 Jan 2001 17:09:17 -0500
Date: Wed, 3 Jan 2001 22:09:21 +0000 (GMT)
From: Mark Zealey <mark@itsolve.co.uk>
To: Brian Gerst <bgerst@didntduck.org>
cc: Dan Aloni <karrde@callisto.yi.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] prevention of syscalls from writable segments, breaking 
 bugexploits
Message-ID: <Pine.LNX.4.21.0101032208360.1039-100000@sunbeam.itsolve.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jan 2001, Brian Gerst wrote:

> Dan Aloni wrote:
> > 
> > It is known that most remote exploits use the fact that stacks are
> > executable (in i386, at least).
> > 
> > On Linux, they use INT 80 system calls to execute functions in the kernel
> > as root, when the stack is smashed as a result of a buffer overflow bug in
> > various server software.
> > 
> > This preliminary, small patch prevents execution of system calls which
> > were executed from a writable segment. It was tested and seems to work,
> > without breaking anything. It also reports of such calls by using printk.
> 
> Do you realise how much overhead you just added to every single
> syscall?

Not much, dax said that he didnt notice any difference on a 450 PIII w/
128Mb RAM, anyways, this could be a configure-able option in the kernel
config, sysadmins would select it, people that wanted security against
defunct programs would select it, others could choose to loose the
overhead, the user's choice. It's a great debugging tool to test for
faulty programs, and for h4x0rs trying to break in, too.

> It won't work anyways, for the same reasons every other
> non-exec stack patch has been rejected - exploits exist that don't write
> any code to the stack, you just need two pointers.

You rejected a patch that stops about 90% of remote r00t'ing attacks just
cos it doesnt cover all attacks? thats stupid. you'll never have a
completly bug-free kernel, and they'll always be programs that will be
faults, this is just a safety net against poor programming. As I said
above, if you dont like it, just trun if off, for those that would like
not to be r00ted via poorly written programs, we can turn it on.

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@itsolve.co.uk
mark@sexygeek.org
mark@x-paste.de

UL++++$ (GCM/GCS/GS/GM)GUG! dpu? s-:-@ a15! C+++>$ P++$>+++@ L+++>+++++$
!E---? W+++>$ N++@>+ o->+ w--- !M--? !V--? PS- PE--@ !PGP----? r++
!t---?@ !X---? !R- b+ !DI---? e->+++++ h+++*! y-

(www.geekcode.com)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
