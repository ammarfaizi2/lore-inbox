Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbVCBSv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbVCBSv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 13:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbVCBSv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 13:51:26 -0500
Received: from smtp.telefonica.net ([213.4.129.135]:54600 "EHLO
	telesmtp4.mail.isp") by vger.kernel.org with ESMTP id S262393AbVCBSvS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 13:51:18 -0500
Message-ID: <42260B1D.3070304@telefonica.net>
Date: Wed, 02 Mar 2005 19:51:09 +0100
From: Miguelanxo Otero Salgueiro <miguelanxo@telefonica.net>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11: touchpad unresponsive
References: <3d668208.82083d66@teleline.es> <d120d50005030209123b8db1ae@mail.gmail.com>
In-Reply-To: <d120d50005030209123b8db1ae@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:

>On Wed, 02 Mar 2005 16:55:59 +0100, MIGUELANXO@telefonica.net
><MIGUELANXO@telefonica.net> wrote:
>  
>
>>I just compiled 2.6.11 from 2.6.10 config using 'make oldconfig',
>>activate new options to default values (i.e. set "main kernel lock
>>preemtive" to YES).
>>
>>Booting X in new kernel makes my touchpad very unresponsive. I can't
>>click any longer in the touchpad area, and the touchpad doesn't response
>>when moving in small increments, so the whole experience is quite bad.
>>
>>    
>>
>
>If it is identified as an ALPS touchpad you can try installing Peter
>Osterlund's Synaptics X driver:
>
>           http://web.telia.com/~u89404340/touchpad/
>
>Alternatively you can restore 2.6.10 behavior with psmouse.proto=exps
>boot option (if psmouse is a module add "options psmouse proto=exps"
>to your /etc/modprobe.conf).
>
>  
>
Yes, it's an ALPS touchpad.

Ok, I compiled latest synaptics driver (synaptics-0.14.0) under the 
following conditions
    - Enabled CONFIG_MOUSE_PS2 (already enabled)
    - Enabled CONFIG_INPUT_EVDEV (this one on purpose)

I read README.alps so I tried patching the kernel with alps.patch as 
suggested. Looks like it didn't work because patch refused to patch 
already patched files. I gave a look at the patch and the kernel code, 
and they seem to be incompatible (maybe you need to release a newe patch).

So I proceded without the patched kernel, installing the synaptics 
driver using INSTALL and README.alps settings.

With plain INSTALL settings (no ALPS), the touchpad seemed responsible, 
but kind of slow. Simple or double click didn't work.

With README.alps settings, touchpad feels a lot like in 2.6.10, thought 
the "acceleration" seems to be non-linear.
Simple click worked BUT double-click didn't work. Horizontal/Vertical 
scroll and Click-n-Drag worked too, so I'm almost there.

I tried to patch alps.c using the tiny patch at README.alps but that 
didn't work either as that version is clearly not designed for 2.6.10 
alps.c.

Thanks for your help.

By the way, I'm using a Toshiba laptop (Toshiba Satellite A10), maybe 
you would like to add that to your supported hardware list.
