Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTJ1Jf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 04:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTJ1Jf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 04:35:28 -0500
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:49325 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S263903AbTJ1JfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 04:35:20 -0500
Message-ID: <3F9E3858.5030601@revicon.com>
Date: Tue, 28 Oct 2003 10:35:20 +0100
From: Lars Knudsen <gandalf@revicon.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: SiS900 driver multicast problems and patch.
References: <3F9E2B6C.30000@revicon.com> <yw1xd6ch67sb.fsf@kth.se>
In-Reply-To: <yw1xd6ch67sb.fsf@kth.se>
Content-Type: multipart/mixed;
 boundary="------------070502040208080709030301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070502040208080709030301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Måns Rullgård wrote:

>Lars Knudsen <gandalf@revicon.com> writes:
>
>  
>
>>After upgrading to kernel 2.4.22 we discovered that multicast was no
>>longer handled properly by the SiS900. Examining the changes between
>>2.4.19 and 2.4.22 it is clear that the handling of multicast was
>>changed but a bug was introduced.
>>    
>>
>
>Your patch is broken.  Long lines are wrapped, tabs are converted to
>spaces and it is reversed.
>  
>
Ah, the wonders of cut and paste and a mail program trying to be helpfull.
Here is an updated version. Sorry for the extra noise.

\Lars Knudsen

--------------070502040208080709030301
Content-Type: text/plain;
 name="sispatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sispatch"

--- sis900.c.orig	Mon Oct 27 17:48:52 2003
+++ sis900.c	Mon Oct 27 17:49:36 2003
@@ -2101,9 +2101,8 @@
 		rx_mode = RFAAB;
 		for (i = 0, mclist = net_dev->mc_list; mclist && i < net_dev->mc_count;
 		     i++, mclist = mclist->next) {
-			unsigned int bit_nr =
-				sis900_mcast_bitnr(mclist->dmi_addr, revision);
-			mc_filter[bit_nr >> 4] |= (1 << bit_nr);
+			set_bit(sis900_mcast_bitnr(mclist->dmi_addr, revision),
+				mc_filter);
 		}
 	}
 

--------------070502040208080709030301--

