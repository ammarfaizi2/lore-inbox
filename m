Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318225AbSHWGuD>; Fri, 23 Aug 2002 02:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSHWGuD>; Fri, 23 Aug 2002 02:50:03 -0400
Received: from h-64-105-137-141.SNVACAID.covad.net ([64.105.137.141]:64135
	"EHLO freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S318225AbSHWGuC>; Fri, 23 Aug 2002 02:50:02 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 22 Aug 2002 23:54:03 -0700
Message-Id: <200208230654.XAA02328@adam.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: IDE-flash device and hard disk on same controller
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>Eric W. Biederman wrote:
>>The problem is that immediately after bootup ATA devices do not respond until
>>their media has spun up.  Which is both required by the spec, and observed in
>>practice.   Which is likely a problem if this code is run a few seconds after
>>bootup.  Which makes it quite possible the drive will ignore the
>>EXECUTE DEVICEDIAGNOSTICS and your error code won't be valid when 
>>the bsy flag clears.   I don't know how serious that would be. 
>
>
>Well, this only applies if you are slack and letting the kernel init 
>your ATA from scratch, instead of doing proper ATA initialization in 
>firmware ;-)
>
>Seriously, if you are a handed an ATA device that is actually in 
>operation when the kernel boots, you are already out of spec.

	1. Regardless of whatever specification you are referring to
or Andre's "31 second rule of [Power On Self Test]", it is genuinely
useful to boot faster by overlapping some other kernel work before the
drive is.  Specifications ultimately exist only to serve this
usefulness.  When a specification impedes usefulness, sometimes it's
the right decision to violate it.  Of course, we're not talking about
your IDE code violating such a specification, but rather not relying
on this particular guarantee.

	2. Besides, if this code is supposed to be a generic IDE core,
it many need to run on platforms that do not provide that guarantee or
where the boot code is not even capable of finding where all of the
IDE controllers.

	3. In the hierarchy of upgradability, it is generally easier
to replace the kernel than the Power On Self Test, which is more often
in flash or ROM, and which may require help from an unenthusiastic
hardware vendor.  So, it is better to weight trade-offs a few notches
in favor of avoid reliance on guarantees about the Power On Self Test.

	If I understand correctly, the cost of this trade off would be
adding one or two lines that add perhaps 20 bytes and as many CPU
cycles at initiailzation (except when this change really is necessary).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
