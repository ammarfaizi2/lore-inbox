Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263081AbUDLUef (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbUDLUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:34:35 -0400
Received: from mail.convergence.de ([212.84.236.4]:51381 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263081AbUDLUea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:34:30 -0400
Message-ID: <407AFD5B.8010502@convergence.de>
Date: Mon, 12 Apr 2004 22:34:35 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problems adding sysfs support to dvb subsystem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm currently trying to add proper sysfs support to the dvb subsystem, 
but I'm stuck because I don't know if I'm on the right way. 8-(

 From the docs and existing drivers I read so far I concluded that 
adding a new class via class_register(&dvb_class) is the way to go.

With this I get:
/sys/class/dvb/

Now there can be several dvb adapters present in the system, each of 
this adapter can have several "subsystems" (video decoder, audio 
decoder, frontend ("tuner"), ...)

New adapters register themselves via dvb_register_adapter() and if this 
was succesfull, they register their subsystems via dvb_register_device().

What I'd like to have is something like this, so I can add attributes to 
the frontend for example:
/sys/class/dvb/adapter0/frontend0/

I wasn't able to find a driver that provides this simple "hierarchical" 
order, so I did some experiments with little luck.

Creating this hierarchical order manually (like for "devfs") didn't 
work, I get
 > find: /sys/class/dvb/adapter0/frontend0: No such file or directory
errors upon access:

 > sprintf((void*)&dvbdev->class_device.class_id, "adapter%d/%s%d", 
adap->num, dnames[type], id);
 > class_device_register(&dvbdev->class_device);

I then tried to find a way to first use class_device_register() with 
adapter0  (which works of course), and then with class_device_register() 
again with frontend0, but obviously I cannot connect these two 
instances, because adapter doesn't have a "struct device" where I can 
point the class_device.dev entry from frontend0 to... 8-(

I'd really appreciate if somebody could give me some design hints or 
point me to some documentation that would help me out.

Thanks!
Michael.

