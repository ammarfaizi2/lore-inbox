Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVIYMay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVIYMay (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 08:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVIYMax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 08:30:53 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:15057 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1751255AbVIYMax
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 08:30:53 -0400
Date: Sun, 25 Sep 2005 15:30:49 +0300
From: Ville Herva <v@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Upgrade 2.6.12-rc4 -> 2.6.13.1 broke DVD-R writing (fails consistenly in OPC phase)
Message-ID: <20050925123049.GA24760@viasys.com>
Mime-Version: 1.0
Content-Type: text/PLAIN; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I upgraded from 2.6.12-rc4 to 2.6.13.1, I can no longer write DVD-R
(haven't tried DVD+R nor CD-R). 

The command 

 growisofs -r -l -J -R -f -graft-points ${=FILES} -Z /dev/hdc

always gives:

 :-[ PERFORM OPC failed with SK=3h/ASC=73h/ACQ=03h]: Input/output error

Nothing relevant in dmesg.

The drive is Optoride DVD±RW DD0401, the medium is Verbatim DVD-R 8x, and
the chipset is i815; Celeron Tualatin 1.4GHZ; Abit ST6R.

I tried the growisofs command probably a dozen times, rebooted and powered
off in the middle¹. I tried a couple of other discs from the same ("known
good") batch. cdrecord also fails. I tried to set -speed=1, 2, 4, but
growisofs claims setting speed to anything but 8x does not succeed.

The drive is able to read CD and DVD media just fine with 2.6.13.1.

I booted back to 2.6.12-rc4 and the recording succeeded at the first try. I
used the exact same disc that had failed with 2.6.13.1.

The .config from 2.6.12-rc4 and 2.6.13.1 is nearly identical, but with
2.6.13.1 I use HZ=250 (that being the default nowadays) and 
2.6.13.1 has CONFIG_PREEMPT_VOLUNTARY=y instead of 2.6.12-rc4's
CONFIG_PREEMPT=y and CONFIG_PREEMPT_BKL=y ².

Any ideas?


-- v -- 

v@iki.fi

¹) In past, the DVD-R drive has sometimes gotten so confused it needs a
   power off before it co-operates. However, in those cases it has stopped 
   responsing altogether, which it didn't do this time.
²) The desktop does seem more responsive with 2.6.13.1-


