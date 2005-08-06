Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbVHFVNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbVHFVNg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 17:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263362AbVHFVNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 17:13:36 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:20932 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S263358AbVHFVNd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 17:13:33 -0400
Date: Sat, 6 Aug 2005 21:12:52 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@praktifix.dwd.de
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Moore, Eric Dean" <Eric.Moore@lsil.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: RE: As of 2.6.13-rc1 Fusion-MPT very slow
In-Reply-To: <1123350790.5092.2.camel@mulgrave>
Message-ID: <Pine.LNX.4.61.0508062058200.27998@praktifix.dwd.de>
References: <91888D455306F94EBD4D168954A9457C035CB64A@nacos172.co.lsil.com>
  <Pine.LNX.4.61.0508011537250.23481@praktifix.dwd.de> <1123350790.5092.2.camel@mulgrave>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="646811178-1718976129-1123362772=:27998"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646811178-1718976129-1123362772=:27998
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 6 Aug 2005, James Bottomley wrote:

> On Mon, 2005-08-01 at 15:40 +0000, Holger Kiehl wrote:
>> No I did not get it. Can you please send it to me or tell me where I can
>> download it?
>
> OK, since this has stalled, how about trying a different approach.
>
> If you apply the attached patch it will cause fusion to use the
> transport class domain validation.  That should show us which parameters
> are causing the problem and exactly what the negotiations said.  We can
> also tell you how to tweak the parameters.
>
> It should apply to any recent -mm (unless Andrew does a turn to pick up
> the fusion module rework).
>
I tried from 2.6.13-rc2-mm2 up to 2.6.13-rc4-mm1 and always get the following
error when applying this patch:

      CC      drivers/message/fusion/mptbase.o
      CC      drivers/message/fusion/mptscsih.o
      CC      drivers/message/fusion/mptspi.o
    drivers/message/fusion/mptspi.c: In function â..mptspi_target_allocâ..:
    drivers/message/fusion/mptspi.c:113: error: invalid storage class for function â..mptspi_write_offsetâ..
    drivers/message/fusion/mptspi.c:114: error: invalid storage class for function â..mptspi_write_widthâ..
    drivers/message/fusion/mptspi.c:131: warning: implicit declaration of function â..mptspi_write_widthâ..
    drivers/message/fusion/mptspi.c: At top level:
    drivers/message/fusion/mptspi.c:453: warning: conflicting types for â..mptspi_write_widthâ..
    drivers/message/fusion/mptspi.c:453: error: static declaration of â..mptspi_write_widthâ.. follows non-static declaration
    drivers/message/fusion/mptspi.c:131: error: previous implicit declaration of â..mptspi_write_widthâ.. was here
    drivers/message/fusion/mptspi.c:505: error: unknown field â..get_hold_mcsâ.. specified in initializer
    drivers/message/fusion/mptspi.c:505: warning: excess elements in struct initializer
    drivers/message/fusion/mptspi.c:505: warning: (near initialization for â..mptspi_transport_functionsâ..)
    drivers/message/fusion/mptspi.c:506: error: unknown field â..set_hold_mcsâ.. specified in initializer
    drivers/message/fusion/mptspi.c:506: warning: excess elements in struct initializer
    drivers/message/fusion/mptspi.c:506: warning: (near initialization for â..mptspi_transport_functionsâ..)
    drivers/message/fusion/mptspi.c:507: error: unknown field â..show_hold_mcsâ.. specified in initializer
    drivers/message/fusion/mptspi.c:507: warning: excess elements in struct initializer
    drivers/message/fusion/mptspi.c:507: warning: (near initialization for â..mptspi_transport_functionsâ..)
    make[3]: *** [drivers/message/fusion/mptspi.o] Error 1
    make[2]: *** [drivers/message/fusion] Error 2
    make[1]: *** [drivers/message] Error 2
    make: *** [drivers] Error 2

The first errors I was able to resolve by placing the function prototype
definitions (line 113 and 114) outside the function. I am using gcc 4.0.1.
But the errors in line 505 onwards I don't know what to do. Should I take
an earlier -mm release?

Thanks,
Holger
--646811178-1718976129-1123362772=:27998--

