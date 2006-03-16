Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752351AbWCPKxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752351AbWCPKxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 05:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbWCPKxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 05:53:34 -0500
Received: from web26913.mail.ukl.yahoo.com ([217.146.177.80]:15275 "HELO
	web26913.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1752351AbWCPKxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 05:53:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LywlT5AyjoyT4CtC5e6SPUCFkeohJg9MfhzJV1M4ksEn6+hRU31wjETECSOjn4s5NXxyfP/nOBOZkjgFSOV9oh+tAEBeLOpeBw7Kjo0k7O/hHJA8DXutm4oRUpFuj5s8wsCI24oiEtvvj7MB0avTM+kvX8WUVzN0G4NMde6go4E=  ;
Message-ID: <20060316105332.46898.qmail@web26913.mail.ukl.yahoo.com>
Date: Thu, 16 Mar 2006 11:53:32 +0100 (CET)
From: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Subject: Re: sis96x compiled in by error: delay of one minute at boot
To: linux-kernel@vger.kernel.org
Cc: Jean Delvare <khali@linux-fr.org>,
       "Mark M. Hoffman" <mhoffman@lightlink.com>,
       lm-sensors <lm-sensors@lm-sensors.org>
In-Reply-To: <3ZH07HE0.1142498811.4526410.khali@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Jean Delvare wrote:
>> Mark, can you provide a patch to your i2c-sis96x driver so that it'll
>> keep quiet when no supported device is found?
>
>Mark M. Hoffman wrote:
>Lots of drivers printk messages when they load - IMO it's useful info.
>E.g. how else could Etienne discover that he accidentally built a kernel
>with dozens of i2c bus drivers (and probably all of the hwmon drivers)
>built-in by accident?

 I did not built with all hwmon drivers because I could determine what I
 had on my mainboard. For me, because the kernel say it enters the I2C
 system by the line:
Mar 13 21:46:48 kernel: [   47.705445] i2c /dev entries driver
 It could print a line when finished probing all those I2C drivers by a
 line like:
Mar 13 21:46:48 kernel: [   50.705445] i2c driver found: aaa-i2c, bbb-i2c.
 And then I can have a clue on what to include in my monolitic build.
 I do not care about such timeout on _one_ build, as long as I know what
 to do for next build. Another possibility is to print a line when an I2C
 detection has failed: you know that it has taken quite a lot of time and
 it should not have been done in the first place (even for a module
 because this module should not have been inserted).

 It also protect the I2C group from people like me complainning
 because completely unrelated messages like
Mar 13 22:12:54 kernel: [   61.997032]  : Detection failed at step 3

Elsewhere Jean Delvare wrote:
> That being said, the key problem being stuck i2c busses, it's even more
> important to get rid of these. You can use "i2cdetect -l" to list all
> detected i2c bus, so you'll see if you have any unwanted bus left.

I do not have this i2cdetect software installed on my system.

> If all drivers were actually printking messages when they load,
> monolithic kernels would be a mess (not that I much understand the
> point of such monolithic kernels, but...) You wouldn't be able to tell from
> the boot log which drivers are actually used by the system, and which
> aren't.

Maybe it is only me, and I am totally wrong, but it seems that the
resulting _monolitic_ kernel is quicker.
- Maybe it is quicker because a lot of modules try to insert themself
and fails as an autodetection subsystem in some distributions.
- Maybe because fetching a lot of files (kernel modules) at boot
time creates a lot of disk activity - and it is better to load everything
at startup by the bootloader (hint: Gujin).
- Maybe it is quicker because when loading a module there is a lot
of addresses to resolve at run time and that takes time, instead of
doing it once when you are linking the monolitic kernel.
- Maybe it is simply (correct me if I am wrong) because modules
_have_ to be compiled as a relocatable library (because the load
address of code and data segment isn't known) and that is acheived
by the compiler by fixing register %ebx to the base address - and
on i386 removing one of the 4 (or 6) general purpose register
produces code which is a lot slower (up to the point you do not care
for which processor you compile the kernel: the improvement done
by one or two added instruction/features do not compensate for this
kind of loss).

Maybe also managing the tree /lib/modules/* and the initrd take
more time than simply doing once a clean linux/.config and
maintaining this file by saying "No" to most added drivers...

  Cheers,
  Etienne.



	

	
		
___________________________________________________________________________ 
Nouveau : téléphonez moins cher avec Yahoo! Messenger ! Découvez les tarifs exceptionnels pour appeler la France et l'international.
Téléchargez sur http://fr.messenger.yahoo.com
