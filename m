Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280790AbRKOJZ5>; Thu, 15 Nov 2001 04:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280795AbRKOJZq>; Thu, 15 Nov 2001 04:25:46 -0500
Received: from mailhost.cendio.se ([193.180.23.130]:24573 "EHLO mail.cendio.se")
	by vger.kernel.org with ESMTP id <S280790AbRKOJZg>;
	Thu, 15 Nov 2001 04:25:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with Linux 2.4.15-pre4 on an IBM ThinkPad
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
From: Martin Persson <martin@cendio.se>
Date: 15 Nov 2001 10:25:34 +0100
In-Reply-To: torvalds@transmeta.com's message of "Mon, 12 Nov 2001 11:01:56 -0800 (PST)"
Message-ID: <vwk7wsv10x.fsf@akrulino.lkpg.cendio.se>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've got the thing moving after applying Linus patch. It even
solved the annoying problem I had with having to eject and insert my
Xircom-card to make it work properly with Linux after boot (I just got
the beep-boop-response when the computer tried to initialize pcmcia at
boot). It also solves the problem that the kernel panicked while
trying to mount the root after a warm reboot.

However (there's always a however), now I have other problems with my
laptop. The network comes right up and everything works just fine,
except when I try to scp files on a few Mbytes from the laptop. When I
try that, sometimes the scp just works nicely up to 99% where it
stalls, sometimes it continues after a few seconds, sometimes it
stalls infinitely (or at least for more than 10 minutes, I interrupted
it). Typical like this:

test.foo             100% |*****************************|  4222 KB    00:11    
test.bar              99% |**************************** |  3364 KB  - stalled -

I can reproduce it. Interesting enough, it only seems to appear when I
scp from the sshd on the laptop with a client on my workstation. If I
scp to the laptop from my workstation or run scp on my laptop against
the sshd on the workstation (any direction), things seems to work just
fine. This does not happen under the 2.4.9-kernel I used before (I've
double-checked).

ssh-version on the workstation is openssh-2.2.0p1-2 and on the laptop
it's pure ancient (ssh-1.2.27-5i). It never connects outside firewalls
anyway (bad excuse, I know).

Another problem I have is that the kernel doesn't seem to be able to
power down the laptop at halt. It did it just perfectly under 2.2, has
done it stocastically under 2.4.9, but 2.4.15pre4 doesn't seem able to
do it at all. My Win98 (double boot) is however quite capable to shut
down the machine. APM is set to:

CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
CONFIG_APM_CPU_IDLE=y
CONFIG_APM_DISPLAY_BLANK=y
CONFIG_APM_RTC_IS_GMT=y
# CONFIG_APM_ALLOW_INTS is not set
CONFIG_APM_REAL_MODE_POWER_OFF=y

The REAL_MODE_POWER_OFF is set just as an experiment to see if it
improved things. It did not. The same setup (minus the
REAL_MODE_POWER_OFF) works so-so with the 2.4.9.

The machine is an IBM ThinkPad 570 (the one with a PII on 333 MHz),
the PCcard is a Xircom Cardbus Combicard with 10/100 TP and 56 kbit
modem and I'm using the new driver out of curiousity.

Finally, more curiousity: What is kapm-idled? I've never heard about
it before, so I got quite curious when I saw that my laptop suddenly
never were idle.
