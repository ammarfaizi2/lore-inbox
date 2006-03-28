Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWC1V7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWC1V7I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWC1V7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:59:08 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:45784 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S932401AbWC1V7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:59:06 -0500
Date: Tue, 28 Mar 2006 16:59:02 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Possible breakage in 2.6.16?
In-reply-to: <Pine.LNX.4.61.0603281621210.24785@chaos.analogic.com>
To: linux-kernel@vger.kernel.org,
       "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Reply-to: gene.heskett@verizononline.net
Message-id: <200603281659.03100.gene.heskett@verizon.net>
Organization: Organization? Absolutely zip.
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <200603281244.24906.gene.heskett@verizon.net>
 <200603281603.53561.gene.heskett@verizon.net>
 <Pine.LNX.4.61.0603281621210.24785@chaos.analogic.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 16:29, linux-os (Dick Johnson) wrote:
>On Tue, 28 Mar 2006, Gene Heskett wrote:
>> On Tuesday 28 March 2006 13:19, linux-os (Dick Johnson) wrote:
>>> On Tue, 28 Mar 2006, Gene Heskett wrote:
>>
>> Dick, this may be a resend to you, but I can't find it in my
>> sent-mail box.  Honest, I did go thru the motions :)
>>
>>>> Greetings;
>>>>
>>>> Always curious as to what sort of information can be extracted
>>>> from the tools linux gives us, I've discovered that netstat, from
>>>> the
>>>>
>>>> net-tools-1.60-25.1 rpm
>>>>
>>>> no longer functions for anything as even a 'netstat --version'
>>>> takes the curser to the upper left corner of the screen and hangs
>>>> till ctl+c'd.
>>>>
>>>> The only evidence of its execution is a steady, about 2 per
>>>> second, increase in the number of processes running as reported by
>>>> gkrellm, all of which go away when I ctl+c netstat itself.
>>>>
>>>> I'm running 2.6.16 self configured here.
>>>>
>>>> Is this a known problem because my net-tools rpm is old?  Or
>>>> because 2.6.16 broke it?
>>>
>>> strace netstat --version 2>info.txt
>>> ^C
>>>
>>> Then read info.txt and see what it called that doesn't return.
>>
>> It appears strace does about 5-6 pages of its own setup, then this:
>> --------------------open("/root/bin/netstat", O_RDONLY|O_LARGEFILE)
>> = 3 ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xaf86e2e8) = -1 ENOTTY
>> (Inappropriate ioctl for device)
>> _llseek(3, 0, [0], SEEK_CUR)            = 0
>> read(3, "#!/bin/bash\nreset\nwhile [ 1 ] ; "..., 80) = 80
>> _llseek(3, 0, [0], SEEK_SET)            = 0
>> getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
>> dup2(3, 255)                            = 255
>> close(3)                                = 0
>> fcntl64(255, F_SETFD, FD_CLOEXEC)       = 0
>> fcntl64(255, F_GETFL)                   = 0x8000 (flags O_RDONLY|
>> O_LARGEFILE)
>> fstat64(255, {st_mode=S_IFREG|0755, st_size=124, ...}) = 0
>> _llseek(255, 0, [0], SEEK_CUR)          = 0
>> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
>> read(255, "#!/bin/bash\nreset\nwhile [ 1 ] ; "..., 124) = 124
>> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
>> stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
>> stat64("/root/bin/reset", 0xaf86e160)   = -1 ENOENT (No such file or
>> directory)
>> stat64("/usr/java/bin/reset", 0xaf86e160) = -1 ENOENT (No such file
>> or directory)
>> stat64("/usr/bin/reset", {st_mode=S_IFREG|0755, st_size=36216, ..})
>> = 0 stat64("/usr/bin/reset", {st_mode=S_IFREG|0755, st_size=36216,
>> ..}) = 0 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
>> _llseek(255, -106, [18], SEEK_CUR)      = 0
>> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
>> SIGCHLD, child_tidptr=0xa7f480c8) = 6558
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
>> rt_sigaction(SIGINT, {0x8074990, [], 0}, {SIG_DFL}, 8) = 0
>> waitpid(-1, tset: standard error: Inappropriate ioctl for device
>>
>> [{WIFEXITED(s) && WEXITSTATUS(s) == 1}], 0) = 6558
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> --- SIGCHLD (Child exited) @ 0 (0) ---
>> waitpid(-1, 0xaf86dee8, WNOHANG)        = -1 ECHILD (No child
>> processes) sigreturn()                             = ? (mask now [])
>> rt_sigaction(SIGINT, {SIG_DFL}, {0x8074990, [], 0}, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
>> read(255, "while [ 1 ] ; do\n\n   netstat -a "..., 124) = 106
>> rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
>> rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
>> pipe([3, 4])                            = 0
>> rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
>> _llseek(255, -1, [123], SEEK_CUR)       = 0
>> clone(tset: standard error: Inappropriate ioctl for device
>>
>> tset: standard error: Inappropriate ioctl for device
>>
>> child_stack=0,
>> flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
>> child_tidptr=0xa7f480c8) = 6559
>> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
>> close(4)                                = 0
>> close(4)                                = -1 EBADF (Bad file
>> descriptor) rt_sigprocmask(SIG_BLOCK, [INT CHLD], [CHLD], 8) = 0
>> clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|
>> SIGCHLD, child_tidptr=0xa7f480c8) = 6580
>> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
>> close(3)                                = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
>> rt_sigprocmask(SIG_SETMASK, [CHLD], NULL, 8) = 0
>> rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
>> rt_sigaction(SIGINT, {0x8074990, [], 0}, {SIG_DFL}, 8) = 0
>> waitpid(-1, tset: standard error: Inappropriate ioctl for device
>>
>> tset: standard error: Inappropriate ioctl for device
>>
>> tset: standard error: Inappropriate ioctl for device
>>
>> tset: standard error: Inappropriate ioctl for device
>> ---------------------
>> And theres a couple more megabytes of that last line till I ctl+c'd
>> it. I did that when gkrellm said it was up to about 990 processes
>> from the normal 220 or so here.
>>
>> But I have NDI what it all _really_ means.  And I just built and
>> rebooted to 2.6.16.1 with no change in this seemingly weird
>> behaviour.
>>
>> Thanks all
>>
>> --
>> Cheers, Gene
>
>The error message comes from `tset`. Some script that runs on startup
>of each of your 990 processes is trying to set a terminal when, in
>fact, there is no terminal associated with the task. Perhaps, your
>new java script is doing something????
>
Took it out, restarted the terminal window, same story.  Its possible 
its been that way since jre-1.5.yadda-06 was put in.  Java, as 
installed by the scripts that install it, is somewhat scattered, and 
much duplicated here and I have NDI whats precious and whats 
disposable.

I have a /usr/java with all these subdirs in it:
[root@coyote root]# ls /usr/java
bin        demo     jre          lib      man          sample   
THIRDPARTYLICENSEREADME.txt
COPYRIGHT  include  jre1.5.0_06  LICENSE  README.html  src.zip  _uninst

And many of these subdirs have identical or nearly identical sized files 
for the same name on a different branchs of the tree.  Some may even 
have come from an older -jdk install for all I know.  Should I nuke the 
whole thing and reinstall just the last one?

>Perhaps associated with this little gem:
>
>read(255, "while [ 1 ] ; do\n\n   netstat -a "..., 124) = 106

I wonder where that little gem came from?  I'm serious, I'd like to 
clean up my $PATH, which is now about 6 lines worth on the screen when 
echo'ed but every damned script under the sun thinks it has to append 
its own version of PATH to the existing one. Buncha crap.

I know, grep -R PATH in /*
:)


>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.15.4 on an i686 machine (5589.42
> BogoMips). Warning : 98.36% of all statistics are fiction, book
> release in April. _
>
>
>****************************************************************
>The information transmitted in this message is confidential and may be
> privileged.  Any review, retransmission, dissemination, or other use
> of this information by persons or entities other than the intended
> recipient is prohibited.  If you are not the intended recipient,
> please notify Analogic Corporation immediately - by replying to this
> message or by sending an email to DeliveryErrors@analogic.com - and
> destroy all copies of this information, including any attachments,
> without reading or disclosing them.
>
>Thank you.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
