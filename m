Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265515AbRGCAY3>; Mon, 2 Jul 2001 20:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265523AbRGCAYT>; Mon, 2 Jul 2001 20:24:19 -0400
Received: from datafoundation.com ([209.150.125.194]:6157 "EHLO
	datafoundation.com") by vger.kernel.org with ESMTP
	id <S265515AbRGCAYO>; Mon, 2 Jul 2001 20:24:14 -0400
Message-ID: <3B4110AA.4060505@datafoundation.com>
Date: Mon, 02 Jul 2001 20:24:10 -0400
From: Dmitry Meshchaninov <dima@datafoundation.com>
Reply-To: dima@datafoundation.com
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.4-dm i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        christophe =?KOI8-R?Q?barbe=27?= <christophe.barbe@lineo.fr>,
        "David S. Miller" <davem@redhat.com>,
        "Jason T.Murphy" <jtmurphy@amazon.com>
Subject: [PATCH] qlogicfc driver
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   I'm sending link to updated qlogicfc driver with ip-support for 2.4.4-virgin 
kernel. Hope it works with 2.4.5. Driver changes:

- structures and defines of qlogic host adapter now are separated from driver 
itself. We have kdb module to examine host structures, that's why we did it.

- IP initialization fixed to be 64-bit aware (tested on Alpha's).

- opportunity to use per-host smp lock introduced (PER_HOST_LOCK macro) - 
extensively tested. By default all operations are serialized though io_request_lock.

- recalculations of scsi_host->can_queue variable were removed. It is 
meaningless and may lead to bugs.

- more DMA mapping in IP-part of the driver.
- simple network statistics (tx/rx packets/bytes).
- some algorythm changes from original Qlogic driver were taken.
- now driver can be compiled into kernel statically.

- opportunity to select ip-support option during kernel configuration (and 
appropriate firmware);

- looks like qlogic card contains bug related to request queue handling (if the 
card takes more requests than it was pre-programmed (request queue length) - all 
those request will never go out of the card). And depth of this queue actually 
depends on load of your system. Thats why original driver from Qlogic was 
changed in order to increase this parameter. You can configure this parameter 
during kernel configuration for your needs too. Now driver starts screaming if 
request queue is 80%-full; so you will be notified about the need to increase 
this value.

Most part of the patch is updated firmware (from stable Qlogic driver ver4.25 
and another one with ip-support). That's why i cannot post it to lklm directly. 
If something goes wrong (it's possible to miss something during patch 
preparation) - please report.

Link to patches: http://www.datafoundation.org/qlogicfc

Any comments, test results and proposals are welcome.
Dmitry Meshchaninov

