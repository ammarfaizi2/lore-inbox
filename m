Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWHNQF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWHNQF4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWHNQFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 12:05:55 -0400
Received: from pih-relay04.plus.net ([212.159.14.131]:53913 "EHLO
	pih-relay04.plus.net") by vger.kernel.org with ESMTP
	id S1751134AbWHNQFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 12:05:55 -0400
Message-ID: <44E09EFA.2040308@mauve.plus.com>
Date: Mon, 14 Aug 2006 17:04:10 +0100
From: Ian Stirling <ian.stirling@mauve.plus.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Dmitry Torokhov <dtor@insightbb.com>,
       =?ISO-8859-1?Q?Magnus_Vigerl=F6?= =?ISO-8859-1?Q?f?= 
	<wigge@bigfoot.com>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: input: evdev.c EVIOCGRAB semantics question
References: <200608121724.16119.wigge@bigfoot.com>	 <20060812165228.GA5255@aehallh.com>	 <200608122000.47904.dtor@insightbb.com>	 <20060813032821.GB5251@aehallh.com>	 <d120d5000608140720o4e8cc039u278fea6ccc0aae07@mail.gmail.com>	 <20060814142826.GD5251@aehallh.com> <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
In-Reply-To: <d120d5000608140800u329b9e9t1984ba19b6464bf1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 8/14/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
>> On Mon, Aug 14, 2006 at 10:20:09AM -0400, Dmitry Torokhov wrote:
>> >

>> xf86-input-evdev will more or less happily continue talking to a mouse
>> that it can't grab, however things become somewhat more problematic when
>> it comes to keyboards.
>>
>> X needs to keep the keyboard driver from receiving events while it has
>> it open
> 
> Keyboard... can't X just ignore data from old keyboard driver while
> evdev-based keyboard driver is used?

Apart from the other issues, it'd be nice to be able to have some way to 
disable 'keyboards'.

For example, I have some CM108 based audio USB cards, which come with 3 
(event generating) keys. These generate events for F13,F14,'help'.
Of course I can do something in my X wm config to get them to do stuff - 
but this is hardly ideal, especially for headless machines, or whatever.
And it utterly breaks if I want to distinguish between 'F13' being 
pressed on the audio device in the kitchen, and the one in the lounge, 
or I want to stop X.
evdev works just fine for this. I'd love to have some way to say 'this 
should never be a core keyboard' - and have it generate no keyboard
events, only output stuff on evdev. As another example - I might like to 
have an unsecured keyboard, to which I can point X - but I never want it 
to allow magic sysrq, or to generate console events if the system isn't 
running X.

The lack of unique per-device IDs is of course really annoying in this case.
