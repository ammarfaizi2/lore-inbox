Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUFDOyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUFDOyZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUFDOyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:54:25 -0400
Received: from ee.oulu.fi ([130.231.61.23]:28317 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264384AbUFDOyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:54:23 -0400
Date: Fri, 4 Jun 2004 17:54:10 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
In-Reply-To: <20040529131406.GB6185@ucw.cz>
Message-ID: <Pine.GSO.4.58.0406041732200.9609@stekt37>
References: <Pine.GSO.4.58.0405281654370.3992@stekt37> <20040529131406.GB6185@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 May 2004, Vojtech Pavlik wrote:

>On Fri, May 28, 2004 at 04:59:55PM +0300, Tuukka Toivonen wrote:
>> Giuseppe Bilotta wrote:
>> >The new system has some ups and downs. The biggest "down",
>> >which is that of RAW mode not being available anymore (it's
>> >emulated!) could be circumvented by having both the RAW and
>> >translated codes move between layers.
>> Ouch! If the user asks for raw mode, he doesn't get it, but some emulated
>> mode? To me this sounds like a big incompatibility.
>
>Q1: What would you do if the user has an USB keyboard?

If an application wants to access directly the keyboard, and the keyboard
happens to be USB, it should use other means to access it. I believe usbfs
provides some kind of interface for driving directly USB devices.

>Q2: What application should be looking at the raw data outside the
>    kernel and why?

If there are no such programs, why the raw mode emulation is there then?
And if there are such programs, you should ask from those who have made
the programs. But I'll give here couple of possible reasons.

One reason is that someone wants to use the kernel in a
microkernel-like fashion, implementing keyboard driver in userspace.
Keyboards sound like a good candidate for userspace because they are
low-speed. Yeah, I agree there are also reasons why they should not be driven in
userspace, but don't want to argue now which is better.

Another reason is that previously Linux didn't offer event-based
interface to keyboards without raw mode. So, if some program needed to know
all keypress and release events, the only choice might have been the raw
mode. For these programs emulation makes perfect sense for backwards
compatibility.

I was thinking the first reason when I said the above, but the second
is likely more important in practice.
