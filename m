Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWDLRxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWDLRxu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWDLRxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:53:50 -0400
Received: from mail.gaiaonline.com ([72.5.72.76]:58304 "EHLO gaiaonline.com")
	by vger.kernel.org with ESMTP id S932206AbWDLRxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:53:49 -0400
Message-ID: <443D3E72.1050408@rydia.net>
Date: Wed, 12 Apr 2006 10:52:50 -0700
From: dormando <dormando@rydia.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: x86_86 SMP megaraid_mbox hangups and panics.
References: <890BF3111FB9484E9526987D912B261901BCC1@NAMAIL3.ad.lsil.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261901BCC1@NAMAIL3.ad.lsil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ju, Seokmann wrote:
> Hi,
>> Most of the time the server hits: "megaraid: probe new device" - with 
>> the device information, then hangs and starts the 180 second 
>> countdown: 
>> "megaraid: wait for FW to boot [blah]"
>> After which I get a VFS panic for not having a root disk.
> This means the controller is NOT taking any commands from the driver at that time.
> In other words, the F/W is NOT ready to take any command, yet.
> It sounds like that the controller is NOT in good condition for some reason and needs to check sanity of it.
> You may want to check with LSI logic SE team.
> 
> Thank you,

Can you confirm that you read my whole message? I might be a complete 
idiot, but let me reiterate some highlights and add a few more details 
from my last mail:

If I build a 32-bit SMP OR 64-bit UP kernel, the cards will boot and 
work *every time*.

Most of the time this is a *kernel panic* in megaraid_ack_sequence, 
somewhere through megaraid_isr in megaraid_mbox.c
*Sometimes* it results in the firmware hanging like you mentioned above.
If I compile the drivers as modules instead of statically, this 
*sometimes* results in the machine booting all the way. Once the machine 
boots up, I can give it a good 'ole I/O beatdown and it does not flinch.

As in: I boot it once, it hangs. I reboot, it panics. I reboot, it 
panics. I reboot, it works. I have 16 cards in 16 systems that all 
exhibit the same behavior. Looks like an x86_64 SMP timing issue of some 
kind to me, and less of a card issue. Please correct me if I am wrong!

-Dormando
