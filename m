Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbUCFWog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 17:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbUCFWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 17:44:35 -0500
Received: from pop.gmx.de ([213.165.64.20]:25572 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261722AbUCFWoa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 17:44:30 -0500
X-Authenticated: #11949556
From: Michael Schierl <schierlm-usenet@gmx.de>
To: Antony Dovgal <tony2001@phpclub.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM & device_power_up/down
Date: Sat, 06 Mar 2004 23:44:08 +0100
Reply-To: schierlm@gmx.de
References: <1uQOH-4Z1-9@gated-at.bofh.it>
In-Reply-To: <1uQOH-4Z1-9@gated-at.bofh.it>
X-Mailer: Forte Agent 2.0/32.646
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-Id: <S261722AbUCFWoa/20040306224430Z+905@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Mar 2004 09:20:07 +0100, in linux.kernel you wrote:

>Hi all!
>
>I've tried to contact Pavel Machek directly, but got no response from him, so I'm forwarding the letter to the list.
>
>The problem is: 
>the patch, that was provided here: 
>http://marc.theaimsgroup.com/?l=linux-kernel&m=107540713415651&w=2, 
>prevents my laptop from suspending.

Hmm. Can you try unapplying it and applying the one in 

http://marc.theaimsgroup.com/?l=linux-kernel&m=107506063605497&w=2

instead? Does it work for you as well as with no patch?

>This behaviuor was firstly noticed after upgrade from 2.6.1 to 2.6.2 (and 2.6.3 doesn't fix it).

>So I decided to do a small investigation and discovered that when I 
>remove calls to device_power_*() from apm.c, it works well.

My situation is the other way round. I was always unable to suspend my
laptop under Linux until I tried the 2.5.x series first. That one
worked; however, in 2.6.0-test4 someone did some major changes and
removed these two calls as well. So I could not suspend in 2.6.0-test4
till 2.6.1, now U can again :-)

>Of course, the problem can be in my laptop's BIOS or wherever, but, I 
>repeat, it works well with 2.4.x & 2.6.1 and it doesn't with 2.6.2 & 
>2.6.3.

Same for me. Dunno if my or your BIOS is borked, but one is surely
broken.

>At this moment I can hardly understand why there is need to power down 
>devices after suspend (shouldn't they be powered down in the suspend 
>process?), but I'm not a kernel hacker.

Where do you read something about powering down devices after suspend?

The process is:

1- suspend devices

2- (power down devices w/ my patch)

3- asm call to put cpu in suspend mode - it will not return 
   until you wake it up again

4- (power up devices w/ my patch)

5- resume devices

>So, any help is appreciated.

HTH,

Michael
-- 
My PGP Key: User ID: Michael Schierl <schierlm@gmx.de>
Key ID: 0x58B48CDD    Size: 2048    Created: 26.03.2002
Fingerprint:  68CE B807 E315 D14B  7461 5539 C90F 7CC8
http://home.arcor.de/mschierlm/mschierlm.asc
