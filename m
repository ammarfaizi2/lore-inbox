Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265525AbUAGNMk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbUAGNMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:12:39 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:60598 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265525AbUAGNMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:12:38 -0500
Date: Wed, 7 Jan 2004 14:02:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Juan Antonio Martinez <jantonio@dit.upm.es>
Cc: linux-kernel@vger.kernel.org, emard@softhome.net
Subject: Re: Joystick Autofire Support for linux
Message-ID: <20040107130257.GA18616@ucw.cz>
References: <20040102160929.GA31075@emard> <1073472408.20464.68.camel@jonsy.dit.upm.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073472408.20464.68.camel@jonsy.dit.upm.es>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 11:46:48AM +0100, Juan Antonio Martinez wrote:

> I'm not the mantainer of XMame since 1999; anyway, i'll try to forward
> your mail to xmame and l-kernel lists
> 
> A few comments on your code an a humble opinion. Note that I'm
> a kernel "observer" not "programmer" :-)
> 
> - Joystick api is too simple: just a syscall to read events and 
> an ioctl's to set device. It's responsability of the user to 
> make polling ant take note on extra features. There are lot of
> devices in Linux kernel that follow this approach

It used to be that way a couple years back. Now it supports
read/select/nonblocking read, etc. You can also query the joystick
configuration (number of buttons and of axes), etc. And if you want
more, you can use the input event interface, which is generic for all
devices in the system, and get even more information from that.

But there is one (and I think a good one) rule for the kernel input
drivers: Never mangle the input data from the device. Interpret it, put
it into a simple event format and pass it to applications. Don't
generate synthetic events, don't invent new buttons which don't exist on
the device, etc, etc. So far this rule helped to keep the drivers sane.

> - DB9 joysticks are really old. If you really want to implement
>  autofire, perhaps a better approach is to make it a generic
> option, not exclusive to db9 joysticks... A doubt: are there
> similar features in HID devices ? (keypads, mouse buttons...)

Autofire? I haven't seen it in any at least remotely recent device.

> - Some middleware already implements autofire features. No real
> need of doing it at kernel level. In fact, i remember some
> games that takes care on it... my very (very) early versions 
> on Xmame, for instance... :-)

That's what I (the person in charge of care for the joystick drivers in
the kernel), think too - the autofire feature is better in some lib
(thinking SDL and the likes), or in apps directly.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
