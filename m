Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbUBUVeh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 16:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbUBUVef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 16:34:35 -0500
Received: from defout.telus.net ([199.185.220.240]:39055 "EHLO
	priv-edtnes51.telusplanet.net") by vger.kernel.org with ESMTP
	id S261610AbUBUVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 16:34:33 -0500
Subject: drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use
	in this function) 2.6.3-bk3
From: Bob Gill <gillb4@telusplanet.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077399402.22141.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 21 Feb 2004 14:36:43 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  The whole error message is (when building 2.6.3-bk3):
drivers/ieee1394/sbp2.c: In function `sbp2_alloc_device':
drivers/ieee1394/sbp2.c:734: error: `host' undeclared (first use in this
function)
drivers/ieee1394/sbp2.c:734: error: (Each undeclared identifier is
reported only once
drivers/ieee1394/sbp2.c:734: error: for each function it appears in.)
make[2]: *** [drivers/ieee1394/sbp2.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2

It gives the same message when building with the source from the 1394
subversion tree.  Apparently the declaration for 'host' is not where it
used to be. 

#ifdef CONFIG_IEEE1394_SBP2_PHYS_DMA
                /* Handle data movement if physical dma is not
                 * enabled/supportedon host controller */
                hpsb_register_addrspace(&sbp2_highlevel, host,
&sbp2_physdma_ops,
                                        0x0ULL, 0xfffffffcULL);
#endif

**--------------------------------------------------------------
highlevel.c (which isn't #included in sbp2.c) lists:
struct hl_host_info {
        struct list_head list;
        struct hpsb_host *host;
        size_t size;
        unsigned long key;
        void *data;
};

**(highlevel.h is #included in sbp2.c, highlevel.c isn't, and 
highlevel.h doesn't mention struct hl_host_info). 
**---------------------------------------------------------------
** The above information is intended merely for recreational value
   and may provide no practical information with respect to 
   resolving the problem as I have never been accused of being a
   systems programmer!  :)

If you need more info, please mail me as I'm not on the list.  TIA,

Bob

