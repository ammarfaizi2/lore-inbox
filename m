Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWDMJmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWDMJmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWDMJmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:42:21 -0400
Received: from nproxy.gmail.com ([64.233.182.184]:55277 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964863AbWDMJmV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:42:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=drmGvoWdq+sL2/90gf9Gj1oiTxFvl3UBksr2z1/X5e3Z1V1lKhe9Q9BqSpBbrJZHKf5Krk104vZsfcpevTZ6HPzOghQC4w9izHFRPzxoXDDm7Lkgo6wcuuUNyfkSuxzcZBBuIqsFs5WscYa9QhNgjTXrimbel2Yx3SfQVu+45MA=
Message-ID: <6d6a94c50604130242pecff7a1sbd994976e1f24ba@mail.gmail.com>
Date: Thu, 13 Apr 2006 17:42:17 +0800
From: Aubrey <aubreylee@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is it a bug of ./include/linux/input.h?
Cc: "Vojtech Pavlik" <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I encountered a problem when I compiled an input event test program "evtest".
The program included a kernel header file "input.h". Some parts of the
"input.h" file:
==========================================================
#ifdef __KERNEL__
#include <linux/time.h>
#include <linux/list.h>
#include <linux/device.h>
#include <linux/mod_devicetable.h>
#else
#include <sys/time.h>
#include <sys/ioctl.h>
#include <asm/types.h>
#endif
.............
struct input_device_id {

        kernel_ulong_t flags;

        struct input_id id;

        kernel_ulong_t evbit[EV_MAX/BITS_PER_LONG+1];
        kernel_ulong_t keybit[KEY_MAX/BITS_PER_LONG+1];
        kernel_ulong_t relbit[REL_MAX/BITS_PER_LONG+1];
        kernel_ulong_t absbit[ABS_MAX/BITS_PER_LONG+1];
        kernel_ulong_t mscbit[MSC_MAX/BITS_PER_LONG+1];
        kernel_ulong_t ledbit[LED_MAX/BITS_PER_LONG+1];
        kernel_ulong_t sndbit[SND_MAX/BITS_PER_LONG+1];
        kernel_ulong_t ffbit[FF_MAX/BITS_PER_LONG+1];
        kernel_ulong_t swbit[SW_MAX/BITS_PER_LONG+1];

        kernel_ulong_t driver_info;
};
===========================================================
The compilation error was caused by the type "kernel_ulong_t". When
define __KERNEL__, the type "kernel_ulong_t" will be defined in the
another header file "mod_deviceable.h".
So, if an user space application will include the "input.h", of course
the macro __KERNEL__ is not defined. Consequently, the application can
not be built.

>From my point of view, since the type "kernel_ulong_t" in the struct
input_device_id depends on the macro __KERNEL__, the struct
input_device_id should also depend on the macro. It shouldn't expose
to the user space.

I'd like to make a patch about it. Is it acceptable?

Regards,
-Aubrey
