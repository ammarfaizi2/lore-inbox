Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317749AbSFSCzq>; Tue, 18 Jun 2002 22:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317750AbSFSCzp>; Tue, 18 Jun 2002 22:55:45 -0400
Received: from h-64-105-35-162.SNVACAID.covad.net ([64.105.35.162]:2962 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S317749AbSFSCzp>; Tue, 18 Jun 2002 22:55:45 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 18 Jun 2002 19:55:39 -0700
Message-Id: <200206190255.TAA09402@adam.yggdrasil.com>
To: kai@tp1.ruhr-uni-bochum.de, sam@ravnborg.org
Subject: Re: Various kbuild problems in 2.5.22
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> = Adam Richter
>>  = Sam Ravnborg

>>>         If I want to the kernel to build to continue even when a module
>>>  fails to compile, I should be able to do that by just using "-k".  Not
>>>  being able to build include/linux/modversions.h prevents me from doing
>>>  that.
>>>  From a conceptual point I disagree here. I would like make to
>> avoid completion in case an error is flagged.
>> My prediction is that the new behaviour may result in more errors being
>> corrected, due to the incentitive to do it.

	For most drivers, the result of these changes will simply be
that more device drivers are compiled out and they get less attention.
For example, Alan Cox has said that he does not want anyone trying to
fix the i2o drivers unless they have hardware to test the potential
bugs that he is worried about, especially 64-bit and big endian
issues.  Russell King, for example, has complained on linux-kernel
that the pressure to "make it compile" lead to bad fixes which are now
more hidden because just the compiler symptoms have been fixed.

       Even if you do succeed at getting people to over-prioritize
making certain files compile, it will be at the expense of whatever
else they might have done with that time, such as working on quality
of code that they are more specialized to handle, security,
implementing facilities that would subsequently have made the driver
adjustments much easier, smaller and cleaner.

>>Today you ignore it
>> and hardly cannot spot it in all the noise generated during the build
>> process.

	Baloney.  If you did "make modules" without "-k" before, the
build stopped at the first error, and I'm not asking for that to change.


> = Kai Germaschewski
>Let me second this. In particular, there is no way to reliably generate
>module versions when the affected files cannot even be preprocessed.

	It worked fine before.  I am not concerned about the versioning
of symbols in files that do not compile, as attempts to link to them
will fail anyhow.  I may have to rebuild modversions.h if I fixed a
file that exports symbols, but that can often be true if the file
compiled before.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
