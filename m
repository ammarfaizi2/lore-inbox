Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267145AbTAVBCW>; Tue, 21 Jan 2003 20:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTAVBCW>; Tue, 21 Jan 2003 20:02:22 -0500
Received: from hera.cwi.nl ([192.16.191.8]:18677 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267145AbTAVBCU>;
	Tue, 21 Jan 2003 20:02:20 -0500
From: Andries.Brouwer@cwi.nl
Date: Wed, 22 Jan 2003 02:11:26 +0100 (MET)
Message-Id: <UTC200301220111.h0M1BQg03940.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: 3c509.c
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Please Don't do this:

    +#include <linux/mca-legacy.h>

    If you're getting MCA_NOTFOUND undefined, it's because
    CONFIG_MCA_LEGACY isn't set when mca.h is included
    (either because it's not in your kernel config, or 
    possibly because config.h isn't included into the right place
    in the driver---the latter doesn't look to be the problem
    for 3c509.c).

Yes, you are right. But.
(I do not have an MCA machine myself, this was just from
source inspection. Let me grep a bit more.)

Suppose CONFIG_MCA_LEGACY is not set, and CONFIG_MCA is set.
Then, as you say, <linux/mca-legacy.h> is not included.

Thus, the only definition of MCA_NOTFOUND is not seen.

Thus, all files that use it (eexpress.c, smctr.c, madgemc.c,
3c509.c, at1700.c, 3c523.c, depca.c, 3c527.c, sk_mca.c,
eicon_mod.c, ibmmca.c, mca_53c9x.c, fd_mcs.c, aha1542.c,
sim710.c, ps2esdi.c, sb_card.c) will not compile, if I am
not mistaken.

If you want to preserve the distinction between CONFIG_MCA and
CONFIG_MCA_LEGACY, then I suppose you want to replace the former
by the latter in all of the drivers mentioned?

Andries
