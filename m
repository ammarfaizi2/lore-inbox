Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbRCGTiL>; Wed, 7 Mar 2001 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129734AbRCGTiC>; Wed, 7 Mar 2001 14:38:02 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:45316 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129136AbRCGThz>;
	Wed, 7 Mar 2001 14:37:55 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: gibbs@scsiguy.com
Date: Wed, 7 Mar 2001 20:37:17 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.4.2-ac13, aic7xxx without any device and oops
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <1671BE33779@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,
  your new driver complains loudly here, because of
ahc_match_scb is invoked with NULL scb, and it does not like that.

Call trace was:
   0xc01c9073: ahc_match_scb + 23/191
   0xc01c945d: ahc_search_qinfifo+ 333/1719 (it is first of two calls to ahc_match...)
   0xc01c9ede: ahc_abort_scbs + 102/758
   
I was too lazy to write down rest of oops from screen, but if you want,
I can catch them again.

My Adaptec is vid/did 9004:6178, subsystem vid/did 9004:7861 -
AHA-2940AU Single, and there is nothing connected to it currently. 
With -ac11 it works correctly, and I skipped -ac12.

Machine is dual PIII/800, and has enabled all debug options
except DEBUG_IOVIRT (i.e. it has enabled SLAB redzoning, if it
could make difference for your driver... it makes difference for
ncpfs ncp_d_validate :-( )
                                        Thanks,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
