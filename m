Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314132AbSDLSGj>; Fri, 12 Apr 2002 14:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314133AbSDLSGj>; Fri, 12 Apr 2002 14:06:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36163 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314132AbSDLSGi>; Fri, 12 Apr 2002 14:06:38 -0400
To: suparna@in.ibm.com
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <1759496962.1018114339@[10.10.2.3]>
	<m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com>
	<m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com>
	<m1y9fvlfyb.fsf@frodo.biederman.org> <20020411192649.A1947@in.ibm.com>
	<m1hemil03d.fsf@frodo.biederman.org> <20020412201950.A1443@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Apr 2002 11:59:35 -0600
Message-ID: <m1sn60kdbs.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> OK. The crash with bootimg implementation was known to have occasional
> difficulties when boot got triggered (via panic) while in X -- sometimes 
> having the console messed up, and on some occasions even hangs.
> How's been your experience - no problems in kexec'ing from X, 
> anytime ?

So far I haven't tried it from X.  Most of my test machines don't have
video.  When working on a good machine you should be able to return
the video to the state you got it.

I'm not quite certain how to handle the crash dump case.
 
> That would be machine_kexec, and the kimage struct, right ?
> So far looks ok, though I haven't looked at it critically. One thing that 
> that I require was a way to pass information across boots - 
> maybe that could be done through command line parameters to the new 
> kernel.

A command line work work.  You can arbitrary segments so you can pass
anything that is needed from the user space side.

> > Version 2.0 is an early beta.  Some idiot yanked EM_486 and a couple
> > of other symbols out of elf.h from glibc.  Despite the ELF spec says
> > EM_486 at least should be there.  In any case that is just a debugging
> > bit and you can safely disable those.  Or do a make -k and compile the
> > kexec piece, but not the kparam, which isn't really relevant.
> 
> I commented out the EM_486 check from the kexec code, and it built
> cleanly. I was able to boot a 2-way system with it, though it seemed
> to take a while, perhaps more so because I didn't seem to be getting
> any of the bootup/startup messages on my console. In one case there were 
> some INIT respawning messages that came up. Not sure the fact that
> I'm using a serial console matters.

A serial console is my usual test case, so that shouldn't affect
anything.  I'm glad that it worked. 

For the speed difference my hunch is perhaps you didn't specify your
normal kernel command line on the command line.  

Usually I do something like:
kexec bzImage root=xxx console=ttyS0,9600 blah, blah, blah.

Mostly kexec is supposed to be the simple test client instead of a
full fledged interface.

Eric
