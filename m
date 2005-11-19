Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVKSJ0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVKSJ0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 04:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVKSJ03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 04:26:29 -0500
Received: from styx.suse.cz ([82.119.242.94]:57790 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750975AbVKSJ03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 04:26:29 -0500
Date: Sat, 19 Nov 2005 10:26:22 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Bart Samwel <bart@samwel.tk>
Cc: Pavel Machek <pavel@ucw.cz>, Bill Davidsen <davidsen@tmr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Laptop mode causing writes to wrong sectors?
Message-ID: <20051119092622.GA13622@midnight.suse.cz>
References: <20051116181612.GA9231@knautsch.gondor.com> <20051117223340.GD14597@elf.ucw.cz> <437E215E.30500@tmr.com> <20051118232019.GA2359@spitz.ucw.cz> <437EE4B3.2090408@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437EE4B3.2090408@samwel.tk>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 09:39:15AM +0100, Bart Samwel wrote:
> Pavel Machek wrote:
> >>My laptop also has a spindown (five min from memory) and I have yet to 
> >>have a problem with it. Don't know if any of that is "spindowns without 
> >>laptopmode" in a useful sense.
> >
> >Unless you can also reproduce the failure... no, probably does not help
> >much.
> 
> Okay, let's recap.
> 
> * There are a lot of people who are not having problems. The people who 
> *are* having problems can usually reproduce them. My interpretation: the 
> problem is triggered by some hardware and/or kernel config settings.
> 
> * A significant proportion of the people who *do* have trouble see 
> messages about DMA timeouts. The problems do also occur on other 
> hardware, but seem to be most pronounced on Thinkpad T40s. On those 
> machines, the DMA timeout problems are triggered *especially* when the 
> madwifi drivers are loaded (see 
> http://bugzilla.ubuntu.com/show_bug.cgi?id=6108).
> 
> Perhaps I should start collection kernel configs and hardware specs, see 
> if there are any unexpected commonalities. The influence of the madwifi 
> drivers suggest that we could be be looking for anything really. What do 
> you think?
 
The issue might be that these people are using

	hdparm -S xxx
	
	or

	hdparm -y / -Y

while a much better way to do

	hdparm -B 63

The -S option should in theory be safe, but I remember some drives did
behave unpredictably if this was used. -y/-Y is much tougher and some
drives will not work reliably unless first woken up manually before
issuing a read/write request.

On the other hand, -B is pretty safe on drives that support it, and all
IBM notebook drives do.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
