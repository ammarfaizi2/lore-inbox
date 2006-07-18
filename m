Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWGRQuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWGRQuq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWGRQuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:50:46 -0400
Received: from muan.mtu.ru ([195.34.34.229]:31247 "EHLO muan.mtu.ru")
	by vger.kernel.org with ESMTP id S932269AbWGRQuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:50:46 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: input/eventX permissions, force feedback
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, anssi.hannula@gmail.com,
       linux-kernel@vger.kernel.org
Date: Tue, 18 Jul 2006 20:50:36 +0400
References: <44BCAD19.8070004@gmail.com> <d120d5000607180520m2a7ec74at452539186cd7814@mail.gmail.com>
User-Agent: KNode/0.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20060718165039.04D50214B6B@muan.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

> Hi Anssi,
> 
> On 7/18/06, Anssi Hannula <anssi.hannula@gmail.com> wrote:
>> Currently most distributions have /dev/input/event* strictly as 0600
>> root:root or 0640 root:root. The user logged in will not have rights to
>> the device, unlike /dev/input/js*, as he could read all passwords from
>> the keyboard device.
>>
>> This is a problem, because /dev/input/event* is used for force feedback
>> and should therefore be user-accessible.
>>
>> I can think of the following solutions to this problem:
>>
>> 1. Some creative udev rule to chmod /dev/input/event* less strictly when
>> it has a /dev/input/js* and is thus a gaming device.
>>
>> 2. Some creative udev rule to chmod /dev/input/event* more strictly when
>> it is a keyboard.
>>
>> 3. Have another force feedback interface also in /dev/input/js*.
>>
> 
> You can do it in udev looking either at MODALIAS or at EV and ABS
> environment variables. I think it is pretty safe to say that a device
> with EV_ABS, EV_FF, ABS_X and ABS_Y is a force-feedback joystick-type
> device and not a keyboard.
> 

You could also have udev create specific symlink for such devices,
say /dev/input/ff* and make a rule for pam_console to change their
permissions. That is finally what is done e.g. for CD-ROMs (cdrom ->
hdc/sr0)

-andrey

> Another solution would be to relax permissions if user is also console
> owner (home box installation).
> 
> One thing is for sure - I do not like #3 at all ;)
> 


