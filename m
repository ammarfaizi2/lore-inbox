Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTFIHaZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 03:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbTFIHaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 03:30:25 -0400
Received: from ds20-1.cc.swin.edu.au ([136.186.1.150]:11536 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S264292AbTFIHaY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 03:30:24 -0400
From: Tim Connors <tconnors@astro.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4 laptop mode
In-Reply-To: <20030514094011$5169@gated-at.bofh.it>
References: <20030514094011$5169@gated-at.bofh.it>
X-Face: m+g#A-,3D0}Ygy5KUD`Hckr=I9Au;w${NzE;Iz!6bOPqeX^]}KGt=l~r!8X|W~qv'`Ph4dZczj*obWD25|2+/a5.$#s23k"0$ekRhi,{cP,CUk=}qJ/I1acc
Message-ID: <slrn-0.9.7.4-13898-11183-200306091735-j.$random.luser@swin.edu.au>
Date: Mon, 9 Jun 2003 17:44:00 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> Now, this isn't the prettiest patch in the world. But it does allow me
> to get good spin down times on my laptop hard drive. It was somewhat
> inspired by the 2.5.early version akpm did. Basically, it adds:

OK - this is a much nicer thing than noflushd (which, for a lot of
people, manages to cause anything using pthreads to not reap zombies
anymore). There is still one deficiency (well, two) though:

One is that it assumes you only have one drive (I was to use this on
my desktop as well, which doesn't have me infront of it for 16 hours a
day). So when one drive spins up and the writes are performed, the
other drive needs to spin up at the same time (one of my drives is
basically /boot and /dos, so never gets accessed once booted). Is
there a way of doing the write deffering on a per-partition basis,
instead of all at once?


Second, given that at least one of my drives (even on my laptop, which
stays powered up 24/7) is not accessed for 16 hours at a time, I
increase the bdflush max params to 86400*HZ - is this safe? Is there a
reason why this is limited to 10000*HZ by default? Yeah, I know - I do
a manual sync when I need something to be safely stored on disk.


Thanks for the good work.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

I haven't lost my mind -- it's backed up on tape somewhere.
