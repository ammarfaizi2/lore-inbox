Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVBJNIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVBJNIx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 08:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBJNIx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 08:08:53 -0500
Received: from [195.23.16.24] ([195.23.16.24]:38357 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262111AbVBJNHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 08:07:42 -0500
Message-ID: <420B5C66.8040408@grupopie.com>
Date: Thu, 10 Feb 2005 13:06:46 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, LKML <linux-kernel@vger.kernel.org>,
       Linux-Input <linux-input@atrey.karlin.mff.cuni.cz>
Subject: Re: [RFC/RFT] [patch] Elo serial touchscreen driver
References: <20050208164227.GA9790@ucw.cz> <420A0ECF.3090406@grupopie.com> <20050209170015.GC16670@ucw.cz> <20050209171438.GI10594@lug-owl.de> <20050209173026.GA17797@ucw.cz> <420A518A.9040500@grupopie.com> <20050209195854.GJ10594@lug-owl.de> <420A77DF.6040108@grupopie.com> <20050209213930.GM10594@lug-owl.de> <20050209215335.GA2634@ucw.cz> <20050210104655.GO10594@lug-owl.de>
In-Reply-To: <20050210104655.GO10594@lug-owl.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:
> On Wed, 2005-02-09 22:53:35 +0100, Vojtech Pavlik <vojtech@suse.cz>
> wrote in message <20050209215335.GA2634@ucw.cz>:
> 
>>>That cannot be done. Just hit a resistor-based touchscreen once with a
>>>hammer. You'll probably see that you need a physical recalibration
>>>then... Or flood it with water-solved citronic acid and let is on the
>>>screen for some days. That's funny, but it's real life...
>>
>>You'll need a new touchscreen most likely. The hammer will break the
>>glass if you hit it properly, and if the citric acid gets between the
>>resistive layers, you get nonlinear distortion of the resistivity and
>>that cannot be calibrated for.

Actually, if this is done in a library, we might compensate for 
non-linear distortion, by making a "high resolution" calibration where 
the user has to press a grid of 4x4 points (or something like that) 
instead of just a few of points. The grid would allow non-linear 
calibration.

I'm not suggesting that we can use a touch screen that has citric acid 
moving around between the layers, though :)

> If they were private customers, sure, they'd just buy a new touchscreen.
> But in reality, as long as it somewhat "works", it'll be used as long as
> possible.

We are seriously diverging now....

Let me try to put things into perspective:

   ---------------
  |               |                                        --------
  |  Touch        |          -----------                  |        |
  |  Screen       |---------|    TS     |   serial port   |   PC   |
  |               |       __|controller |-----------------|        |
  |               |      /  |           |                 |        |
   ---------------       |   -----------                   --------
        \_______________/

In a previous post you said:

> 		Basically all these touchscreens are capable of being
> 		calibrated. It's not done with just pushing the X/Y
> 		values the kernel receives into the Input API. These
> 		beasts may get physically mis-calibrated and eg. report
> 		things like (xmax - xmin) <= 20, so resolution would be
> 		really bad and kernel reported min/max values were only
> 		"theoretical" values, based on the protocol specs.

To get raw values that are (xmax-xmin)<=20, the TS controller must be 
"trying" to do some calibration itself.

That's the brain-damaged part.

The TS controller should not be doing any calibration at all, and send 
the widest range it can through the serial port to the PC.

On the PC we must have a library that is capable of scaling / rotating 
those values so that it converts them into "screen absolute" 
coordinates. I call these screen absolute because they shouldn't depend 
on the actual resolution.

So there is no doubt that calibration must be done. We are past that. I 
too work with touch screens in restaurants for more than 10 years now, 
so I surely know what an agrssive environment is, and what damage a 
touchscreen might be exposed to.

So, if the inputattach program initializes the TS controller to make it 
send the widest range (1:1 calibration) it can deliver, we can do all 
the calibration on the PC and not depend on the TS being able to do the 
calibration itself.

Actually a calibration that can do scaling and rotation, can 
automatically compensate for mirroring and/or switched X/Y axes. We 
probably need the user to press 4 points for that, though (3 points are 
enough, but just barely enough).

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
