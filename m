Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVHJAl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVHJAl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 20:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbVHJAlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 20:41:55 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:60806 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S1751009AbVHJAlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 20:41:55 -0400
Message-ID: <42F94D54.5090802@gmail.com>
Date: Wed, 10 Aug 2005 02:41:56 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_find_device and pci_find_slot mark as deprecated
References: <42F72D4D.8030102@volny.cz> <200508082354.j78Ns1Cn028468@wscnet.wsc.cz> <20050809041133.GA10552@kroah.com> <4af2d03a0508090258942f536@mail.gmail.com> <20050809215737.GD22683@kroah.com>
In-Reply-To: <20050809215737.GD22683@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH napsal(a):
> On Tue, Aug 09, 2005 at 11:58:19AM +0200, Jiri Slaby wrote:
> 
>>On 8/9/05, Greg KH <greg@kroah.com> wrote:
>>
>>>On Tue, Aug 09, 2005 at 01:54:01AM +0200, Jiri Slaby wrote:
>>>
>>>>This marks these functions as deprecated not to use in latest drivers (it
>>>>doesn't use reference counts and the device returned by it can disappear in
>>>>any time).
>>>
>>>Did you forget to send this to the PCI maintainer for some reason?
>>
>>No, my badness, sorry.
>>
>>
>>>Anyway, no, I don't want these functions marked this way, it's only
>>>going to cause build noise.  I'd much rather you, or others, send me
>>>patches that remove the usage of these functions so I can just delete
>>>them entirely.
>>
>>When the patch was here
>>(http://www.fi.muni.cz/~xslaby/lnx/lnx-pci_find-2.6.13-r3g4_3.patch --
>>it'll be certainly sliced into many pieces; of course I didn't cc you
>>:(
> 
> 
> Yes, I can't take anything so big.  Just break it up into pieces please.

*It removes most occurences of pci_find_device in the kernel tree.
*pci_(get|find)_device(x, ANY_ID, ANY_ID, x) changes to for_each_pci_dev(x).

Generated in 2.6.13-rc5-mm1 kernel version.

  arch/alpha/kernel/sys_alcor.c                |    3 +-
  arch/alpha/kernel/sys_sio.c                  |    8 ++---
  arch/frv/mb93090-mb00/pci-frv.c              |    8 +----
  arch/frv/mb93090-mb00/pci-irq.c              |    4 --
  arch/i386/kernel/cpu/cpufreq/gx-suspmod.c    |    6 +---
  arch/i386/pci/acpi.c                         |    2 -
  arch/i386/pci/irq.c                          |    6 ++--
  arch/m68k/atari/hades-pci.c                  |    4 --
  arch/ppc/kernel/pci.c                        |   21 ++++++++-------
  arch/ppc/platforms/85xx/mpc85xx_cds_common.c |    9 ++++--
  arch/ppc64/kernel/eeh.c                      |    2 -
  drivers/char/ip2main.c                       |    9 +++---
  drivers/char/istallion.c                     |    9 +++---
  drivers/char/mxser.c                         |    5 ++-
  drivers/char/rocket.c                        |    2 -
  drivers/char/specialix.c                     |   13 ++++++---
  drivers/char/stallion.c                      |    6 ++--
  drivers/char/sx.c                            |    2 -
  drivers/char/watchdog/alim1535_wdt.c         |   15 ++++++++--
  drivers/char/watchdog/alim7101_wdt.c         |    7 +++--
  drivers/char/watchdog/i8xx_tco.c             |    5 ++-
  drivers/ide/pci/alim15x3.c                   |   17 ++++++++++--
  drivers/ide/pci/cs5530.c                     |    7 ++++-
  drivers/ide/pci/hpt366.c                     |   17 ++++++++----
  drivers/ide/pci/pdc202xx_new.c               |   13 +++++----
  drivers/ide/pci/piix.c                       |    3 --
  drivers/ide/pci/serverworks.c                |   17 ++++++++++--
  drivers/ide/pci/sis5513.c                    |    3 +-
  drivers/ide/pci/via82cxxx.c                  |   14 +++++++++-
  drivers/ide/setup-pci.c                      |    3 --
  drivers/isdn/hisax/avm_pci.c                 |    8 ++++-
  drivers/isdn/hisax/bkm_a4t.c                 |    2 -
  drivers/isdn/hisax/bkm_a8.c                  |    2 -
  drivers/isdn/hisax/diva.c                    |    8 ++---
  drivers/isdn/hisax/elsa.c                    |    4 +-
  drivers/isdn/hisax/enternow_pci.c            |    8 ++---
  drivers/isdn/hisax/gazel.c                   |    2 -
  drivers/isdn/hisax/hfc_pci.c                 |   12 ++++++--
  drivers/isdn/hisax/niccy.c                   |    2 -
  drivers/isdn/hisax/nj_s.c                    |    2 -
  drivers/isdn/hisax/nj_u.c                    |    2 -
  drivers/isdn/hisax/sedlbauer.c               |    2 -
  drivers/isdn/hisax/telespci.c                |    2 -
  drivers/isdn/hisax/w6692.c                   |    2 -
  drivers/isdn/hysdn/hysdn_init.c              |    5 ++-
  drivers/macintosh/via-pmu.c                  |   20 +++++++++-----
  drivers/macintosh/via-pmu68k.c               |    6 ++--
  drivers/media/radio/radio-maestro.c          |    6 ++--
  drivers/media/video/bttv-cards.c             |    2 -
  drivers/media/video/stradis.c                |    3 +-
  drivers/media/video/zoran_card.c             |    2 -
  drivers/media/video/zr36120.c                |    9 ++++--
  drivers/mtd/devices/pmc551.c                 |   15 +++++-----
  drivers/mtd/maps/amd76xrom.c                 |    3 +-
  drivers/mtd/maps/ichxrom.c                   |    3 +-
  drivers/mtd/maps/l440gx.c                    |   14 ++++++++--
  drivers/mtd/maps/scx200_docflash.c           |   23 +++++++++++++---
  drivers/net/gt96100eth.c                     |   15 +++++++---
  drivers/net/sunhme.c                         |    5 ++-
  drivers/net/wan/sdladrv.c                    |   11 +++++---
  drivers/pci/hotplug/fakephp.c                |    2 -
  drivers/pci/pci.c                            |    4 +-
  drivers/pci/proc.c                           |    5 ++-
  drivers/pci/setup-irq.c                      |    4 +-
  drivers/scsi/BusLogic.c                      |    6 ++--
  drivers/scsi/advansys.c                      |    6 +++-
  drivers/scsi/aic7xxx_old.c                   |    2 -
  drivers/scsi/cpqfcTSinit.c                   |    4 ++
  drivers/scsi/dpt_i2o.c                       |    5 ++-
  drivers/scsi/eata_pio.c                      |    3 +-
  drivers/scsi/fdomain.c                       |   30 +++++++++++++--------
  drivers/scsi/gdth.c                          |    9 ++++--
  drivers/scsi/initio.c                        |    4 ++
  drivers/scsi/qlogicfc.c                      |    2 -
  drivers/scsi/qlogicisp.c                     |    3 --
  drivers/telephony/ixj.c                      |    3 +-
  drivers/video/igafb.c                        |   12 ++++++--
  drivers/video/pm3fb.c                        |   37 
+++++++++++----------------
  include/asm-i386/ide.h                       |    7 ++++-
  sound/core/memalloc.c                        |   10 +++----
  sound/pci/ali5451/ali5451.c                  |   18 ++++++++-----
  sound/pci/au88x0/au88x0.c                    |   20 +++++++-------
  sound/pci/cs46xx/cs46xx_lib.c                |    3 +-
  sound/pci/via82xx.c                          |    3 +-
  84 files changed, 401 insertions(+), 241 deletions(-)

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

Here, it is:
http://www.fi.muni.cz/~xslaby/lnx/pci_find/

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10
