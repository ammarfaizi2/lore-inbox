Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWAKIVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAKIVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 03:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWAKIVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 03:21:22 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:23334 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbWAKIVV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 03:21:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AVuHJyivmLBF6XOp/lECAfXaXrY3XgnHrFdjpKGBxFKtLpuybtmg7d/jppi+MiVUKd+CLXeKh8z5zo9VJO2MGWxY73d5Cnm3bJVz2QXWJhwhtTVGU1g2+8g8rS3BaAHUGgv89o/Me+7wAqlxhpTmMSFfjrutWiZ0dKtRdQDjS1E=
Message-ID: <25ac9de40601110021r3e8d5075v6a5a7186533a4c8a@mail.gmail.com>
Date: Wed, 11 Jan 2006 02:21:21 -0600
From: Patrick Read <pread99999@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: PROBLEM: Oops in Kernel 2.6.15 usbhid
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200601100054.51198.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <25ac9de40601052225i48bca97dx3ad796a1cd68f1c3@mail.gmail.com>
	 <200601100054.51198.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> On Friday 06 January 2006 01:25, Patrick Read wrote:
> > [1.] Oops in Kernel 2.6.15 usbhid
> >
> > [2.] Compiled 2.6.15 downloaded from kernel.org.  Configured, made,
> > and installed.  During reboot, I get an Oops in the USB HID module.
> > This does not occur with a nearly-identical config on the same
> > computer with kernel 2.6.14.5.
> >
> > [3.] USB, HID, kernel, 2.6.15, module
> >
>
> Could you please try the patch below? Thanks!
>
> --
> Dmitry
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/usb/input/pid.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
>
> Index: work/drivers/usb/input/pid.c
> ===================================================================
> --- work.orig/drivers/usb/input/pid.c
> +++ work/drivers/usb/input/pid.c
> @@ -259,7 +259,7 @@ static int hid_pid_upload_effect(struct
>  int hid_pid_init(struct hid_device *hid)
>  {
>         struct hid_ff_pid *private;
> -       struct hid_input *hidinput = list_entry(&hid->inputs, struct hid_input, list);
> +       struct hid_input *hidinput = list_entry(hid->inputs.next, struct hid_input, list);
>         struct input_dev *input_dev = hidinput->input;
>
>         private = hid->ff_private = kzalloc(sizeof(struct hid_ff_pid), GFP_KERNEL);
>

The above fix works like a charm.  2.6.15 is running on this very
computer that I'm typing on.

Thank you for your good work.  Please ensure that this fix gets
incorporated in the mainline kernel.

Patrick
