Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSFFJCM>; Thu, 6 Jun 2002 05:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSFFJCL>; Thu, 6 Jun 2002 05:02:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23821 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315718AbSFFJCJ>;
	Thu, 6 Jun 2002 05:02:09 -0400
Message-ID: <3CFF25E2.1ED9453D@zip.com.au>
Date: Thu, 06 Jun 2002 02:05:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: johnl@golden.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Is there something strange going on with the ext2 Filesystem?
In-Reply-To: <20020606041707.7fac8668.jlmales@yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John L. Males" wrote:
> 
> Hi,
> 
> ***** Please BCC me in on any reply, not CC me.  Two reasons, I am not
> on the LKML, and second I am suffering BIG time with SPAM from posting
> to the mailing list.  Thanks in advance. *****

Don't be silly. Install spamassassin like everyone else.

> Ok, I have been having some odd, to very serious problems with the
> ext2 file system.  The problems seemed to have started when I started
> using the 2.4.x kernels.  Possible suspect are in the 2.4.15-pre5. I
> had used 2.4.9-ac10, 2.4.9-ac18, 2.4.10-ac12, 2.4.13-ac5 in the past
> and a SuSE 2.4.9 varient that was simply had some odd problems, not
> file system related, that I used for a very short one session, and
> short boot.
> 
> There are three basic issues at hand:
> 
>  1) e2fsck 1.19 would hang with a 2.4.x kernel.  Kernel occurred on
> was 2.4.15-pre5, then tried 2.4.13-ac5, and 2.4.9-ac18 and these two
> also had e2fsch hang.  No changes made, just booted to 2.2.19 (current
> at time) on same system as already had 2.4.19 with the OpenWall patch
> and e2fsck run to completion.  I do not recall if there were errors
> detected.  I may have notes on this, as in the comsole messages, but I
> have to do a bit of digging.

Note that e2fsprogs is at version 1.27.  1.19 is rather old.

If it's not a fsck bug, it's conceivably a VM problem.  More
likely it's a lost interrupt from your disk system.
 
>   2) BIG TIME cross node problems, BIG BIG time bit map problems that
> is either realted to the special test programs I have developed for
> testing the kernel VM subsystem, or maybe unrelated.

Can you make these programs available?  

>  Bottom line I
> had real serious problems after this e2fsck wherein many files were
> lost or say the "ps" name entry no longer pointed to the "ps" program,
> but say the Free Pascal compiler.  There were a number of these messes
> and so I have since moved back to the 2.2.x kernel series.  There had
> been "smaller scale" problems like these, but not with cross
> linked/duplicae nodes or the like with other 2.4.x kernels before
> 2.4.15-pre5.  I therefore feel there is a problem sitting about that
> may not have been addressed yet.  I have no notes on this as these
> problems were with the root file system and I had no ability to hold
> the messages and try to copy the, at times, several hundred, numbers,
> messages.  For my other mounts I can as I have XFree up at that time
> and can cut and past the console messages into an editor and save the
> messages and all.

Sounds like hardware, and/or a buggy driver which wasn't buggy
in 2.2.

How many systems have you been able to reproduce this on?
 
>  3) I am starting to see a parallel even not that I have been using
> the 2.2.19/2.2.20 kernel for a number of months now.  The parallel is
> when the file system gets full, I will skip how this happens but it
> does frequently in what things I do, either the next boot of the
> system or the next scheduled e2fsck reults in various bitmap, wrong
> group, directory counts, etc.  The number of times this has happened
> is more than suggestive of a problem.

I can well believe that.  We've had several ENOSPC bugs, and
they were (hopefully) fixed in kernels which are later than
the ones you've been testing.

>  I currently do not have the
> time or a "current" mainstream release of Linux to try testing my
> theory on this without risking my one and only Linux day to day use
> system.  I am trying to find time and current distribution I can
> download over 56K modem line to do such a test.  I aslo need to see if
> my VM tests are a factor, as in when the kernel is stressed in the VM
> context, it has secondary negative effects.  Not to mention seeing
> what progress the VM subsystem has made.  My last check with
> 2.4.15-pre5 was ok, but still many problems.

2.4.14/2.4.15 VM was pretty rough.  Suggest you grab a current
vendor kernel or 2.4.19-pre10.
 
>   4) Now in past few days I had a case where the system was shut down
> normally,  Then started again next day for a few hours of very light
> activity and shut down again normally,  Then the next startup there
> are group/directory count problems, and bitmap problems.  All after
> two clean shutdowns and no mount/device full conditions during any of
> these prior sessions.

That's too easy.  Again, busted hardware, memory or driver.
 
> In conclusion, I think there needs to be some more formalized and
> specific QA/Testing testing of file systems.  The conditions to be
> tested needs to bacome a formal and routine part Linux kernel testing.

The vendors do a lot of testing.  (pretty lame testing IMO, but
they do their best ;))

>  I realize it can be time consuming, but there can be "creative" ways
> and techniques applied to ease the effort and automate the process to
> a great extent I am sure.

Automation doesn't help for much but regression testing.  Because
you're always running the same test.  The most valuable test lab
is the people who use this software daily, and report stuff.

>  From my ongoing experiences the ext2 file
> system with regard to device/file system full conditions, using
> different block sizes, inode density configurations, and kernel stress
> conditions are key starting elements in such a ongoing sanity check of
> the kernel.  I would expect all the other file systems to be put
> throught the generic file system tests as well as in combination with
> their own specific file system configurations/options.  I happened not
> to take the defaults and therefore these may not have been tested at
> all or not very well tested for any file system, not just the ext2
> file system.

Please send a detailed bug report which will enable a developer to
reproduce these problems.
 
> I would like to trust Linux with its file system management, as I can
> tell you first hand The Other OS has big time problems, on a routine
> basis with thw two primary file systems it uses.  I know from first
> hand experience, BIT TIME.  I can tell you I am not your average user,
> and I know there are many very large installations that have used
> Linux under what are believed stressful and demanding uses over
> several hours.  All I can tell you is for some reason I seem to break
> the general 80/20 rule more often and my uses of systems tend to be
> more a 70/30 or 60/40 split.
> 
> For that reason I seem to encounter and find by "accident" more
> problems than others in my day to day use of systems.  I will not tell
> you what happens when I actually try to test and break software to
> validate its design/stability/duty cycles.

You sound like a useful chap.  Please send those detailed bug
reports.  (But please verify them on a different machine first).
 
> ...
> ==================================================================
> Please BCC me by replacing yahoo.com after the "@" as follows"
> TLD =         The last three letters of the word internet
> Domain name = The first four letters of the word software,
>               followed by the last four letters of the word
>               homeless.

softless.net ain't registered.   ihbt.

-
