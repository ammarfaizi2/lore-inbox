Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVBGUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVBGUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVBGUY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:24:28 -0500
Received: from postfix3-2.free.fr ([213.228.0.169]:8145 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S261320AbVBGUXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:23:50 -0500
Message-ID: <4207CE2A.5090907@free.fr>
Date: Mon, 07 Feb 2005 21:23:06 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Adam Belay <ambx1@neo.rr.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [bug] pnp_register_card_driver/pnp_unregister_card_driver
References: <4207C29B.8030105@free.fr> <20050207200113.GC3621@neo.rr.com>
In-Reply-To: <20050207200113.GC3621@neo.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Adam Belay wrote:
> On Mon, Feb 07, 2005 at 08:33:47PM +0100, matthieu castet wrote:
> 
>>Hi,
>>
>>pnp_register_driver could fail and return <0 result, in this case the 
>>driver shouldn't be pnp_unregister_driver.
>>
>>But if you look in pnp_register_card_driver, the result isn't checked. 
>>And it is always pnp_unregister_driver in pnp_unregister_card_driver.
>>
>>I know that pnp_register_card_driver shouldn't fail in normal condition, 
>>but who know...
>>
>>
>>Matthieu
> 
> 
> Yeah, you're right.  I'm probably going to do something like this.
> 
If you do something like this there will be some broken driver to 
correct. See [1] for isa alsa driver that assume that the result is >=0.


Matthieu

[1]
$grep -rI pnp_register_card_driver /usr/src/linux/sound/isa/
/usr/src/linux/sound/isa/cs423x/cs4236.c:       cards += 
pnp_register_card_driver(&cs423x_pnpc_driver);
/usr/src/linux/sound/isa/gus/interwave.c:       i = 
pnp_register_card_driver(&interwave_pnpc_driver);
/usr/src/linux/sound/isa/sb/es968.c:    int cards = 
pnp_register_card_driver(&es968_pnpc_driver);
/usr/src/linux/sound/isa/sb/sb16.c:     i = 
pnp_register_card_driver(&sb16_pnpc_driver);
/usr/src/linux/sound/isa/als100.c:      cards += 
pnp_register_card_driver(&als100_pnpc_driver);
/usr/src/linux/sound/isa/sscape.c:              ret = 
pnp_register_card_driver(&sscape_pnpc_driver);
/usr/src/linux/sound/isa/opti9xx/opti92x-ad1848.c:      cards = 
pnp_register_card_driver(&opti9xx_pnpc_driver);
/usr/src/linux/sound/isa/ad1816a/ad1816a.c:     cards += 
pnp_register_card_driver(&ad1816a_pnpc_driver);
/usr/src/linux/sound/isa/wavefront/wavefront.c: cards += 
pnp_register_card_driver(&wavefront_pnpc_driver);
/usr/src/linux/sound/isa/dt019x.c:      cards += 
pnp_register_card_driver(&dt019x_pnpc_driver);
/usr/src/linux/sound/isa/es18xx.c:      i = 
pnp_register_card_driver(&es18xx_pnpc_driver);
/usr/src/linux/sound/isa/azt2320.c:     cards += 
pnp_register_card_driver(&azt2320_pnpc_driver);
/usr/src/linux/sound/isa/opl3sa2.c:     cards += 
pnp_register_card_driver(&opl3sa2_pnpc_driver);
/usr/src/linux/sound/isa/cmi8330.c:     cards += 
pnp_register_card_driver(&cmi8330_pnpc_driver);
