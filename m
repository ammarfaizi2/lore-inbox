Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbWCTHG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbWCTHG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 02:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932179AbWCTHG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 02:06:59 -0500
Received: from mail.gmx.de ([213.165.64.20]:47323 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932178AbWCTHG7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 02:06:59 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1142615721.7841.15.camel@homer>
References: <200603081013.44678.kernel@kolivas.org>
	 <20060307152636.1324a5b5.akpm@osdl.org>
	 <cone.1141774323.5234.18683.501@kolivas.org>
	 <200603090036.49915.kernel@kolivas.org>  <20060317090653.GC13387@elte.hu>
	 <1142592375.7895.43.camel@homer>  <1142615721.7841.15.camel@homer>
Content-Type: multipart/mixed; boundary="=-b/fk4e4/BIC6DKl3DglS"
Date: Mon, 20 Mar 2006 08:09:13 +0100
Message-Id: <1142838553.8441.13.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b/fk4e4/BIC6DKl3DglS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2006-03-17 at 18:15 +0100, Mike Galbraith wrote: 
> Problem solved.  I now know why the starvation logic doesn't work.
> Wakeups.  In the face of 10+ copies of httpd constantly waking up, it
> seems it just takes ages to get around to switching arrays.
> 
> With the (urp) patch below, I now get...
> 
> [root]:# time netstat|grep :81|wc -l
>    1648
> 
> real    0m27.735s
> user    0m0.158s
> sys     0m0.111s
> [root]:# time netstat|grep :81|wc -l
>    1817
> 
> real    0m13.550s
> user    0m0.121s
> sys     0m0.186s
> [root]:# time netstat|grep :81|wc -l
>    1641
> 
> real    0m17.022s
> user    0m0.132s
> sys     0m0.143s
> [root]:# 

For those interested in these kind of things, here are the numbers for
2.6.16-rc6-mm2 with my [tarball] throttle patches applied...

[root]:# time netstat|grep :81|wc -l
   1681

real    0m1.525s
user    0m0.141s
sys     0m0.136s
[root]:# time netstat|grep :81|wc -l
   1491

real    0m0.356s
user    0m0.130s
sys     0m0.114s
[root]:# time netstat|grep :81|wc -l
   1527

real    0m0.343s
user    0m0.129s
sys     0m0.114s
[root]:# time netstat|grep :81|wc -l
   1568

real    0m0.512s
user    0m0.112s
sys     0m0.138s

...while running with the same apache loadavg of over 10, and tunables
set to server mode (0,0).

<plug>
Even a desktop running with these settings is so interactive that I
could play a game of Maelstrom (asteroids like thing) while doing a make
-j30 in slow nfs mount and barely feel it.  In a local filesystem, I
could't feel it at all, so I added a thud 3, irman2 and a bonnie -s 2047
for good measure.  Try that with stock :)
</plug>

--=-b/fk4e4/BIC6DKl3DglS
Content-Disposition: attachment; filename=throttle-V22-2.6.16-rc6-mm2.tar.gz
Content-Type: application/x-compressed-tar; name=throttle-V22-2.6.16-rc6-mm2.tar.gz
Content-Transfer-Encoding: base64

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
WLFixYoVK1asWLHy/8kvf91gBAB4AAA=


--=-b/fk4e4/BIC6DKl3DglS--

