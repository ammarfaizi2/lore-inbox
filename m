Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317681AbSGJXoH>; Wed, 10 Jul 2002 19:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317682AbSGJXoG>; Wed, 10 Jul 2002 19:44:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10508 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317681AbSGJXoG>;
	Wed, 10 Jul 2002 19:44:06 -0400
Message-ID: <3D2CC764.6080002@mandrakesoft.com>
Date: Wed, 10 Jul 2002 19:46:44 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compile error (starfire ethernet) on 2.5.25 for crc32_le
References: <165080000.1026343268@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RBL-Warning: (relays.osirusoft.com) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> drivers/built-in.o: In function `set_rx_mode':
> drivers/built-in.o(.text+0x2138c): undefined reference to `crc32_le'
> make: *** [vmlinux] Error 1
> 
> starfire.c calls ether_crc_le which is defined in include/linux/crc32.h as
> #define ether_crc_le(length, data) crc32_le(~0, data, length)
> 
> crc32_le is defined in lib/crc32.c .... which is only compiled if CONFIG_CRC32
> is set  ... setting this fixes the problem ... shouldn't drivers that need this turn it
> on automatically somehow?

They do already.  drivers/net/Makefile.lib.  The culprit is a typo. 
Wanna submit the obvious patch that does 
s/CONFIG_STARFIRE/CONFIG_ADAPTEC_STARFIRE/ in dr/ne/Makefile.lib?

	Jeff



