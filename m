Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279307AbRK2TSZ>; Thu, 29 Nov 2001 14:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRK2TSP>; Thu, 29 Nov 2001 14:18:15 -0500
Received: from smtp-rt-11.wanadoo.fr ([193.252.19.62]:6354 "EHLO
	magnolia.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S279307AbRK2TSJ>; Thu, 29 Nov 2001 14:18:09 -0500
Date: Thu, 29 Nov 2001 19:50:00 +0100 (CET)
From: Pascal Lengard <pascal.lengard@wanadoo.fr>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: <alan@lxorguk.ukuu.org.uk>, <suonpaa@iki.fi>,
        <linux-kernel@vger.kernel.org>
Subject: Re: apm suspend broken ?
In-Reply-To: <Pine.LNX.4.33.0111020918020.466-100000@h2o.chezmoi.fr>
Message-ID: <Pine.LNX.4.33.0111291943410.17742-100000@h2o.chezmoi.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Nov 2001, Pascal Lengard wrote:

Hello,

For anyone of interest:

I tested plain 2.4.16 and the problems with APM are still there ...

Fn+suspend does work "sometimes" (1 out of 5 tests)

When it does not work, the laptop is stuck in a state with lcd screen lighted (but all black)
pressing Fn+D to turn off the display works and the apm_suspend finish its job (turning off
all other things like fans ...)

Usually when is suspends, it resumes nicely, but sometimes the laptop reboots
instead of resuming ...  thanks for ext3fs !!

Pascal Lengard

> Some news about the APM problem on Dell Latitude C600:
> 
> On Thu, 1 Nov 2001, Stephen Rothwell wrote:
> > Can you try the following patch, please?  This is the relevant part of a
> > patch that was applied to Alan Cox's kernels.
> 
> I tested this patch against 2.4.10-pre12 (first version showing problem)
> and 2.4.13.
> I tested also plain 2.4.13-ac5 since you (Stephen) said that this patch
> was taken from the last Alan kernel.
> 
> Both kernels show the same behaviour, so please read on since 2.4.13-ac5
> is impacted by this bug.
> 
> I tested the patch against 2.4.10-pre12.
> (I had to suppress a line in arch/i386/kernel/dmi_scan.c to make it compile
> since it defined pm_kbd_request_override differently than the definition in
> keyboard.h) The patch seemed to correct the apm behaviour nicely (I use
> 'seem' since I tried it only once in a hurry to test against 2.4.13).
> 
> So I tested the same patch against 2.4.13. It went through without any
> reject, compilation was fine also ... I tested also 2.4.13-ac5 and both
> show the same ill behaviour:
> 
> Fn+Suspend (or launching "apm -s") does not ALWAYS suspend the laptop. 
> Sometimes, it blanks the screen but leaves the lcd light on, the cpu fan is 
> on also. Pressing Fn+D to turn off the lcd light completes the job and the 
> laptop finaly suspends completely.
> Typing "apm -s" shows the same behaviour, it did suspend the laptop ONCE out
> of 12 tests, all other 11 tests required to press Fn+D after to suspend.
> 
> By the way, If I hit ANY key between Fn+Suspend and Fn+D, the keyboard
> is misbehaving after resume: CapsLock is inverted, Ctrl, Shift and Alt
> are dead.
> 
> Under some rare conditions, apm -s works, but in general, asking the bios 
> to turn off the lcd light (Fn+D) helps a lot.
> I guess the keyboard problem is not a real one since if "apm -s" did its job 
> completely I would no chance to press any key before the lcd light goes off.
> 
> Statistically, 2.4.13-ac5 seems to show better luck in suspending (it works
> correctly more often than 2.4.13+patch from Stephen).
> 
> Pascal
> 
> 

