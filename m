Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277728AbRJWPKw>; Tue, 23 Oct 2001 11:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277730AbRJWPKm>; Tue, 23 Oct 2001 11:10:42 -0400
Received: from geos.coastside.net ([207.213.212.4]:57249 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S277728AbRJWPKb>; Tue, 23 Oct 2001 11:10:31 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7fb36bf20f5@[207.213.214.37]>
In-Reply-To: <E15vwNB-00050h-00@the-village.bc.nu>
In-Reply-To: <E15vwNB-00050h-00@the-village.bc.nu>
Date: Tue, 23 Oct 2001 08:10:15 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mochel@osdl.org (Patrick Mochel)
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), pavel@Elf.ucw.cz (Pavel Machek),
        benh@kernel.crashing.org (Benjamin Herrenschmidt),
        jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:53 AM +0100 10/23/01, Alan Cox wrote:
>  > The idea is to allocate all memory in the first pass, disable interrupts,
>>  then save state. Would that work? Or, should some of the state saving take
>>  place with interrupts enabled?
>
>Imagine the state saving done on a USB device. There you need interrupts
>on while retrieving the state from say a USB scanner, and in some cases
>off while killing the USB controller.

Is this a realistic example? That is, is a kernel-side driver likely 
to be able to meaningfully extract state information from a scanner? 
And is it necessary?

And for a scanner, if the current operation is a scan generating a GB 
of data, what happens if the disk subsystem is no longer accepting 
requests?

As Jeff Garzik pointed out, NIC drivers typically don't need to save 
any state at all; it's all recreateable from software structures. 
Perhaps that characteristic can and should be generalized to other 
devices.

In that case, SUSPEND_SAVE_STATE becomes more like SUSPEND_QUIESCE: 
stop accepting new requests, and complete current requests.

"Stop accepting new requests" is nontrivial as well, in the general 
case. New requests that can't be discarded need to be queued 
somewhere. Whose responsibility is that? Ideally at some point where 
a queue already exists, possibly in the requester.
-- 
/Jonathan Lundell.
