Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268565AbUIXIQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268565AbUIXIQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268553AbUIXIQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:16:00 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:41417 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S268565AbUIXIPh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:15:37 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: lost memory on a 4GB amd64
Date: Fri, 24 Sep 2004 09:15:34 +0100
User-Agent: KMail/1.7
Cc: Sergei Haller <Sergei.Haller@math.uni-giessen.de>
References: <Pine.LNX.4.58.0409161445110.1290@magvis2.maths.usyd.edu.au> <Pine.LNX.4.58.0409200815420.3644@fb07-calculator.math.uni-giessen.de> <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
In-Reply-To: <Pine.LNX.4.58.0409202020370.5797@magvis2.maths.usyd.edu.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409240915.34471.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 Sep 2004 11:26, Sergei Haller wrote:
>
> fang ~sergei> ./memtest 1000000000
> allocate 1000000000: ok
>
> Message from syslogd@fang at Mon Sep 20 18:03:16 2004 ...
> fang kernel: Oops: 0000 [1] PREEMPT SMP
>

Works fine on my 4Gb Tyan thunder K8W machine, even running from an xterm:
andrew@orac ~ $ uname -a
Linux orac.walrond.org 2.6.8.1 #3 SMP Sun Aug 29 17:36:49 BST 2004 x86_64 
unknown unknown GNU/Linux

andrew@orac ~ $ free -m
             total       used       free     shared    buffers     cached
Mem:          4008        263       3744          0          0         66
-/+ buffers/cache:        195       3812
Swap:         3827         25       3802

andrew@orac ~ $ ./memtest 1000000000
allocate 1000000000: ok
set them to 0... done
andrew@orac ~ $ ./memtest 4000000000
allocate 4000000000: ok
set them to 0... done
andrew@orac ~ $ ./memtest 5000000000
allocate 5000000000: ok
set them to 0... done
andrew@orac ~ $

The last one took a while (using 1Gb swap) but it still worked fine.

Without swap:

andrew@orac ~ $ sudo swapoff -a
andrew@orac ~ $ free -m
             total       used       free     shared    buffers     cached
Mem:          4008        237       3770          0          1         54
-/+ buffers/cache:        181       3826
Swap:            0          0          0
andrew@orac ~ $ ./memtest 1000000000
allocate 1000000000: ok
set them to 0... done
andrew@orac ~ $ ./memtest 2000000000
allocate 2000000000: ok
set them to 0... done
andrew@orac ~ $                          

Still fine.

Andrew Walrond
