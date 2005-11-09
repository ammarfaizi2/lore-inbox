Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbVKIUz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbVKIUz2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVKIUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 15:55:28 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:1179 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750788AbVKIUz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 15:55:28 -0500
Message-ID: <43726269.7020600@tmr.com>
Date: Wed, 09 Nov 2005 15:56:09 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       damir.perisa@solnet.ch, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
References: <20051103220305.77620d8f.akpm@osdl.org>	 <20051104071932.GA6362@kroah.com>	 <1131117293.26925.46.camel@localhost.localdomain>	 <20051104163755.GB13420@kroah.com>	 <1131531428.8506.24.camel@localhost.localdomain>  <437226B2.10901@tmr.com> <1131557221.8506.76.camel@localhost.localdomain>
In-Reply-To: <1131557221.8506.76.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> On Wed, 2005-11-09 at 11:41 -0500, Bill Davidsen wrote:
> 
>>Richard Purdie wrote:
>>
>>>This patch stops CompactFlash devices being marked as removable. They
>>>are not removable (as defined by Linux) as the media and device are 
>>>inseparable. When a card is removed, the whole device is removed from 
>>>the system and never sits in a media-less state.
>>
>>Having used CF devices for some years (since RH 8.0) I'm not sure what 
>>problem you're addressing here. Could you describe what problem you're 
>>having, and also note what current functionality this will change?
> 
> 
> I'll try the explanation once more assuming you failed to understand the
> previous messages in this thread and those linked to in the link I
> provided to a thread about this.

Given the large number of possible valid configurations, I'm trying to 
determine which you are trying to fix and if that will break the others.
> 
> Block devices have a "removable" flag. This flag is defined to indicate
> devices where the media can change. A property of these devices is that
> the device node and device stay around and media may or may not be
> present at any one time. Examples of such devices are floppy and ide cd
> drives.
> 
> When you remove a CF card, the controller is removed with the card and
> nothing to do with the CF card or the device exists anymore. They are
> therefore not removable devices in the linux definition of the term.
> 
> Currently the removable flag is set for CF cards. This is incorrect as a
> CF device and interface either exists or doesn't. There is no media-less
> state.
> 
> This incorrect setting causes loops with udev scripts requiring
> userspace hacks to stop things looping. 
> 
> The patch therefore correctly sets the removable flag and removes some
> unneeded code. 
> 
> This shouldn't break anything in userspace apart from anything that
> incorrectly interprets the removable flag as being something its not.
> 
There are, at minimum, three possible hardware attach cases, each of 
which may be on a distribution which uses udev or not. I'm assuming that 
if this is a udev problem is would be fixed at the udev level, but your 
comment on "userspace hacks" does sound like fixes to userspace bugs.

The three attach methods are pcmcia, direct plugin slots (laptops only 
AFAIK), and USB devices.

It seems that the pcmcia cases for laptops and desktops are the same, 
and the whole media and device go away as a unit with the card. But for 
USB and direct plug-in, the "device" seems to be present even without 
media. I can't easily check that for laptop before tonight, but attached 
USB devices show up as sdX currently, with or without media. That's on 
an older kernel, I'll check 2.6.13 tonight.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
