Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964876AbWDMKw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964876AbWDMKw6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 06:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWDMKw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 06:52:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:10914 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751240AbWDMKw5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 06:52:57 -0400
Date: Thu, 13 Apr 2006 12:53:06 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Aubrey <aubreylee@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it a bug of ./include/linux/input.h?
Message-ID: <20060413105306.GA5751@suse.cz>
References: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 05:42:17PM +0800, Aubrey wrote:
> Hi all,
> 
> I encountered a problem when I compiled an input event test program "evtest".
> The program included a kernel header file "input.h". Some parts of the
> "input.h" file:
> ==========================================================
> #ifdef __KERNEL__
> #include <linux/time.h>
> #include <linux/list.h>
> #include <linux/device.h>
> #include <linux/mod_devicetable.h>
> #else
> #include <sys/time.h>
> #include <sys/ioctl.h>
> #include <asm/types.h>
> #endif
> .............
> struct input_device_id {
> 
>         kernel_ulong_t flags;
> 
>         struct input_id id;
> 
>         kernel_ulong_t evbit[EV_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t keybit[KEY_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t relbit[REL_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t absbit[ABS_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t mscbit[MSC_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t ledbit[LED_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t sndbit[SND_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t ffbit[FF_MAX/BITS_PER_LONG+1];
>         kernel_ulong_t swbit[SW_MAX/BITS_PER_LONG+1];
> 
>         kernel_ulong_t driver_info;
> };
> ===========================================================
> The compilation error was caused by the type "kernel_ulong_t". When
> define __KERNEL__, the type "kernel_ulong_t" will be defined in the
> another header file "mod_deviceable.h".
> So, if an user space application will include the "input.h", of course
> the macro __KERNEL__ is not defined. Consequently, the application can
> not be built.
> 
> >From my point of view, since the type "kernel_ulong_t" in the struct
> input_device_id depends on the macro __KERNEL__, the struct
> input_device_id should also depend on the macro. It shouldn't expose
> to the user space.
> 
> I'd like to make a patch about it. Is it acceptable?
 
Dmitry Torokhov has already fixed that in his tree, a fix should be
available reasonably soon.

-- 
Vojtech Pavlik
Director SuSE Labs
