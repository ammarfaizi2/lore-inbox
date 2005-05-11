Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVEKH56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVEKH56 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEKH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 03:57:58 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:59230 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261908AbVEKH53 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 03:57:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nwEiw/j5pzYr1KEVldJIqtGFGbzRVGAwaayYvUZHcHqrvJXb+u8cxCy0hFpN8jaWZsXOKJwuVUzEBNLC7Xsn6tPLKJJ38mbY4FwPNZuHclrEdQkIWv2EEtNlUTR81hBakMjtruXdz7Un8hjG6dZZGwPaEUBeZdvNVoStM4JQo1g=
Message-ID: <253818670505110057b96cf62@mail.gmail.com>
Date: Wed, 11 May 2005 03:57:29 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
Reply-To: Yani Ioannou <yani.ioannou@gmail.com>
To: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc4 2/3] (dynamic sysfs callbacks) device_attribute
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This second patch removes the "initialization from incompatible
pointer type" warnings resulting from the code using the old callback
function signatures. It is mainly auto-generated (see inlined
shell/perl scripts below), and is 308K so I'm linking to it:

http://osdn.dl.sourceforge.net/sourceforge/bmcsensors-26/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff

Note that the diffstat # of changes (approx # of sysfs callbacks)
gives you some idea of which drivers will most benefit from this
patch.

Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>

Thanks,
Yani

---
 Documentation/filesystems/sysfs.txt      |    2
 arch/arm/common/amba.c                   |    2
 arch/arm/kernel/ecard.c                  |   12 +-
 arch/arm26/kernel/ecard.c                |   10 +-
 arch/ia64/sn/kernel/tiocx.c              |    4
 arch/parisc/kernel/drivers.c             |    2
 arch/ppc/kernel/pci.c                    |    2
 arch/ppc/syslib/ocp.c                    |    2
 arch/ppc/syslib/of_device.c              |    2
 arch/ppc64/kernel/of_device.c            |    2
 arch/ppc64/kernel/pci.c                  |    2
 arch/ppc64/kernel/vio.c                  |    4
 drivers/base/dmapool.c                   |    2
 drivers/base/interface.c                 |    4
 drivers/base/power/sysfs.c               |    4
 drivers/block/ub.c                       |    2
 drivers/char/hvcs.c                      |   14 +--
 drivers/char/mbcs.c                      |    4
 drivers/char/mwave/mwavedd.c             |    2
 drivers/char/tpm/tpm.c                   |    6 -
 drivers/dio/dio-sysfs.c                  |   10 +-
 drivers/eisa/eisa-bus.c                  |    4
 drivers/i2c/chips/adm1021.c              |    6 -
 drivers/i2c/chips/adm1025.c              |   28 +++---
 drivers/i2c/chips/adm1026.c              |   98 ++++++++++++------------
 drivers/i2c/chips/adm1031.c              |   44 +++++-----
 drivers/i2c/chips/asb100.c               |   46 +++++------
 drivers/i2c/chips/ds1621.c               |    6 -
 drivers/i2c/chips/fscher.c               |    8 -
 drivers/i2c/chips/fscpos.c               |   16 +--
 drivers/i2c/chips/gl518sm.c              |   12 +-
 drivers/i2c/chips/gl520sm.c              |    8 -
 drivers/i2c/chips/it87.c                 |   50 ++++++------
 drivers/i2c/chips/lm63.c                 |   24 ++---
 drivers/i2c/chips/lm75.c                 |    4
 drivers/i2c/chips/lm77.c                 |   14 +--
 drivers/i2c/chips/lm78.c                 |   36 ++++----
 drivers/i2c/chips/lm80.c                 |   20 ++--
 drivers/i2c/chips/lm83.c                 |    6 -
 drivers/i2c/chips/lm85.c                 |   72 ++++++++---------
 drivers/i2c/chips/lm87.c                 |   46 +++++------
 drivers/i2c/chips/lm90.c                 |   12 +-
 drivers/i2c/chips/lm92.c                 |   14 +--
 drivers/i2c/chips/max1619.c              |    6 -
 drivers/i2c/chips/pc87360.c              |   68 ++++++++--------
 drivers/i2c/chips/pcf8574.c              |    6 -
 drivers/i2c/chips/pcf8591.c              |   10 +-
 drivers/i2c/chips/sis5595.c              |   34 ++++----
 drivers/i2c/chips/smsc47b397.c           |    4
 drivers/i2c/chips/smsc47m1.c             |   20 ++--
 drivers/i2c/chips/via686a.c              |   32 +++----
 drivers/i2c/chips/w83627hf.c             |   56 ++++++-------
 drivers/i2c/chips/w83781d.c              |   52 ++++++------
 drivers/i2c/chips/w83l785ts.c            |    4
 drivers/i2c/i2c-core.c                   |    4
 drivers/ieee1394/nodemgr.c               |   16 +--
 drivers/ieee1394/sbp2.c                  |    2
 drivers/input/gameport/gameport.c        |    4
 drivers/input/keyboard/atkbd.c           |    4
 drivers/input/mouse/psmouse.h            |    4
 drivers/input/serio/serio.c              |   16 +--
 drivers/macintosh/therm_adt746x.c        |    8 -
 drivers/macintosh/therm_pm72.c           |    4
 drivers/macintosh/therm_windtunnel.c     |    4
 drivers/mca/mca-bus.c                    |    4
 drivers/message/fusion/mptscsih.c        |    2
 drivers/mmc/mmc_sysfs.c                  |    2
 drivers/pci/hotplug/cpqphp_sysfs.c       |    4
 drivers/pci/hotplug/shpchp_sysfs.c       |    4
 drivers/pci/pci-sysfs.c                  |    6 -
 drivers/pcmcia/ds.c                      |    4
 drivers/pnp/card.c                       |    4
 drivers/pnp/interface.c                  |    8 -
 drivers/s390/block/dasd_devmap.c         |   10 +-
 drivers/s390/block/dcssblk.c             |   24 ++---
 drivers/s390/char/raw3270.c              |    6 -
 drivers/s390/char/tape_core.c            |   10 +-
 drivers/s390/char/vmlogrdr.c             |   12 +-
 drivers/s390/cio/ccwgroup.c              |    6 -
 drivers/s390/cio/chsc.c                  |    6 -
 drivers/s390/cio/cmf.c                   |   12 +-
 drivers/s390/cio/device.c                |   14 +--
 drivers/s390/net/claw.c                  |   40 ++++-----
 drivers/s390/net/ctcmain.c               |   18 ++--
 drivers/s390/net/lcs.c                   |   10 +-
 drivers/s390/net/netiucv.c               |   44 +++++-----
 drivers/s390/net/qeth_sys.c              |  126 +++++++++++++++----------------
 drivers/s390/scsi/zfcp_scsi.c            |    2
 drivers/s390/scsi/zfcp_sysfs_adapter.c   |   10 +-
 drivers/s390/scsi/zfcp_sysfs_port.c      |   10 +-
 drivers/s390/scsi/zfcp_sysfs_unit.c      |    6 -
 drivers/scsi/53c700.c                    |    2
 drivers/scsi/arm/eesox.c                 |    4
 drivers/scsi/arm/powertec.c              |    4
 drivers/scsi/ipr.c                       |    2
 drivers/scsi/megaraid/megaraid_mbox.c    |    4
 drivers/scsi/scsi_sysfs.c                |   28 +++---
 drivers/sh/superhyway/superhyway-sysfs.c |    2
 drivers/usb/core/sysfs.c                 |   24 ++---
 drivers/usb/gadget/dummy_hcd.c           |    4
 drivers/usb/gadget/file_storage.c        |    8 -
 drivers/usb/gadget/net2280.c             |    6 -
 drivers/usb/gadget/pxa2xx_udc.c          |    2
 drivers/usb/input/aiptek.c               |   78 +++++++++----------
 drivers/usb/misc/cytherm.c               |   20 ++--
 drivers/usb/misc/phidgetkit.c            |   14 +--
 drivers/usb/misc/phidgetservo.c          |    4
 drivers/usb/misc/usbled.c                |    4
 drivers/usb/serial/ftdi_sio.c            |    6 -
 drivers/usb/storage/scsiglue.c           |    4
 drivers/video/gbefb.c                    |    4
 drivers/video/w100fb.c                   |   12 +-
 drivers/w1/w1.c                          |   16 +--
 drivers/w1/w1_family.h                   |    4
 drivers/w1/w1_smem.c                     |    8 -
 drivers/w1/w1_therm.c                    |    8 -
 drivers/zorro/zorro-sysfs.c              |    4
 include/asm-ppc/ocp.h                    |    2
 118 files changed, 854 insertions(+), 854 deletions(-)

