Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbRERSEL>; Fri, 18 May 2001 14:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261314AbRERSEB>; Fri, 18 May 2001 14:04:01 -0400
Received: from lsmls01.we.mediaone.net ([24.130.1.20]:56534 "EHLO
	lsmls01.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S261312AbRERSDx>; Fri, 18 May 2001 14:03:53 -0400
Message-ID: <3B0564FD.217CB3A9@kegel.com>
Date: Fri, 18 May 2001 11:07:57 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: sape@iq.rulez.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux scalability?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sasi Peter <sape@iq.rulez.org> wrote:
> I am just writing an essay, an have mentioned TUX as a performance and 
> scalability linearity recort holder with TUX, referencing the specweb99 
> website summary page: 
> 
> http://www.spec.org/osg/web99/results/web99.html 
> 
> However, taking a closer look, it turns out, that the above statement 
> holds true only for 1 and 2 processor machines. Scalability already 
> suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten 
> by IIS 5.0 (8001), and these were measured on the same kind of box! 
>
> How come, TUX is soooo good at the lowend (1 and 2 CPUs), and scales this 
> bad? 

Let's look at the scores.  (BTW, SPECweb99 gets harder
as the scores get better; the document tree required to achieve a score of
3222 is twice as large as that required to achieve a score of 1438.)

  SPECweb99 result summary:
date    #cpu  #nics L2 cache/cpu  RAM  tree score  sw   model                MHz
1/2001  1     1     256K          2G    5G  1438   tux2 Compq Proliant DL320 800
6/2000  1     1     256K          2G    4G  1270   tux1 Dell Poweredge 6400  667
6/2000  2     2     256K          4G    7G  2200   tux1 Dell Poweredge 4400  800
3/2001  2     4     256K          4G    10G 3222   tux2 Dell Poweredge 2500  1000

2/2001  1     3     2M            8G    9G  2700   tux2 IBM xSeries 370      900
2/2001  2     4     2M            16G   13G 3999   tux2 IBM xSeries 370      900
6/2000  4     4     2M            8G    14G 4200   tux1 Dell Poweredge 6400  700
7/2000  8     8     2M            32G   21G 6387   tux1 Dell Poweredge 8450  700
11/2000 8     8     2M            32G   24G 7500   tux2 Dell Poweredge 8450  700
12/2000 8     8     2M            32G   21G 6407   tux1 IBM Netfinity 8500R  700

3/2001  2     3     256K          4G    8G  2499   IIS5/SWC HP NetserverLP2000r  1000
4/2001  8     8     2M            32G   26G 8000   IIS5/SWC Dell Poweredge 8450  700

IIS5/SWC only has two results on record, at 2 and 8 CPUs.  They're hard
to compare, because they have different cache and RAM sizes and CPU speeds,
but it's safe to say that it performs poorly at 2 CPUs (compared to the 3/2001 
results from Dell) and scales nearly linearly to perform comparatively well at 8 CPUs.

Looking at the IBM 1 and 2 CPU results, twice the CPU only got 1.4 times
the performance.  Not sure TUX is scaling especially well even at 2 CPU's.
(And you can't blame this on disk drives, please don't try.)

So I agree, Tux doesn't seem to scale as well to multiple CPUs as does IIS5/SWC.

About comparing the Tux and IIS/SWC results on the Dell 8 CPU box:
the Tux measurement is 5 months older than the IIS/SWC measurement.
It's interesting to speculate how tux2 would do if tested today; 
It looks like tux2 is about 12% faster than tux1 on 8-CPU machines.
In other words, 5 months of further development on tux and the 2.4 kernel yielded 
a 12% speedup.  Since IIS was only 4% faster than TUX, If Tux were measured today, 
it might have improved enough to beat IIS/SWC, who knows.

- Dan
