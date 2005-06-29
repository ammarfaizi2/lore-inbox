Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262607AbVF2VMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262607AbVF2VMn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbVF2VMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:12:05 -0400
Received: from mail.dif.dk ([193.138.115.101]:41908 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262607AbVF2VJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:09:55 -0400
Date: Wed, 29 Jun 2005 23:15:55 +0200 (CEST)
From: Jesper Juhl <juhl@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up  inline static  vs  static inline  
In-Reply-To: <Pine.LNX.4.62.0506292256280.2998@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.62.0506292310450.2998@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0506292256280.2998@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-581567288-1120079755=:2998"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-581567288-1120079755=:2998
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 29 Jun 2005, Jesper Juhl wrote:

> 
> Andrew, I know you generally don't want to take patches for stuff that 
> only fixes gcc -W warnings except through maintainers, but this one I 
> found to be so obviously correct that I desided to take the chance anyway 
> - especially since you've taken patches like this one in the past. :-)
> Lets merge this and get rid of this little annoyance once and for all.
> 
> gcc likes to complain if the static keyword is not at the beginning of the 
> declaration. This patch fixes all remaining occurrences of "inline static" 
> up with "static inline" in the entire kernel tree (140 occurrences in 47 
> files).
> While making this change I came across a few lines with trailing 
> whitespace that I also fixed up, I have also added or removed a blank line 
> or two here and there, but there are no functional changes in the patch.
> 

Whoops, forgot the Signed-off-by and diffstat - here they are : 

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 arch/ia64/sn/include/pci/pcibr_provider.h |    2 +-
 crypto/aes.c                              |    2 +-
 drivers/cdrom/optcd.c                     |   28 ++++++++++++++--------------
 drivers/char/ipmi/ipmi_si_intf.c          |    2 +-
 drivers/ide/pci/cmd640.c                  |    2 +-
 drivers/isdn/hisax/avm_a1.c               |    2 +-
 drivers/isdn/hisax/isdnl2.c               |    2 +-
 drivers/isdn/hisax/teles3.c               |    2 +-
 drivers/md/md.c                           |    2 +-
 drivers/media/radio/radio-maestro.c       |    4 ++--
 drivers/media/radio/radio-maxiradio.c     |    2 +-
 drivers/mmc/wbsd.c                        |    2 +-
 drivers/net/3c505.c                       |    2 +-
 drivers/net/plip.c                        |   29 ++++++++++++++---------------
 drivers/net/via-velocity.h                |    4 ++--
 drivers/net/wireless/airo.c               |    2 +-
 drivers/oprofile/cpu_buffer.c             |   23 +++--------------------
 drivers/s390/cio/qdio.c                   |   20 ++++++++++----------
 drivers/s390/net/qeth.h                   |   26 +++++++++++++-------------
 drivers/scsi/dc395x.c                     |    2 +-
 drivers/scsi/fdomain.c                    |    2 +-
 drivers/usb/image/microtek.c              |    3 +--
 drivers/video/pm2fb.c                     |   16 ++++++++--------
 fs/reiserfs/journal.c                     |    4 ++--
 include/sound/vx_core.h                   |   16 ++++++++--------
 kernel/time.c                             |    2 +-
 net/core/pktgen.c                         |    2 +-
 sound/core/seq/oss/seq_oss_device.h       |    6 +++---
 sound/core/seq/seq_memory.c               |    4 ++--
 sound/core/seq/seq_midi_event.c           |    2 +-
 sound/drivers/serial-u16550.c             |   10 +++++-----
 sound/isa/sb/emu8000_patch.c              |    2 +-
 sound/oss/dmasound/dmasound_awacs.c       |    4 ++--
 sound/pci/cmipci.c                        |   14 ++++++++------
 sound/pci/cs4281.c                        |    2 +-
 sound/pci/emu10k1/memory.c                |    2 +-
 sound/pci/es1968.c                        |   12 ++++++------
 sound/pci/maestro3.c                      |    8 ++++----
 sound/pci/nm256/nm256.c                   |   16 ++++++++--------
 sound/pci/trident/trident_main.c          |    2 +-
 sound/pci/trident/trident_memory.c        |    2 +-
 sound/pci/vx222/vx222_ops.c               |    4 ++--
 sound/pcmcia/vx/vxp_ops.c                 |    2 +-
 sound/ppc/burgundy.c                      |    4 ++--
 sound/ppc/pmac.c                          |    8 ++++----
 sound/usb/usbaudio.c                      |    8 ++++----
 sound/usb/usbmixer.c                      |    4 ++--
 47 files changed, 152 insertions(+), 169 deletions(-)


I've attached the patch (gzip'ed due to size) to this mail - it was inline 
in the previous one, but not sure if it'll make it to you since that mail 
was ~50K


-- Jesper


--8323328-581567288-1120079755=:2998
Content-Type: APPLICATION/octet-stream; name=inline_static-vs-static_inline.patch.gz
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.62.0506292315550.2998@dragon.hyggekrogen.localhost>
Content-Description: inline_static-vs-static_inline.patch.gz
Content-Disposition: attachment; filename=inline_static-vs-static_inline.patch.gz

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
AA==

--8323328-581567288-1120079755=:2998--