--- updatedyncallbackdevattr.pl

#!/usr/bin/perl

use strict;

my $infile=shift;

if(!defined $infile){
        open(IN,"<&STDIN") or die "Could not open an input stream";
}else{
        open(IN,"<$infile") or die "Could not open an input stream";
}

my $subs = 0;
my $code = "";

while(<IN>){$code.=$_};
close(IN);

$code =~ s/(static[\s\\]+?ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,[\s\\]*?char[\s\\]*?\*[^,);]*?)[\s\\]*?\)/$1,
void *private)/gs && $subs++;
$code =~ s/(static[\s\\]+?ssize_t[\s\\]+?[^(;]+?\(\s*?struct[\s\\]+?(?:device)[\s\\]*?\*[^,);]*?,[\s\\]*?const[\s\\]+?char[\s\\]*?\*[^,);]*?[\s\\]*?,[\s\\]*size_t[^,);]*?)[\s\\]*\)/$1,
void *private)/gs && $subs++;

if($subs){
        if(!defined $infile){
                open(OUT,">&STDOUT") or die "Could not open an output stream";
        }else{
                open(OUT,">$infile") or die "Could not open an output stream";
        }
        $|;
        print OUT $code;
        close(OUT);
        $infile && print STDOUT "$infile updated.\n";
}

---  doupdatedevattr.sh
#!/bin/sh
find linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn -type f -exec
./updatedyncallbackdevattr.pl {} \; 2>&1 |tee subs.log
