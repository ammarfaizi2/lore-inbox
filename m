Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287173AbSABXOo>; Wed, 2 Jan 2002 18:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287967AbSABXOg>; Wed, 2 Jan 2002 18:14:36 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:64721 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S287173AbSABXOX>; Wed, 2 Jan 2002 18:14:23 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.17 vs 2.2.19 vs rml new VM
Date: Thu, 3 Jan 2002 00:14:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Robert Love <rml@tech9.net>, J Sloan <jjs@lexus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020102231431Z287173-13997+212@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2. January 2002 20:50, Alan cox wrote:
> > I find the low latency patch makes a noticeable
> > difference in e.g. q3a and rtcw - OTOH I have
> > not been able to discern any tangible difference
> > from the stock kernel when using -preempt.
>
> The measurements I've seen put lowlatency ahead of pre-empt in quality
> of results. Since low latency fixes some of the locked latencies it might
> be interesting for someone with time to benchmark
>
>        vanilla
>        low latency
>        pre-empt
>        both together

Don't forget that you have to use preempt-kernel-rml + lock-break-rml to 
achieve the same (more) than the latency patch.

Taken from Robert's page and running it for some weeks, now.

[-]
Lock breaking for the Preemptible Kernel
lock-break-rml-2.4.15-1
lock-break-rml-2.4.16-3
lock-break-rml-2.4.17-2
lock-break-rml-2.4.18-pre1-1
README
ChangeLog
With the preemptible kernel, the need for explicit scheduling points, like in 
the low-latency patches, are no more. However, since we can not preempt while 
locks are held, we can take a similar model as low-latency and "break" (drop 
and immediately reacquire) locks to improve system response. The trick is 
finding when and where we can safely break the locks (periods of quiescence) 
and how to safely recover. The majority of the lock breaking is in the VM and 
VFS code. This patch is for users with strong system response requirements 
affected by the worst-case latencies caused by long-held locks.
[-]

Regards,
	Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
@home: Dieter.Nuetzel@hamburg.de
