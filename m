Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSCLG0G>; Tue, 12 Mar 2002 01:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310436AbSCLGZ4>; Tue, 12 Mar 2002 01:25:56 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:23561 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S310435AbSCLGZo>; Tue, 12 Mar 2002 01:25:44 -0500
Date: Tue, 12 Mar 2002 07:25:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: andersen@codepoet.org, Bill Davidsen <davidsen@tmr.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312072538.A4863@ucw.cz>
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com> <3C8D4D12.90606@mandrakesoft.com> <20020312005840.GA13955@codepoet.org> <3C8D5AF6.8070602@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C8D5AF6.8070602@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 11, 2002 at 08:33:42PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 08:33:42PM -0500, Jeff Garzik wrote:
> Erik Andersen wrote:
> 
> >On Mon Mar 11, 2002 at 07:34:26PM -0500, Jeff Garzik wrote:
> >
> >>Reason 1: Standard kernel convention.  In other ioctls, we check basic 
> >>arguments and return EINVAL when they are wrong, even for privieleged 
> >>ioctls.
> >>
> >
> >I have no argument with basic command validation.  But take a
> >look at ide_cmd_type_parser(), for example.  Do we really need a
> >giant switch statement listing all the allowed commands, just so
> >we can throw back a IDE_DRIVE_TASK_INVALID to user-space if they
> >decide to send down some undocumeted firmware wiping commands?
> >Especially since that giant struct of allowed commands is
> >duplicated in ide_pre_handler_parser() and ide_handler_parser()
> >
> I agree the implementation could be improved.
> 
> Your first question is really philosophical.  I think that people should 
> -not- be able to send undocumented commands through the interface... 
>  and in this area IMO it pays to be paranoid.

Why? What if I really want to update the firmware is say my CD-RW, and
it doesn't use any of the ATA-spec commands for that? Should it fail?

I think filtering bad requests is OK - validating stuff like
permissions, concurrent access, pointers, whatever, but the kernel
shouldn't have hardcoded tables of commands that are allowed.

The "right solution", if we really need command filtering is an ioctl
and an utility that can fill a 'filter table', which says which commands
are ok for whom and which are not. Like 'INQUIRY can be used by anyone',
'no, I won't send anything related to CPRM to the drive'. Easy to
implement, no huge case statements needed.

> If we wanted to be ultra-super-paranoid, drop the ioctl and taskfile 
> parser, and implement the taskfile checks via SMM mode callbacks from 
> activity on the IDE ports ;-)  That way we know the NSA is not doing 
> something sneaky, as well as supporting unlimited SMP bit-banging from 
> userland.  Can you say ug and non-portable even to a lot of ia32 
> platforms.  :)
> 
> So, the implementation may need improvement, but we do (a) want the 
> taskfile ioctl [and one for scsi too], and (b) want to implement some 
> amount of mininal sanity checks on the requests.

-- 
Vojtech Pavlik
SuSE Labs
