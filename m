Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWDMLyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWDMLyp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDMLyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:54:45 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:4168 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964891AbWDMLyp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:54:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pE/eyGB3XVW8ZJCj6FlByKjmJjDlxKpE0/RqmFxK/IzNRYw7MFxD3XsHf46v2VwbW8ff4KHUQP7ilqtuvCe8cVewnNd0IheZBaq18RP4MApVzlK0lmXyFlOeHXRHtSKn4Yp0C0K6+tPR9w6YS2Xj8WmPkumLub4FvFaujcbTQ8Q=
Message-ID: <6d6a94c50604130454t7aa046bx76f729716207a744@mail.gmail.com>
Date: Thu, 13 Apr 2006 19:54:43 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it a bug of ./include/linux/input.h?
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, dtor_core@ameritech.net
In-Reply-To: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech,

I pull input git tree
fromgit://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git and
didn't see any change about this issue. You know, I can't just add a
macro to the structure like this:
========================================================
#ifdef __KERNEL__
 struct input_device_id {
......
        kernel_ulong_t flags;
......
}
#endif
========================================================
Because there is another file in the kernel using the header file "input.h",
it's ./script/mod/file2alias.c.

Dmitry - It would be great if you can send the patch to me first.
Thanks a lot.

Regards,
-Aubrey


On 4/13/06, Aubrey <aubreylee@gmail.com> wrote:
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
> From my point of view, since the type "kernel_ulong_t" in the struct
> input_device_id depends on the macro __KERNEL__, the struct
> input_device_id should also depend on the macro. It shouldn't expose
> to the user space.
>
> I'd like to make a patch about it. Is it acceptable?
>
> Regards,
> -Aubrey
>
