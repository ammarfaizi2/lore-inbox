Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317968AbSGLB0W>; Thu, 11 Jul 2002 21:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317967AbSGLB0V>; Thu, 11 Jul 2002 21:26:21 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:11706 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S317968AbSGLB0T>; Thu, 11 Jul 2002 21:26:19 -0400
Date: Thu, 11 Jul 2002 21:27:53 -0400
To: andrea@suse.de
Cc: jamagallon@able.es, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: pipe and af/unix latency differences between aa and jam on smp
Message-ID: <20020712012753.GA6570@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19-pre10-jam2 is composed by plain 2.4.19pre10aa2 + a number
> of patches

Yes, that makes narrowing it down to a single patch straight forward.

> BTW, in your new set of benchmarks rc1aa1 still seems to be compiled in
> the unfair why that explains the slower I/O results, right? 

Yes.  2.4.19rc1aa1 did not have CONFIG_2GB or CONFIG_HIGHIO set, so
that was unfair.  2.4.19-pre10-jam[23] had 2GB and HIGHIO.  
2.4.19rc1aa2 is benching with 2GB and HIGHIO now.

> I don't have time to do benchmarks on this myself right now, but if
> somebody could try to apply the patches in jam2 with a binary search
> (I'd first suggest to backout irqrate, smptimers and irqbalance and see
> if it's still fast as I expect), that would be really interesting.

Thanks for picking out the most suspect patches.  In going through 
the patchlogs on the 4 different jam samples, I see:

irqrate and smptimers are in pre7jam6 (high latency) and pre8jam2
(low latency), so they may not be the key patch for pipe/unix 
latency.

irqbalance is in pre8jam2 and pre10jam2, which both had low latency.
irqbalance is not in pre7jam6 and pre10jam3 which had higher latency.

After 2.4.19rc1aa2 completes, I'll run the latency tests on pre10-jam2 
and back out patches until the difference appears.  Can't take but a
few pleasant hours, and the weekend is coming.  :)

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

