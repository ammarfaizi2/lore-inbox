Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262361AbVA0QPV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbVA0QPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbVA0QPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:15:21 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:37509 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262361AbVA0QPL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:15:11 -0500
Date: Thu, 27 Jan 2005 17:15:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/16] New set of input patches
Message-ID: <20050127161518.GA14020@ucw.cz>
References: <200412290217.36282.dtor_core@ameritech.net> <20050113153644.GA18939@ucw.cz> <d120d50005011309526326afef@mail.gmail.com> <20050113192525.GA4680@ucw.cz> <d120d50005011312166fd03c56@mail.gmail.com> <d120d50005012706045b2e84af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005012706045b2e84af@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 09:04:06AM -0500, Dmitry Torokhov wrote:
> Vojtech,
> 
> I have dropped the patches that have already been applied and
> re-diffed the remaining patches. I have also merged Adrian's global ->
> static cleanup and 2 patches from Prarit Bhargava (one re: releasing
> resources acquired by i8042_platform_init if controller initialization
> fails and the other is re: making educating guess whether controller
> is absent or really times out).
> 
> There also was couple of additional changes - serio drivers now use
> MODULE_DEVICE_TABLE to export information about the ports they can
> possible work with; serio core exports port's type, protocol, id and
> "extra" data as sysfs attributes and there is hotplug function to
> signal userspace about new port. This all was done so that hotplug can
> automatically load appropriate driver (for example psmouse) when a new
> port is detected. I have patches for module-init-tools and hotplug
> scripts that I will sent to Greg and Rusty as soon as you take the
> pathes (if you will).
> 
> I think that the very first path ("while true; do xset led 3; xset
> -led 3; done" makes keyboard miss release events and makes it
> unusable) should go in 2.6.11 so please do:
> 
>         bk pull bk://dtor.bkbits.net/for-2.6.11

Pulled, pushed into my tree. I verified the patch, and it is indeed
correct. Before we get an ACK for a command we sent, we still may
receive normal data. After we got the ACK we know for sure that no more
regular data will come, and can expect the command response.

> That repository has only this change. The rest of the patches are in
> my usual repository:
> 
>         bk pull bk://dtor.bkbits.net/input
> 
> I am not sending the patches separately as they had been posted to the
> lists couple of times already.

OK. I'll go through them, and apply as appropriate. I still need to wrap
my mind around the start() and stop() methods and see the necessity. I
still think a variable in the serio struct, only accessed by the serio.c
core driver itself (and never by the port driver) that'd cause all
serio_interrupt() calls to be ignored until set in the asynchronous port
registration would be well enough.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
