Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTDOSsM (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 14:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263960AbTDOSsM 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 14:48:12 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:62431 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S263840AbTDOSsK (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 14:48:10 -0400
Message-Id: <200304151858.h3FIwkGi031560@locutus.cmf.nrl.navy.mil>
To: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ATM] more changes available for testing...
In-reply-to: Your message of "Thu, 03 Apr 2003 13:46:22 EST."
             <200304031846.h33IkNGi019484@locutus.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Tue, 15 Apr 2003 14:58:46 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_66_diffs
ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_4_20_diffs

new changes with this release --

. the vcc socket list is now global instead of per interface
. more drivers have been tested with the smp locking (iphase, fore200e)
  other have the changes, but are untested due to no hardware (lanai, idt77252)
. alloc_tx, free_rx_skb are no longer part of struct atmdev
. iovcnt has been removed -- linux-atm should use skb.nr_frags in the
  future
. ATM_PDUOVHD has been removed (it was 0 anyway)
. some (very unlikely) races in net/atm/svc.c were addressed
. listenq was dropped in favor just using the receive_queue of the 
  listening 'socket'
. 2.4 makefile issues corrected (or so i think)
. SO_ATMQOS should be more 'stack' friendly
. skb->cb is memzero'ed before calling netif_rx()

previous changes included --

. should no longer race when opening vcc's -- atm_find_ci is obselete
  the upper layer always allocates the vpi/vci with the proper locking
  held
. fixes a race for device numbering in atm_dev_register()
. make the list of vcc's global.  this simplifies the code quite a bit,
  and for a vast majority (single atm card) its essentially the same.
. converts vcc->itf to vcc->sk->bound_dev_if
. lets proc/fore200e/eni walk the vcc list safely now

>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
