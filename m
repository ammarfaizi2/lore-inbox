Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWGRMUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWGRMUH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 08:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWGRMUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 08:20:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:18167 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751333AbWGRMUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 08:20:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ozA070+56+YQR5W1zJECJ5l1D2KT60Exg4O+LtDp3peVu5V6hn6xmtgXjrUxd/gjasI5X7Jz8Q4M6mrlRuy80pF/2MMes7trcrk1FESaFzAf02/FKnFEnI8f9q+P6shH65uKfIFZ6L+3T9THDxcAqUadrBGUoQNADtg7AjjX2pU=
Message-ID: <d120d5000607180520m2a7ec74at452539186cd7814@mail.gmail.com>
Date: Tue, 18 Jul 2006 08:20:04 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Anssi Hannula" <anssi.hannula@gmail.com>
Subject: Re: input/eventX permissions, force feedback
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <44BCAD19.8070004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44BCAD19.8070004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anssi,

On 7/18/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
> Currently most distributions have /dev/input/event* strictly as 0600
> root:root or 0640 root:root. The user logged in will not have rights to
> the device, unlike /dev/input/js*, as he could read all passwords from
> the keyboard device.
>
> This is a problem, because /dev/input/event* is used for force feedback
> and should therefore be user-accessible.
>
> I can think of the following solutions to this problem:
>
> 1. Some creative udev rule to chmod /dev/input/event* less strictly when
> it has a /dev/input/js* and is thus a gaming device.
>
> 2. Some creative udev rule to chmod /dev/input/event* more strictly when
> it is a keyboard.
>
> 3. Have another force feedback interface also in /dev/input/js*.
>

You can do it in udev looking either at MODALIAS or at EV and ABS
environment variables. I think it is pretty safe to say that a device
with EV_ABS, EV_FF, ABS_X and ABS_Y is a force-feedback joystick-type
device and not a keyboard.

Another solution would be to relax permissions if user is also console
owner (home box installation).

One thing is for sure - I do not like #3 at all ;)

-- 
Dmitry
