Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291236AbSBGTdC>; Thu, 7 Feb 2002 14:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291238AbSBGTcm>; Thu, 7 Feb 2002 14:32:42 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:1028 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S291236AbSBGTck>; Thu, 7 Feb 2002 14:32:40 -0500
Message-ID: <71714C04806CD5119352009027289217022C43E6@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: florin@iucha.net
Cc: linux-kernel@vger.kernel.org
Subject: RE: SIS900 driver unresolved dependency crc32_be in 2.5.3
Date: Thu, 7 Feb 2002 13:32:28 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /lib/modules/2.5.3-xfs-k7/kernel/drivers/net/sis900.o: 
> unresolved symbol crc32_be

Ahh, yes.  I see it now.

CONFIG_SIS900=m
CONFIG_CRC32=y

The makefile rules took the most stringent of =m and =y and made it =y.
But, nothing CONFIG_XXX=y in vmlinux needs the crc32 functions, so the
linker threw the code away.

Partial solution:  CONFIG_CRC32=m

Is there a better way to handle this type of situation?  Personally, I like
leaving CONFIG_CRC32=m set always (assuming you've got modules), and let the
makefile rules set it to =y if something else =y needs it.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
#1 US Linux Server provider with 24.5% (IDC Dec 2001)
#2 Worldwide Linux Server provider with 18.2% (IDC Dec 2001)
