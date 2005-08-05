Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVHEOzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVHEOzH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVHEOx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:53:58 -0400
Received: from fep17.inet.fi ([194.251.242.242]:32749 "EHLO fep17.inet.fi")
	by vger.kernel.org with ESMTP id S262307AbVHEOuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:50:35 -0400
Subject: [PATCH 0/8] convert kcalloc to kzalloc
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <ikr7i5.scnqnt.cy0lwg6fxw1fxjszsav6l2tlz.beaver@cs.helsinki.fi>
Date: Fri, 5 Aug 2005 17:50:31 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchkit converts kcalloc(1, ...) to the new kzalloc(). Andrew, please
let me know if you don't want to pick up some of these. I will feed them to
subsystem maintainers once kzalloc() hits Linus' tree.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 arch/ia64/sn/kernel/io_init.c           |    2 
 arch/ia64/sn/kernel/tiocx.c             |    2 
 arch/ia64/sn/pci/tioca_provider.c       |    8 +--
 arch/ppc64/kernel/pSeries_reconfig.c    |    2 
 drivers/block/aoe/aoedev.c              |    2 
 drivers/char/mbcs.c                     |    2 
 drivers/i2c/chips/isp1301_omap.c        |    2 
 drivers/infiniband/core/sysfs.c         |    2 
 drivers/input/gameport/emu10k1-gp.c     |    2 
 drivers/input/gameport/fm801-gp.c       |    2 
 drivers/input/gameport/ns558.c          |    4 -
 drivers/input/joystick/a3d.c            |    2 
 drivers/input/joystick/adi.c            |    2 
 drivers/input/joystick/analog.c         |    2 
 drivers/input/joystick/cobra.c          |    2 
 drivers/input/joystick/db9.c            |    2 
 drivers/input/joystick/gamecon.c        |    2 
 drivers/input/joystick/gf2k.c           |    2 
 drivers/input/joystick/grip.c           |    2 
 drivers/input/joystick/grip_mp.c        |    2 
 drivers/input/joystick/guillemot.c      |    2 
 drivers/input/joystick/interact.c       |    2 
 drivers/input/joystick/sidewinder.c     |    2 
 drivers/input/joystick/tmdc.c           |    2 
 drivers/input/joystick/turbografx.c     |    2 
 drivers/input/keyboard/corgikbd.c       |    2 
 drivers/input/mouse/psmouse-base.c      |    2 
 drivers/input/serio/serport.c           |    4 -
 drivers/pci/hotplug/sgi_hotplug.c       |    2 
 drivers/pci/pci-sysfs.c                 |    2 
 drivers/scsi/sata_qstor.c               |    2 
 drivers/usb/atm/usbatm.c                |    2 
 drivers/usb/core/hcd.c                  |    2 
 drivers/usb/host/ehci-sched.c           |    2 
 drivers/usb/host/isp116x-hcd.c          |    2 
 drivers/usb/host/sl811-hcd.c            |    2 
 drivers/usb/input/acecad.c              |    2 
 drivers/usb/input/itmtouch.c            |    2 
 drivers/usb/input/pid.c                 |    2 
 fs/cifs/connect.c                       |   82 ++++++++++++++++----------------
 fs/freevxfs/vxfs_super.c                |    2 
 sound/arm/sa11xx-uda1341.c              |    2 
 sound/core/control.c                    |   12 ++--
 sound/core/control_compat.c             |    8 +--
 sound/core/device.c                     |    2 
 sound/core/hwdep.c                      |    2 
 sound/core/info.c                       |    8 +--
 sound/core/init.c                       |    4 -
 sound/core/oss/mixer_oss.c              |   26 +++++-----
 sound/core/oss/pcm_oss.c                |    2 
 sound/core/oss/pcm_plugin.c             |    2 
 sound/core/pcm.c                        |    6 +-
 sound/core/pcm_memory.c                 |    2 
 sound/core/pcm_native.c                 |    2 
 sound/core/rawmidi.c                    |    6 +-
 sound/core/seq/instr/ainstr_gf1.c       |    2 
 sound/core/seq/instr/ainstr_iw.c        |    6 +-
 sound/core/seq/oss/seq_oss_init.c       |    2 
 sound/core/seq/oss/seq_oss_midi.c       |    6 +-
 sound/core/seq/oss/seq_oss_readq.c      |    2 
 sound/core/seq/oss/seq_oss_synth.c      |    4 -
 sound/core/seq/oss/seq_oss_timer.c      |    2 
 sound/core/seq/oss/seq_oss_writeq.c     |    2 
 sound/core/seq/seq_clientmgr.c          |    2 
 sound/core/seq/seq_device.c             |    2 
 sound/core/seq/seq_dummy.c              |    2 
 sound/core/seq/seq_fifo.c               |    2 
 sound/core/seq/seq_instr.c              |    4 -
 sound/core/seq/seq_memory.c             |    2 
 sound/core/seq/seq_midi.c               |    2 
 sound/core/seq/seq_midi_event.c         |    2 
 sound/core/seq/seq_ports.c              |    4 -
 sound/core/seq/seq_prioq.c              |    2 
 sound/core/seq/seq_queue.c              |    2 
 sound/core/seq/seq_system.c             |    4 -
 sound/core/seq/seq_timer.c              |    2 
 sound/core/seq/seq_virmidi.c            |    6 +-
 sound/core/timer.c                      |   10 +--
 sound/drivers/dummy.c                   |    4 -
 sound/drivers/mpu401/mpu401_uart.c      |    2 
 sound/drivers/mtpav.c                   |    2 
 sound/drivers/opl3/opl3_lib.c           |    2 
 sound/drivers/opl3/opl3_oss.c           |    2 
 sound/drivers/opl4/opl4_lib.c           |    2 
 sound/drivers/serial-u16550.c           |    2 
 sound/drivers/vx/vx_core.c              |    2 
 sound/drivers/vx/vx_pcm.c               |    2 
 sound/i2c/cs8427.c                      |    2 
 sound/i2c/i2c.c                         |    4 -
 sound/i2c/l3/uda1341.c                  |    4 -
 sound/i2c/other/ak4114.c                |    2 
 sound/i2c/other/ak4117.c                |    2 
 sound/i2c/tea6330t.c                    |    2 
 sound/isa/ad1816a/ad1816a_lib.c         |    2 
 sound/isa/ad1848/ad1848_lib.c           |    2 
 sound/isa/cs423x/cs4231_lib.c           |    2 
 sound/isa/es1688/es1688_lib.c           |    2 
 sound/isa/es18xx.c                      |    2 
 sound/isa/gus/gus_main.c                |    2 
 sound/isa/gus/gus_mem_proc.c            |    4 -
 sound/isa/gus/gus_pcm.c                 |    2 
 sound/isa/opl3sa2.c                     |    2 
 sound/isa/opti9xx/opti92x-ad1848.c      |    2 
 sound/isa/sb/emu8000.c                  |    2 
 sound/isa/sb/emu8000_pcm.c              |    2 
 sound/isa/sb/sb16_csp.c                 |    2 
 sound/isa/sb/sb_common.c                |    2 
 sound/pci/ac97/ac97_codec.c             |    4 -
 sound/pci/ac97/ak4531_codec.c           |    2 
 sound/pci/ali5451/ali5451.c             |    2 
 sound/pci/atiixp.c                      |    2 
 sound/pci/atiixp_modem.c                |    2 
 sound/pci/au88x0/au88x0.c               |    2 
 sound/pci/azt3328.c                     |    2 
 sound/pci/bt87x.c                       |    2 
 sound/pci/ca0106/ca0106_main.c          |    6 +-
 sound/pci/cmipci.c                      |    2 
 sound/pci/cs4281.c                      |    2 
 sound/pci/cs46xx/cs46xx_lib.c           |    4 -
 sound/pci/emu10k1/emu10k1_main.c        |    2 
 sound/pci/emu10k1/emu10k1x.c            |    6 +-
 sound/pci/emu10k1/emufx.c               |    8 +--
 sound/pci/emu10k1/emupcm.c              |   10 +--
 sound/pci/emu10k1/p16v.c                |    4 -
 sound/pci/ens1370.c                     |    2 
 sound/pci/es1938.c                      |    2 
 sound/pci/es1968.c                      |    6 +-
 sound/pci/fm801.c                       |    2 
 sound/pci/hda/hda_codec.c               |    6 +-
 sound/pci/hda/hda_generic.c             |    4 -
 sound/pci/hda/hda_intel.c               |    2 
 sound/pci/hda/patch_analog.c            |    6 +-
 sound/pci/hda/patch_cmedia.c            |    2 
 sound/pci/hda/patch_realtek.c           |    6 +-
 sound/pci/hda/patch_sigmatel.c          |    4 -
 sound/pci/ice1712/aureon.c              |    2 
 sound/pci/ice1712/ice1712.c             |    2 
 sound/pci/ice1712/ice1724.c             |    2 
 sound/pci/ice1712/juli.c                |    2 
 sound/pci/ice1712/phase.c               |    4 -
 sound/pci/ice1712/pontis.c              |    2 
 sound/pci/intel8x0.c                    |    2 
 sound/pci/intel8x0m.c                   |    2 
 sound/pci/korg1212/korg1212.c           |    2 
 sound/pci/maestro3.c                    |    2 
 sound/pci/mixart/mixart.c               |    4 -
 sound/pci/nm256/nm256.c                 |    2 
 sound/pci/sonicvibes.c                  |    2 
 sound/pci/trident/trident_main.c        |    4 -
 sound/pci/via82xx.c                     |    2 
 sound/pci/via82xx_modem.c               |    2 
 sound/pci/ymfpci/ymfpci_main.c          |    6 +-
 sound/pcmcia/pdaudiocf/pdaudiocf_core.c |    2 
 sound/ppc/pmac.c                        |    2 
 sound/sparc/amd7930.c                   |    2 
 sound/sparc/cs4231.c                    |    4 -
 sound/synth/emux/emux.c                 |    2 
 sound/synth/emux/emux_seq.c             |    2 
 sound/synth/emux/soundfont.c            |    8 +--
 sound/synth/util_mem.c                  |    2 
 sound/usb/usbaudio.c                    |    2 
 sound/usb/usbmidi.c                     |    6 +-
 sound/usb/usbmixer.c                    |   10 +--
 sound/usb/usx2y/usbusx2yaudio.c         |    2 
 164 files changed, 294 insertions(+), 294 deletions(-)
