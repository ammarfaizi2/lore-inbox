Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278949AbRKAN5X>; Thu, 1 Nov 2001 08:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278951AbRKAN5M>; Thu, 1 Nov 2001 08:57:12 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:37785 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S278949AbRKAN5J>;
	Thu, 1 Nov 2001 08:57:09 -0500
Date: Thu, 01 Nov 2001 13:57:04 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Riley Williams <rhw@MemAlpha.cx>, Kurt Roeckx <Q@ping.be>
Cc: Ian Maclaine-cross <iml@ilm.mech.unsw.edu.au>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Ian Maclaine-cross <iml@debian.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: PROBLEM: Linux updates RTC secretly when clock synchronizes
Message-ID: <1301130987.1004623024@[10.132.113.67]>
In-Reply-To: <Pine.LNX.4.21.0111010045050.28028-100000@Consulate.UFP.CX>
In-Reply-To: <Pine.LNX.4.21.0111010045050.28028-100000@Consulate.UFP.CX>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Thursday, November 01, 2001 12:52 AM +0000 Riley Williams 
<rhw@MemAlpha.cx> wrote:

> The offset needs to be sufficient to handle the case of the RTC being
> set to local time and the boot and first ntp sync occurring on opposite
> sides of a Daylight Savings Time change. A couple of timezones use a DST
> offset of 90 minutes, so if it's less than that, there will be problems.

There is a related problem, where if you are running something which
can suspend, like a laptop, but not using integrated apm to do it (for
instance a laptop which has a broken BIOS), then suspending 'freezes'
the system time, which is wrong on resume (as the power management
event appears to be invisible to Linux). Then this goes and blats
over the (correct) RTC time. If you then get a network connection up,
ntp won't adjust the time as it's too far out. What I wanted was
an option which did the copy the other way on a large offset - i.e.
keep the RTC in sync for smallish offsets, but if the offset is
wrong by more than 5 minutes (and RTC is in advance), copy RTC to
system time as the laptop probably suspended. There might of course
be a better hueristic to detect this (perhaps every time it does
the check see if it got out of sync by > the interval between
checks). Short of this, it would be useful to be able to turn /off/
futzing with the rtc.

--
Alex Bligh
