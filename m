Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263685AbUEKVlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbUEKVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 17:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUEKVlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 17:41:09 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:39697 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263685AbUEKVkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 17:40:55 -0400
Date: Tue, 11 May 2004 23:40:53 +0200
From: Daniele Venzano <webvenza@libero.it>
To: mike <mike@bristolreccc.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: problem with sis900 driver 2.6.5 +
Message-ID: <20040511214053.GB19101@picchio.gall.it>
Mail-Followup-To: mike <mike@bristolreccc.co.uk>,
	linux-kernel@vger.kernel.org
References: <1084300104.24569.8.camel@datacontrol> <20040511184142.GE12947@lorien.prodam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511184142.GE12947@lorien.prodam>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 03:41:42PM -0300, Luiz Fernando N. Capitulino wrote:
> Em Tue, May 11, 2004 at 07:28:24PM +0100, mike escreveu:
> 
> | In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
> | a problem with the sis900 eth driver
> | 
> | I have a sis chipset with integrated ethernet sis900 driver which has
> | always worked perfectly up to and including 2.6.3 (fedora)
In that time frame (2.6.3->2.6.4) there has been only this change in the driver itself, 
could you try to revert it and see if the problem disappears ?

diff -Nru a/drivers/net/sis900.c b/drivers/net/sis900.c
--- a/drivers/net/sis900.c      Wed Mar 10 18:56:09 2004
+++ b/drivers/net/sis900.c      Wed Mar 10 18:56:09 2004
@@ -2093,7 +2093,7 @@
                     i++, mclist = mclist->next) {
                        unsigned int bit_nr =
                                sis900_mcast_bitnr(mclist->dmi_addr, revision);
-                       mc_filter[bit_nr >> 4] |= (1 << bit_nr);
+                       mc_filter[bit_nr >> 4] |= (1 << (bit_nr & 0xf));
                }
        }
 

Also, could you send full dmesg in working/not working case ?

Thanks.

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

