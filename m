Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTEGAUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262121AbTEGATW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 20:19:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15745 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262131AbTEGATL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 20:19:11 -0400
Date: Tue, 6 May 2003 17:31:49 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: [BK PATCH] i2c driver changes for 2.5.69
Message-ID: <20030507003148.GA4622@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some i2c driver changes for 2.5.69.  These consist of some
small bug fixes, and a set of larger patches from Gerd Knorr that get
rid of a lot of static arrays within the i2c driver core.  These changes
will also allow us to add proper reference counting and move the i2c
core to use the driver model more in the future.

I've also updated the very out of date MAINTAINERS entry for the i2c code.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/i2c-2.5

thanks,

greg k-h

 MAINTAINERS                               |   31 +-
 drivers/i2c/busses/i2c-ali15x3.c          |    1 
 drivers/i2c/busses/i2c-amd756.c           |    1 
 drivers/i2c/busses/i2c-amd8111.c          |    1 
 drivers/i2c/busses/i2c-i801.c             |    1 
 drivers/i2c/busses/i2c-isa.c              |    1 
 drivers/i2c/busses/i2c-piix4.c            |    1 
 drivers/i2c/busses/i2c-viapro.c           |    1 
 drivers/i2c/chips/adm1021.c               |    2 
 drivers/i2c/chips/it87.c                  |   90 +++++++
 drivers/i2c/chips/lm75.c                  |    2 
 drivers/i2c/chips/via686a.c               |    2 
 drivers/i2c/chips/w83781d.c               |    2 
 drivers/i2c/i2c-core.c                    |  351 +++++++++++++-----------------
 drivers/i2c/i2c-dev.c                     |   62 ++---
 drivers/i2c/i2c-keywest.c                 |    3 
 drivers/media/video/bt832.c               |   22 -
 drivers/media/video/bttv-if.c             |   64 +----
 drivers/media/video/bttv.h                |    1 
 drivers/media/video/bttvp.h               |    3 
 drivers/media/video/dpc7146.c             |   13 -
 drivers/media/video/msp3400.c             |    2 
 drivers/media/video/mxb.c                 |   33 +-
 drivers/media/video/saa5249.c             |    6 
 drivers/media/video/saa7134/saa7134-i2c.c |   24 --
 drivers/media/video/tda7432.c             |    2 
 drivers/media/video/tda9875.c             |    2 
 drivers/media/video/tda9887.c             |   20 -
 drivers/media/video/tuner.c               |   22 -
 drivers/media/video/tvaudio.c             |    9 
 drivers/media/video/tvmixer.c             |   24 --
 include/linux/i2c.h                       |   40 ++-
 32 files changed, 409 insertions(+), 430 deletions(-)
-----

<warp:mercury.d2dc.net>:
  o i2c: it87 patch

Gerd Knorr:
  o i2c #3/3: add class field to i2c_adapter
  o i2c #2/3: add i2c_clients_command
  o i2c #1/3: listify i2c core

Greg Kroah-Hartman:
  o i2c: fix compile error due to previous patches
  o i2c: fix up the MAINTAINERS i2c entry
  o i2c: fix oops on startup of it87 driver

Paul Mackerras:
  o i2c: i2c-keywest.c irq handler type

