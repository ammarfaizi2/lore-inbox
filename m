Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313161AbSDOKGv>; Mon, 15 Apr 2002 06:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313162AbSDOKGu>; Mon, 15 Apr 2002 06:06:50 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21207 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313161AbSDOKGt>; Mon, 15 Apr 2002 06:06:49 -0400
Date: Mon, 15 Apr 2002 15:37:29 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <20020415153729.A1708@in.ibm.com>
Reply-To: suparna@in.ibm.com
In-Reply-To: <1759496962.1018114339@[10.10.2.3]> <m18z80nrxc.fsf@frodo.biederman.org> <3CB1A9A8.1155722E@in.ibm.com> <m1ofgum81l.fsf@frodo.biederman.org> <20020409205636.A1234@in.ibm.com> <m1y9fvlfyb.fsf@frodo.biederman.org> <20020411192649.A1947@in.ibm.com> <m1hemil03d.fsf@frodo.biederman.org> <20020412201950.A1443@in.ibm.com> <m1sn60kdbs.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2002 at 11:59:35AM -0600, Eric W. Biederman wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> writes:
> 
> > OK. The crash with bootimg implementation was known to have occasional
> > difficulties when boot got triggered (via panic) while in X -- sometimes 
> > having the console messed up, and on some occasions even hangs.
> > How's been your experience - no problems in kexec'ing from X, 
> > anytime ?
> 
> So far I haven't tried it from X.  Most of my test machines don't have
> video.  When working on a good machine you should be able to return
> the video to the state you got it.
> 
> I'm not quite certain how to handle the crash dump case.
>  
> > That would be machine_kexec, and the kimage struct, right ?
> > So far looks ok, though I haven't looked at it critically. One thing that 
> > that I require was a way to pass information across boots - 
> > maybe that could be done through command line parameters to the new 
> > kernel.
> 
> A command line work work.  You can arbitrary segments so you can pass
> anything that is needed from the user space side.
> 
> > > Version 2.0 is an early beta.  Some idiot yanked EM_486 and a couple
> > > of other symbols out of elf.h from glibc.  Despite the ELF spec says
> > > EM_486 at least should be there.  In any case that is just a debugging
> > > bit and you can safely disable those.  Or do a make -k and compile the
> > > kexec piece, but not the kparam, which isn't really relevant.
> > 
> > I commented out the EM_486 check from the kexec code, and it built
> > cleanly. I was able to boot a 2-way system with it, though it seemed
> > to take a while, perhaps more so because I didn't seem to be getting
> > any of the bootup/startup messages on my console. In one case there were 
> > some INIT respawning messages that came up. Not sure the fact that
> > I'm using a serial console matters.
> 
> A serial console is my usual test case, so that shouldn't affect
> anything.  I'm glad that it worked. 
> 
> For the speed difference my hunch is perhaps you didn't specify your
> normal kernel command line on the command line.  
> 
> Usually I do something like:
> kexec bzImage root=xxx console=ttyS0,9600 blah, blah, blah.
> 

Oh yes, thanks ! I forgot that kexec expects a command line - had become
used to bootimg picking up the current command line and passing it on.
With the right command line it seems to work ok.
It was an fsck that was taking a lot of that time :)

Regards
Suparna

> Mostly kexec is supposed to be the simple test client instead of a
> full fledged interface.
> 
> Eric
