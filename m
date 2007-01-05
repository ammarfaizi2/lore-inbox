Return-Path: <linux-kernel-owner+w=401wt.eu-S1161081AbXAEMn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161081AbXAEMn3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbXAEMn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:43:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:23327 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161081AbXAEMn1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:43:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PG52CHyX/WKgVpAT/M6DgY2jWTCJxznFdPCONx0RaZWdqswsXp9yyxPRvsZGxUzjJKXmBOPvSrhRHzsUp/o303UkqYy+3MVzIYi4/EOCBJnpR+DtBsJ55z0JrBICI0UaW3eyjpMX9pQVWyWgPZvs3Y4KmKyvpG6FwE1mUYl273k=
Message-ID: <3efb10970701050443t3ca6bdf7t1c18aec2b446db0e@mail.gmail.com>
Date: Fri, 5 Jan 2007 13:43:26 +0100
From: "Remy Bohmer" <l.pinguin@gmail.com>
Reply-To: linux@bohmer.net
To: "Dries Kimpe" <Dries.Kimpe@wis.kuleuven.be>
Subject: Re: [BUG-RT] RTC has been stopped-> long delay during boot, soft reboot->GRUB fails to call getrtsecs()
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <459E2F97.3040201@wis.kuleuven.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <459E2F97.3040201@wis.kuleuven.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dries,

Thanks for your reply, but as it looks a lot like the same problem, I
want to mention that we do NOT have a Dell system here. It is a
Fujitsu Siemens i945 motherboard. I also saw the problem about "long
delays during boot by hwclock" on an old i845 Kontron Motherboard,
running the same installation/kernel as I mentioned, which we were
using for years and never showed this problems until we start using
this kernel. The RTC clock that was stopped is only seen twice on this
Fujitsu siemens board, not on any other.

So, as it is not a Dell system ,and we therefor have a different BIOS,
I doubt it is BIOS related. Further, I discovered that the problem
also occured in a system that is not tickless. I can therefor exclude
now that it is NOT related to the CONFIG_NO_HZ option, despite what I
mentioned in my previous mail.

In my case it also was NO battery problem, but removing the battery
was the only way to reset the RTC to get it ticking again.

We have enabled HPET in BIOS and kernel.

I have tested the 2.6.20rc3-rt0 kernel of Ingo (as he suggested) by
booting it a few times, and until now we have not seen this problem,
but the long term will learn if it is really gone.


Kind Regards,

Remy Böhmer



2007/1/5, Dries Kimpe <Dries.Kimpe@wis.kuleuven.be>:
> In-Reply-To: <3efb10970701020838n61db5388l94b2f0ed38073edd@mail.gmail.com>
>
> I found this mail on the LKML.org list, and didn't want to bother to
> subscribe to the list, so I post this directly. Sorry ;-)
>
> I'm suspecting the problem is not related to the rt-kernel at all.
>
> This looks like a well known (but no real solution as far as I know)
> DELL bios problem.
>
> * Somehow, the RTC gets corrupted and stops counting.
> * On recent dell laptops (D420, a.o.) the BIOS sometimes checks the
> clock (everytime a thorough BIOS check is done)
> and just stops with the message "time-of-day clock stopped" (look for
> this on google); On some systems, one can enter the BIOS setup at this
> point,
> causing the bios to reset the clock and solving the problem. On others
> (like the D420), the only problem is to make the B IOS reinitialize the
> clock.
>
> * Once the clock is corrupted, it never runs again (some say a reboot in
> XP can solve it);
>  It is NOT a battery problem. Just disconnecting the battery, causing
> the BIOS to reinitialize NVRAM solves the problem.
>
> I use to have this problem on my D420, and it seemed to go away by:
> - disabling the RTC interrupt in the kernel
> - enabling the HPET timer RTC emulation
>
> More info:
> http://www.ubuntuforums.org/showthread.php?t=176954
> http://www.ubuntuforums.org/showthread.php?t=149565
> https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/43745
>
> Hope this helps.
>
>  Greetings,
>  Dries
>
>
>
> Disclaimer: http://www.kuleuven.be/cwis/email_disclaimer.htm
>
