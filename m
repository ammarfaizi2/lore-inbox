Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSFDHfk>; Tue, 4 Jun 2002 03:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316513AbSFDHfk>; Tue, 4 Jun 2002 03:35:40 -0400
Received: from [62.245.135.174] ([62.245.135.174]:18612 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S316512AbSFDHfj> convert rfc822-to-8bit;
	Tue, 4 Jun 2002 03:35:39 -0400
From: "Martin.Knoblauch" <Martin.Knoblauch@teraport.de>
Reply-To: Martin.Knoblauch@teraport.de
Organization: TeraPort GmbH
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-pre9-ac3: Build problem
Date: Tue, 4 Jun 2002 09:35:34 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Message-Id: <200206040935.34870.Martin.Knoblauch@teraport.de>
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 06/04/2002 09:35:34 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 06/04/2002 09:35:40 AM,
	Serialize complete at 06/04/2002 09:35:40 AM
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain;
  charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 the following was observed first on 2.4.19-pre8-ac4, but could have been 
in since earlier versions. After patching to -pre9-ac3 I copy a previous 
working .config file and do:

make oldconfig
make dep
make bzImage
make modules

 This works fine. Next I make a change to the configuration (any change) 
and do

make dep clean
make bzimage

 bzImage fails with:

gcc -D__KERNEL__ -I/lhome/martink/lx/linux-2.4.19-pre9-ac3-mkn/include 
-Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing 
-fno-common -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -I 
/usr/lib/gcc-lib/i486-suse-linux/2.95.3/include -DKBUILD_BASENAME=compat  
-c -o compat.o compat.c
make[3]: *** No rule to make target 
`/lhome/martink/lx/linux-2.4.19-pre9-ac3-mkn/drivers/pci/devlist.h', 
needed by `names.o'.  Stop.
make[3]: Leaving directory 
`/lhome/martink/lx/linux-2.4.19-pre9-ac3-mkn/drivers/pci'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory 
`/lhome/martink/lx/linux-2.4.19-pre9-ac3-mkn/drivers/pci'
make[1]: *** [_subdir_pci] Error 2
make[1]: Leaving directory 
`/lhome/martink/lx/linux-2.4.19-pre9-ac3-mkn/drivers'
make: *** [_dir_drivers] Error 2


 Apparently "gen-devlist" is not [re-]build under these circumstances.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759

