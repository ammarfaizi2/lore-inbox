Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTJATSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTJATSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:18:16 -0400
Received: from mail.g-housing.de ([62.75.136.201]:1950 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262175AbTJATSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:18:10 -0400
Message-ID: <3F7B2866.4000204@g-house.de>
Date: Wed, 01 Oct 2003 21:17:58 +0200
From: Christian Kujau <evil@g-house.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030923
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Dependency bug? Alsa es1370 needs joystick support
References: <slrnbniia2.p62.erik@bender.home.hensema.net>
In-Reply-To: <slrnbniia2.p62.erik@bender.home.hensema.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Hensema wrote:
> Hello,
> 
> I lost sound support after the upgrade from -test4 to -test6; I've been
> told on IRC that this could be due to a dependency of the sounddriver on
> joystick support. This indeed seems to be the case.
> 
> I'm using the (Creative) Ensoniq AudioPCI 1370 driver.

Hi,

same here with es1371. but when i look into the -test6 patch, i see this:

------------------
  config SND_ENS1371
         tristate "(Creative) Ensoniq AudioPCI 1371/1373"
-       depends on SND && SOUND_GAMEPORT
+       depends on SND && GAMEPORT
         help
           Say 'Y' or 'M' to include support for Ensoniq AudioPCI 
ES1371\ and
           Sound Blaster PCI 64 or 128 soundcards.
------------------


but i did not notice that SND_ENS1371 ever depended from SOUND_GAMEPORT.
(i have no joystick, but still listen to music :-))

so, a rather trivial fix would be:

http://www.nerdbynature.de/bits/snd/Kconfig.nogameport.patch

(for SND_ENS1371 only, but should probably do for similiar cards)

oh, as Malte (TM) pointed out, this is tested for i386 only :-)

cheers,
Christian.

-- 
BOFH excuse #29:

It works the way the Wang did, what's the problem

