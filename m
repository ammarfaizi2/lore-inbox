Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261537AbTDCSgH 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 13:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S262577AbTDCSgH 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 13:36:07 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:35026 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261537AbTDCSgA 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 13:36:00 -0500
Message-Id: <200304031846.h33IkNGi019484@locutus.cmf.nrl.navy.mil>
To: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [ATM] a few more changes for people to test
In-reply-to: Your message of "Thu, 27 Mar 2003 17:28:28 EST."
             <200303272228.h2RMSSGi009141@locutus.cmf.nrl.navy.mil> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Thu, 03 Apr 2003 13:46:22 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

besides the previous changes, this release:

. should no longer race when opening vcc's -- atm_find_ci is obselete
  the upper layer always allocates the vpi/vci with the proper locking
  held
. fixes a race for device numbering in atm_dev_register()
. make the list of vcc's global.  this simplifies the code quite a bit,
  and for a vast majority (single atm card) its essentially the same.
. converts vcc->itf to vcc->sk->bound_dev_if
. lets proc/fore200e/eni walk the vcc list safely now

i think locking in the bottom halves of the nicstar/idt77252 is now correct.
since i dont have any idt77252 cards, i only tested the nicstar but the 
code is essentially the same.  the lanai and iphase drivers need similar
work done.  anyone willing to test some changes?  (again, i dont have these
cards).

ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_66_diffs
ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_4_20_diffs
