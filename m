Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVECPj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVECPj0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 11:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVECPj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 11:39:26 -0400
Received: from fire.osdl.org ([65.172.181.4]:55192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVECPim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 11:38:42 -0400
Date: Tue, 3 May 2005 08:38:22 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] PAL-M support fix for CX88 chipsets
Message-Id: <20050503083822.68a116d4.rddunlap@osdl.org>
In-Reply-To: <42777318.2070508@brturbo.com.br>
References: <42777318.2070508@brturbo.com.br>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: SvC&!/v_Hr`MvpQ*|}uez16KH[#EmO2Tn~(r-y+&Jb}?Zhn}c:Eee&zq`cMb_[5`tT(22ms
 (.P84,bq_GBdk@Kgplnrbj;Y`9IF`Q4;Iys|#3\?*[:ixU(UR.7qJT665DxUP%K}kC0j5,UI+"y-Sw
 mn?l6JGvyI^f~2sSJ8vd7s[/CDY]apD`a;s1Wf)K[,.|-yOLmBl0<axLBACB5o^ZAs#&m?e""k/2vP
 E#eG?=1oJ6}suhI%5o#svQ(LvGa=r
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 May 2005 09:48:24 -0300 Mauro Carvalho Chehab wrote:

|     This patch fixes PAL-M chroma subcarrier frequency (FSC) to its 
| correct value of 3.5756115 MHz and adjusts horizontal total samples for 
| PAL-M, according with formula Line Draw Time / (4*FSC), where Line Draw 
| Time is 63.555 us.
|      Without this patch, the Notch subcarrier filter was trying to 
| capture using NTSC-M frequency, which is very close, but not equal. This 
| could result in Black and White or miscolored frames.

This patch does not apply cleanly:
patching file cx88-core.c
Hunk #1 FAILED at 736.
Hunk #2 FAILED at 752.
2 out of 2 hunks FAILED -- saving rejects to file cx88-core.c.rej

due to tabs being converted to spaces.
Please mail it to yourself and then try to apply the patch
to see if that works.  You may have to use a different
mail client/app.  Hm, thunderbird.  Did you copy/paste the
patch?  That usually doesn't work.

Oh, and kernel comment style is /* ... */, not //.

| -----
| 
| diff -puNr linux-2.6.12-rc3.org/drivers/media/video/cx88/cx88-core.c 
| linux-2.6.12-rc3/drivers/media/video/cx88/cx88-core.c
| --- linux-2.6.12-rc3.org/drivers/media/video/cx88/cx88-core.c   
| 2005-04-20 21:03:14.000000000 -0300
| +++ linux-2.6.12-rc3/drivers/media/video/cx88/cx88-core.c       
| 2005-05-03 09:23:21.000000000 -0300
| @@ -736,6 +736,9 @@ static unsigned int inline norm_fsc8(str
|  {
|         static const unsigned int ntsc = 28636360;
|         static const unsigned int pal  = 35468950;
| +        static const unsigned int palm  = 28604892;
| +
| +       if (V4L2_STD_PAL_M  & norm->id) return palm;
| 
|         return (norm->id & V4L2_STD_625_50) ? pal : ntsc;
|  }
| @@ -749,6 +752,8 @@ static unsigned int inline norm_notchfil
| 
|  static unsigned int inline norm_htotal(struct cx88_tvnorm *norm)
|  {
| +       // Should allways be Line Draw Time / 4FSC
| +       if (V4L2_STD_PAL_M  & norm->id) return 909;
|         return (norm->id & V4L2_STD_625_50) ? 1135 : 910;
|  }


---
~Randy
