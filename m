Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274001AbRIXQki>; Mon, 24 Sep 2001 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274002AbRIXQk2>; Mon, 24 Sep 2001 12:40:28 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:8628 "EHLO
	mailout.plan9.de") by vger.kernel.org with ESMTP id <S274001AbRIXQkG>;
	Mon, 24 Sep 2001 12:40:06 -0400
Date: Mon, 24 Sep 2001 18:40:08 +0200
From: <pcg@goof.com ( Marc) (A.) (Lehmann )>
To: Nicholas Knight <tegeran@home.com>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Message-ID: <20010924184008.A4126@schmorp.de>
Mail-Followup-To: Nicholas Knight <tegeran@home.com>,
	Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org> <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
X-Operating-System: Linux version 2.4.8-ac9 (root@cerebro) (gcc version 3.0.1) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 09:15:19AM -0700, Nicholas Knight <tegeran@home.com> wrote:
[turning off write-cache]
> I'm sorry, but that's not acceptable.

(I had it turned off for a long time, until I reasoned: real power-outages
are very rare, so I can leave it turned on anyways and risk a
filesystemcheck after outages).

The reason this kills performance ALWAYS is that ide does not support large
enough transfer sizes (8-32k on most drives) to fill one track.

Turning off write caching has a big chance of lowering your transaction
throughput to the drive's RPM. Combined with linux' not-that-optimal elevator
and write behaviour this has good chances of costing a lot of performance.

TCQ will obviously help, but I somehow doubt it will work fine - even with
SCSI TCQ is a nightmare (the aic7xxx drive regularly kills my system if
tagged queueing is enabled for example). IDE currently is a mess (I do
_not_ expect my drive performance to simply halve just because two devices
to share the bus, even if this is how conservative ide is destined to
work).

I am convinced that there is a way of creating a hard write barrier (e.g.
a cache flush that waits) with most if not all ide disks - putting them
into powersave should work, if nothing else ;)

So apart from driver issues (such as TCQ), the mid-layer needs to be improved
(and plans already exist) to support semi-ordered writes and give as much
control over the device cache as possible.

Not to mention that the VM needs improvements here as well.

I didn't say much more than Alan implied: we have to live with it, so we
better think about making it work.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
