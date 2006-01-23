Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932468AbWAWUVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbWAWUVO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWAWUVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:21:14 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:6531 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932468AbWAWUVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:21:14 -0500
Date: Mon, 23 Jan 2006 21:21:58 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [ANNOUNCE][RFC] PlugSched-6.2 for  2.6.16-rc1 and
 2.6.16-rc1-mm1
Message-ID: <20060123212158.3fba71d5@localhost>
In-Reply-To: <43D4281D.10009@bigpond.net.au>
References: <43D00887.6010409@bigpond.net.au>
	<20060121114616.4a906b4f@localhost>
	<43D2BE83.1020200@bigpond.net.au>
	<43D40B96.3060705@bigpond.net.au>
	<43D4281D.10009@bigpond.net.au>
X-Mailer: Sylpheed-Claws 2.0.0-rc3 (GTK+ 2.8.8; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006 11:49:33 +1100
Peter Williams <pwil3058@bigpond.net.au> wrote:

> > 
> > However, in spite of the above, the fairness mechanism should have been 
> > able to generate enough bonus points to get dd's priority back to less 
> > than 34.  I'm still investigating why this didn't happen.
> 
> Problem solved.  It was a scaling issue during the calculation of 
> expected delay.  The attached patch should fix both the CPU hog problem 
> and the fairness problem.  Could you give it a try?
> 

Mmmm... it doesn't work:

 PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5516 paolo     34   0  115m  18m 2432 S 87.5  3.7   0:23.72 transcode
 5530 paolo     34   0 51000 4472 1872 S  8.0  0.9   0:02.29 tcdecode
 5523 paolo     34   0 19840 1088  880 R  2.0  0.2   0:00.21 tcdemux
 5522 paolo     34   0 22156 1204  972 R  0.7  0.2   0:00.02 tccat
 5539 paolo     34   0  4952 1468  372 D  0.7  0.3   0:00.04 dd
 5350 root      28   0  167m  16m 3228 S  0.3  3.4   0:03.64 X

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 5456 paolo     34   0  115m  18m 2432 D 63.9  3.7   0:48.21 transcode
 5470 paolo     37   0 50996 4472 1872 R  6.2  0.9   0:05.20 tcdecode
 5493 paolo     34   0  4952 1472  372 R  1.5  0.3   0:00.22 dd
 5441 paolo     28   0 86656  21m  15m S  0.2  4.4   0:00.77 konsole
 5468 paolo     34   0 19840 1088  880 S  0.2  0.2   0:00.23 tcdemux

-- 
	Paolo Ornati
	Linux 2.6.16-rc1-plugsched on x86_64
