Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbULAK1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbULAK1j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 05:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbULAK1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 05:27:39 -0500
Received: from canuck.infradead.org ([205.233.218.70]:12046 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261349AbULAK13 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 05:27:29 -0500
Subject: Re: Kernel 2.6 with X (xorg) 4.4 (eats more CPU power)
From: Arjan van de Ven <arjan@infradead.org>
To: Joe Hsu <joe@softwell.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1101896505.2161.45.camel@joe>
References: <1101896505.2161.45.camel@joe>
Content-Type: text/plain
Message-Id: <1101896842.2640.22.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 01 Dec 2004 11:27:23 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 18:21 +0800, Joe Hsu wrote:
> Dear All:
>     I've tried libXv to open an Video Overlay port and
> XvShmPutImage for 60 frames per second. Each frame is
> at a size of 800x600 using format YUYV (YUV2). Before
> each XvShmPutImage, I copy 800x600x2 bytes of non-constant 
> data to XvImage->data. (No user interactive UI)
> 
>     And I found something interisting happened. In pentium 4
> 3.0G machine and linux kernel 2.6, X and my program total 
> consumes 5% of cpu resource.
> 
>     But in pentium 4 2.xG or below, it would consume 10% or 
> more of CPU resource. (If you try this with XFree86 4.2 and 
> pentium 1.xG machine, it would consume 30% or more of cpu 
> resource at a peak.)
> 
>     In contrast, I've tried Kernel 2.4 with same X, same 
> program, and same machine. It consumes almost zero of CPU 
> resource( no matter it runs on a P4 1.xG or P4 3.0G and no
> matter it runs on 4.4 or 4.2 X-server).


reported resource usage is an estimate based on sampling. With HZ=1000 you do get a more accurate
sampling of reality.....

In addition, do check if your code (or X) doesn't do timeouts of < 10 msec; in HZ=100 kernels those always 
delay 10 or 20 msec, while with HZ=1000 kernels the delay becomes far more accurate.

