Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVHIA0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVHIA0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbVHIA0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:26:20 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:46721 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S932387AbVHIA0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:26:19 -0400
Message-ID: <42F7F837.6080800@gmail.com>
Date: Tue, 09 Aug 2005 02:26:31 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc5-mm1, mii.c functions linking problem
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, i find out this problem:
#make O=../bu allmodconfig
...
#make O=../bu all
...
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x63c87): In function `sis190_get_settings':
/l/latest/xxx/drivers/net/sis190.c:1656: undefined reference to 
`mii_ethtool_gset'
drivers/built-in.o(.text+0x63c96): In function `sis190_set_settings':
/l/latest/xxx/drivers/net/sis190.c:1663: undefined reference to 
`mii_ethtool_sset'
drivers/built-in.o(.text+0x63d04): In function `sis190_nway_reset':
/l/latest/xxx/drivers/net/sis190.c:1699: undefined reference to 
`mii_nway_restart'
drivers/built-in.o(.text+0x63d2d): In function `sis190_ioctl':
/l/latest/xxx/drivers/net/sis190.c:1732: undefined reference to 
`generic_mii_ioctl'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [all] Error 2
# objdump ../bu/drivers/net/mii.o -t|grep gener
00000018 l     O __kcrctab      00000004 __kcrctab_generic_mii_ioctl
0000005e l     O __ksymtab_strings      00000012 __kstrtab_generic_mii_ioctl
00000030 l     O __ksymtab      00000008 __ksymtab_generic_mii_ioctl
131e7c56 g       *ABS*  00000000 __crc_generic_mii_ioctl
00000635 g     F .text  00000130 generic_mii_ioctl
#objdump ../bu/drivers/net/built-in.o -t|grep gener
00000000         *UND*  00000000 generic_mii_ioctl
# objdump ../bu/drivers/built-in.o -t|grep generic_mii
00000000         *UND*  00000000 generic_mii_ioctl
...

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

