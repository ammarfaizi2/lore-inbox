Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261395AbTCJS0q>; Mon, 10 Mar 2003 13:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261396AbTCJS0q>; Mon, 10 Mar 2003 13:26:46 -0500
Received: from h-64-105-35-31.SNVACAID.covad.net ([64.105.35.31]:18323 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261395AbTCJS0p>; Mon, 10 Mar 2003 13:26:45 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 10 Mar 2003 10:37:20 -0800
Message-Id: <200303101837.KAA05343@adam.yggdrasil.com>
To: driver@jpl.nasa.gov
Subject: Re: devfs + PCI serial card = no extra serial ports
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan Whitehead wrote:
>[snip]
>>       There is nothing in devfs that prevents you from registering
>> devfs devices even if they are not yet bound to specific hardware
>> (you do not need a sysfs mapping, for example).  So, you should be
>> able to register /dev/tts/0..N at initialization, where N is the
>> maximum number of serial devices you want to support.

>are you saying there is a way to force devfs to make more entries in 
>/dev/tts/ without any hardware being attached to the entries? Then i can 
>use setserial? so on boot I'd have 4 entries in /dev/tts ?

	I don't know what you mean by "force."  devfs_register does
not know (or "care") if there is a physical device associated with the
major/minor/ops that it is given.

>Or are you saying I write a script to goto /dev/tts after boot and mknod 
>the ports that are missing?

	User level programs can also do mknod() calls in devfs
directories, if that is what you are referring to, so you could
do "mknod /dev/tts/3 c 4 68", for example.

	By the way, I notice that 2.5.64 with devfs already creates
/dev/tts/0 through /dev/tts/49.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
