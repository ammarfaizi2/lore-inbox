Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274767AbRIZBnB>; Tue, 25 Sep 2001 21:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274768AbRIZBmu>; Tue, 25 Sep 2001 21:42:50 -0400
Received: from CPE-61-9-148-139.vic.bigpond.net.au ([61.9.148.139]:16882 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S274767AbRIZBmi>; Tue, 25 Sep 2001 21:42:38 -0400
Message-ID: <3BB12FA3.96460B90@eyal.emu.id.au>
Date: Wed, 26 Sep 2001 11:30:11 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.9 is available
In-Reply-To: <765.1001404102@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just built and installed modutils-2.4.9.

Building vanilla 2.4.10, while doing 'make modules_install':

cd /lib/modules/2.4.10; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.10; fi
depmod: Unexpected value (20) in
'/lib/modules/2.4.10/kernel/drivers/ieee1394/sbp2.o' for
ieee1394_device_size
        It is likely that the kernel structure has changed, if so then
        you probably need a new version of modutils to handle this
kernel.
        Check linux/Documentation/Changes.
make: *** [_modinst_post] Error 255

I can reproduce it with a simple
# depmod -V -ae -F System.map 2.4.10
depmod version 2.4.9
depmod: Unexpected value (20) in
'/lib/modules/2.4.10/kernel/drivers/ieee1394/sbp2.o' for
ieee1394_device_size
        It is likely that the kernel structure has changed, if so then
        you probably need a new version of modutils to handle this
kernel.
        Check linux/Documentation/Changes.

It always mentions the same module.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
