Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUASKtC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 05:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUASKtC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 05:49:02 -0500
Received: from openoffice.demon.nl ([212.238.150.237]:15379 "EHLO
	sahara.openoffice.nl") by vger.kernel.org with ESMTP
	id S264507AbUASKs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 05:48:58 -0500
Date: Mon, 19 Jan 2004 11:48:54 +0100
From: Valentijn Sessink <linux-kernel-1074509192@mail.v.sessink.nl>
To: linux-kernel@vger.kernel.org
Subject: hard crash in IPsec
Message-ID: <20040119104854.GA2991@openoffice.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Open Office - Linux for the desktop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

2.6.0/IPsec crashes, fully reproducable. Verified with 2.6.1.

Details of the crash are on a couple of jpg's,
http://valentijn.sessink.nl/fotoalbum/2004-01-14%20afscheidscollege%20Frits/img_0017.jpg
and img_0018.jpg

IPsec config on the crashing machine:

add $ip1 $ip2 esp 0x202 -m tunnel -E 3des-cbc $passwd1
 -A hmac-md5 $passwd2;
add $ip2 $ip1 esp 0x302 -m tunnel -E 3des-cbc $passwd3
 -A hmac-md5 $passwd4;
spdadd net/24 work/24 any -P out ipsec esp/tunnel/$ip1-$ip2/require;
spdadd net/24 work/24 any -P out ipsec esp/tunnel/$ip2-$ip1/require;

note the wrong config, where the second spdadd has an "out" instead of the
correct "in". The other end has correct configuration.

tcpdumping the network now says:
15:07:07.335105 $ip1 > $ip2: ESP(spi=0x00000202,seq=0x1) (DF)
15:07:07.365947 $ip2 > $ip1: ESP(spi=0x00000302,seq=0x5)
15:07:07.365947 truncated-ip - 16 bytes missing!$ip2 > 69.0.0.84:
$ip1 > 69.0.0.84: (frag 13828:4294967256@29112) [tos 0x4c] (ipip)
15:07:08.331514 $ip1 > $ip2: ESP(spi=0x00000202,seq=0x2) (DF)
15:07:08.361917 $ip2 > $ip1: ESP(spi=0x00000302,seq=0x6)
15:07:08.361917 truncated-ip - 16 bytes missing!$ip2 > 69.0.0.84:
$ip1 > 69.0.0.84: (frag 13828:4294967256@29096) [tos 0x4e,ECT] (ipip)
15:07:09.330341 $ip1 > $ip2: ESP(spi=0x00000202,seq=0x3) (DF)
15:07:09.362973 $ip2 > $ip1: ESP(spi=0x00000302,seq=0x7)
15:07:09.362973 truncated-ip - 16 bytes missing!$ip2 > 69.0.0.84:
$ip1 > 69.0.0.84: (frag 13828:4294967256@29080) [tos 0x50] (ipip)
15:07:10.331186 $ip1 > $ip2: ESP(spi=0x00000202,seq=0x4) (DF)

Once the setup was corrected, everything was fine (no crashes).

This is Debian GNU/Linux 3.0, kernel compiled with GCC 2.95.4, a 32Mb Cyrix
6x86MX machine.

Best regards,

Valentijn
-- 
http://www.openoffice.nl/   Open Office - Linux Office Solutions
Valentijn Sessink  valentyn+sessink@nospam.openoffice.nl
