Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265149AbUFVVs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbUFVVs2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266022AbUFVVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:47:29 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:39352 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265149AbUFVVpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:45:52 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: Support for new Apple laptop models
Date: Tue, 22 Jun 2004 17:45:31 -0400
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1087934829.1832.3.camel@gaston>
In-Reply-To: <1087934829.1832.3.camel@gaston>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_7hK2AtMMukNz/7C"
Message-Id: <200406221745.31553.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_7hK2AtMMukNz/7C
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday, June 22, 2004 4:07 pm, Benjamin Herrenschmidt wrote:
> This patch adds support for newer Apple laptop models. It adds the basic
> identification for the new motherboards and the cpufreq support for models
> using the new 7447A CPU from Motorola.

And here's a patch to add sound support for some of the newer PowerBooks.  It 
appears that this chip supports the AWACS sample rates, but has a 
snapper-style mixer.  Tested and works on my PowerBook5,4.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Jesse

--Boundary-00=_7hK2AtMMukNz/7C
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pmac-sound-aoakeylargo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmac-sound-aoakeylargo.patch"

===== sound/ppc/pmac.c 1.23 vs edited =====
--- 1.23/sound/ppc/pmac.c	2004-05-13 07:38:56 -04:00
+++ edited/sound/ppc/pmac.c	2004-06-22 17:40:39 -04:00
@@ -931,6 +931,13 @@
 		chip->freq_table = tumbler_freqs;
 		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
 	}
+	if (device_is_compatible(sound, "AOAKeylargo")) {
+		/* Seems to support the stock AWACS frequencies, but has
+		   a snapper mixer */
+		chip->model = PMAC_SNAPPER;
+		// chip->can_byte_swap = 0; /* FIXME: check this */
+		chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
+	}
 	prop = (unsigned int *)get_property(sound, "device-id", 0);
 	if (prop)
 		chip->device_id = *prop;

--Boundary-00=_7hK2AtMMukNz/7C--
