Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310298AbSCLBeZ>; Mon, 11 Mar 2002 20:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310299AbSCLBeP>; Mon, 11 Mar 2002 20:34:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310298AbSCLBeG>;
	Mon, 11 Mar 2002 20:34:06 -0500
Message-ID: <3C8D5AF6.8070602@mandrakesoft.com>
Date: Mon, 11 Mar 2002 20:33:42 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com> <3C8D4D12.90606@mandrakesoft.com> <20020312005840.GA13955@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>On Mon Mar 11, 2002 at 07:34:26PM -0500, Jeff Garzik wrote:
>
>>Reason 1: Standard kernel convention.  In other ioctls, we check basic 
>>arguments and return EINVAL when they are wrong, even for privieleged 
>>ioctls.
>>
>
>I have no argument with basic command validation.  But take a
>look at ide_cmd_type_parser(), for example.  Do we really need a
>giant switch statement listing all the allowed commands, just so
>we can throw back a IDE_DRIVE_TASK_INVALID to user-space if they
>decide to send down some undocumeted firmware wiping commands?
>Especially since that giant struct of allowed commands is
>duplicated in ide_pre_handler_parser() and ide_handler_parser()
>
I agree the implementation could be improved.

Your first question is really philosophical.  I think that people should 
-not- be able to send undocumented commands through the interface... 
 and in this area IMO it pays to be paranoid.

If we wanted to be ultra-super-paranoid, drop the ioctl and taskfile 
parser, and implement the taskfile checks via SMM mode callbacks from 
activity on the IDE ports ;-)  That way we know the NSA is not doing 
something sneaky, as well as supporting unlimited SMP bit-banging from 
userland.  Can you say ug and non-portable even to a lot of ia32 
platforms.  :)

So, the implementation may need improvement, but we do (a) want the 
taskfile ioctl [and one for scsi too], and (b) want to implement some 
amount of mininal sanity checks on the requests.

    Jeff





