Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271303AbRHTPQj>; Mon, 20 Aug 2001 11:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271295AbRHTPQ3>; Mon, 20 Aug 2001 11:16:29 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:8426 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S271294AbRHTPQR>; Mon, 20 Aug 2001 11:16:17 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 20 Aug 2001 08:15:26 -0700
Message-Id: <200108201515.IAA00409@baldur.yggdrasil.com>
To: alan@lxorguk.ukuu.org.uk
Subject: Re: PATCH: linux-2.4.9/drivers/i2o to new module_{init,exit} interface
Cc: deepak@plexity.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>  	sti();
>> -#ifdef CONFIG_I2O
>> -	i2o_init();
>> -#endif
>>  #ifdef CONFIG_BLK_DEV_DAC960
>>  	DAC960_Initialize();

>Rejected. The ordering is critical because drivers may have both i2o and
>non i2o interfaces. Also an i2o card may control other pci devices and
>we will need to claim the resources beforehand when we finally support that.

	OK, I can fix this in the ordering of "obj-y += ..."
declarations in linux/Makefile.  (If you really need i2o
initialization to occur earlier than do_initcalls(), then that would
also mean that i2o cannot be a module, right?)

>>  dep_tristate '  I2O Block OSM' CONFIG_I2O_BLOCK $CONFIG_I2O
>> -if [ "$CONFIG_NET" = "y" ]; then
>> +if [ "$CONFIG_NET" != "n" ]; then

>NET cannot be modular

	Oops!  Sorry, I accidentally included part of another
change I was fiddling with.


>> -#ifdef MODULE
>>  	i = core->install(c);
>> -#else
>> -	i = i2o_install_controller(c);
>> -#endif /* MODULE */

>This changes all the module dependancy patterns - yes its right, no its not
>appropriate for a "stable" kernel.

	It changes the dependency pattern to the one that is already
used when i2o is a module, not to a new dependency pattern.

	If you want, I can send you a new patch that changes
linux/Makefile to initialize i2o before just before drivers/block,
thereby reproducing the current initialization order, and, of course,
I'll also remove the CONFIG_NET patch that I accidentally put in
before.  Please let me know.

	In any case thanks for looking at my patch and providing the
feedback.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

