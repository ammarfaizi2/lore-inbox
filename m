Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270124AbUJTNJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270124AbUJTNJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 09:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270068AbUJTNHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 09:07:01 -0400
Received: from styx.suse.cz ([82.119.242.94]:50054 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S270205AbUJTNEP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 09:04:15 -0400
Date: Wed, 20 Oct 2004 15:04:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: mightyquinn@letterboxes.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make kbtab play nice with wacom_drv in Xorg/XFree86
Message-ID: <20041020130447.GA8086@ucw.cz>
References: <1098271641.26932.12.camel@sayuki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098271641.26932.12.camel@sayuki>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 07:27:21AM -0400, Dave Ahlswede wrote:

> In its current state, the kbtab driver can be made to work with the
> XF86/Xorg Wacom driver, but only once per modprobe. If X is restarted,
> the driver won't report any input events. This is because the driver
> always reports the pen tool as being in use, and the information doesn't
> seem to be passed after the first time the device is opened.
> 
> This patch fixes the issue by causing the driver to briefly report the
> pen not in use each time the device is opened. 

It's a bug in the X Wacom driver that it doesn't check the initial state
of the tool. It should use EVIOCGKEY() to do that.

A good way to get this working in the driver would be report the PEN
tool as not in use when the position is invalid (the pen is not within
reach), if that is possible with the hardware. It's what the bit should
signify.

> Also, while the specs say the tablet is supposed to have 256 levels of
> pressure sensitivity, it only seems to report 0-127 on both tablets that
> I have access to. This patch changes the reported bounds to cooperate
> better with Gimp 2.1.

No problem with that.

> To actually use this in X, it may require the latest stable driver from
> http://linuxwacom.sourceforge.net

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
