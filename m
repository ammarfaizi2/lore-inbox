Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUA0NI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 08:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263607AbUA0NI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 08:08:59 -0500
Received: from ip503cf2e8.speed.planet.nl ([80.60.242.232]:13574 "EHLO
	www.robertvanherk.nl") by vger.kernel.org with ESMTP
	id S263596AbUA0NI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 08:08:58 -0500
Message-ID: <401661AD.7010801@students.cs.uu.nl>
Date: Tue, 27 Jan 2004 14:03:41 +0100
From: Robert van Herk <rherk@students.cs.uu.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Mouse problems solved...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

Earlier today I mailed that I had a mouse going sluggish and crazy under 
kernel 2.6.2 rc2.

The problem was just that my harddisk wasn't working in DMA mode.

For people that have mice going crazy, I solved my problem like this:

hdparm /dev/xxxx (e.g. hdparm /dev/hda)

There should be something like

/dev/hda:
 multcount    = 16 (on)
 IO_support   =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 geometry     = 65535/16/63, sectors = 156301488, start = 0

If using_dma is off, than that might explain why your mouse is so 
sluggish. Try hdparm -d1 /dev/xxx (this should put dma on).

If you get an error message, check whether you compiled your kernel with 
the needed support for your motherboard chipset for DMA. If not so, 
build the module that corresponds with your chipset, modprobe that 
module and try again.

After this, mouse problems should be over...

Grtz
Robert
