Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264543AbUESVU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbUESVU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 17:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUESVU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 17:20:27 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:2987 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S264543AbUESVUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 17:20:23 -0400
Subject: Non-regression for current kernel (was Re: 1352 NUL bytes at the
	end of a page?)
From: Steven Cole <elenstev@mesatop.com>
To: Chris Mason <mason@suse.com>
Cc: hugh@veritas.com, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       Andrea Arcangeli <andrea@suse.de>, lm@bitmover.com
In-Reply-To: <1084975701.27142.25.camel@watt.suse.com>
References: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
	 <200405190453.31844.elenstev@mesatop.com>
	 <1084968622.27142.5.camel@watt.suse.com>
	 <20040519.072009.92566322.wscott@bitmover.com>
	 <40AB5639.7060806@yahoo.com.au>
	 <70C69E3C-A998-11D8-A7EA-000A95CC3A8A@lanl.gov>
	 <1084973802.27142.14.camel@watt.suse.com>
	 <BEA1FF76-A99C-11D8-A7EA-000A95CC3A8A@lanl.gov>
	 <1084975701.27142.25.camel@watt.suse.com>
Content-Type: text/plain
Message-Id: <1085001110.2469.21.camel@spc0.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Wed, 19 May 2004 15:11:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 08:08, Chris Mason wrote:
> On Wed, 2004-05-19 at 09:59, Steven Cole wrote:
> 
> > I went back through the archive to make sure, and since I didn't
> > specify where I did the timed tests, those timing tests would have
> > been done on my /home partition, which is reiserfs v3.
> > 
> > Since I was using different partitions for ext3 and reiserfs on
> > /dev/hda, a direct comparison between ext3 and reiserfs wouldn't
> > be completely fair, but a "watching the paint dry" observation
> > seemed to indicate that reiserfs was significantly faster for this
> > load.  I did press my backup disk into service for this testing,
> > to eliminate the possibility that this was due to a finicky disk,
> > and I have a 3.9 G partition which I've formatted first reiserfs,
> > then ext3, so I could do some fair tests between reiserfs and
> > ext3 on that disk.  But I think the results are already known;
> > reiserfs opens a can of whoopass for this kind of load.
> 
> While this is the kind of thing I like to hear, it wasn't really what I
> was asking ;-)
> 
> There was a regression between a 2.6.3 mandrake kernel and 2.6.6, was
> this regression just for reiserfs or was it for all filesystems?
> 
> If just reiserfs, it might be from the data=ordered and logging changes
> that went into 2.6.6, so I'm quite interested in figuring things out.
> 
> -chris

Trimmed the Bitmover folks off the cc-list (except Larry, who likes lots
of email).

Although my home machine seemed to show a regression, here are some data
for a dual P-III with 512M memory and SCSI. 

I mounted reiserfs and ext3 with default mount options. 

I ran the clone test described earlier in the thread with a kernel
updated this morning (with Chris' patch now in mainline), and with
the smp version of the vendor kernel. I also booted with mem=384M
to compare with my home machine.

It appears that the current kernel is an improvement over the older
kernel in all cases here (as we would hope) and that whatever advantage
reiserfs has over ext3 for this load becomes more evident with less
memory, keeping in mind that a side-by-side comparison between file
systems is not completely fair here since they are on different sections
of the disk for this test.

Each test was run three times.

--------------------------------------------
clone test with 512M memory

2.6.6-current	ext3
182.80user 33.79system 6:13.94elapsed 57%CPU
182.62user 32.81system 5:49.54elapsed 61%CPU
182.62user 33.39system 6:16.81elapsed 57%CPU

2.6.3-4mdksmp 	ext3
182.14user 34.54system 6:59.80elapsed 51%CPU
181.71user 33.84system 6:50.24elapsed 52%CPU
181.07user 33.41system 6:12.49elapsed 57%CPU

2.6.6-current 	reiserfs v3
183.56user 39.71system 5:44.29elapsed 64%CPU
184.77user 39.82system 6:05.46elapsed 61%CPU
184.03user 40.23system 6:09.58elapsed 60%CPU

2.6.3-4mdksmp	reiserfs v3
182.41user 42.88system 6:21.06elapsed 59%CPU
183.27user 42.33system 6:28.36elapsed 58%CPU
183.14user 42.46system 6:38.14elapsed 56%CPU

--------------------------------------------
clone test with mem=384M

2.6.6-current	ext3
185.05user 35.73system 8:04.19elapsed 45%CPU
184.57user 35.46system 8:07.65elapsed 45%CPU
185.26user 35.63system 8:06.02elapsed 45%CPU

2.6.3-4mdksmp 	ext3
182.88user 36.79system 8:42.71elapsed 42%CPU
182.54user 35.75system 8:35.02elapsed 42%CPU
182.71user 36.06system 8:31.13elapsed 42%CPU

2.6.6-current 	reiserfs v3
183.98user 41.49system 7:02.16elapsed 53%CPU
184.06user 40.83system 6:56.63elapsed 53%CPU
183.21user 41.58system 7:02.28elapsed 53%CPU

2.6.3-4mdksmp	reiserfs v3
182.50user 44.62system 7:51.71elapsed 48%CPU
183.44user 43.96system 7:51.26elapsed 48%CPU
182.79user 43.91system 7:52.30elapsed 47%CPU

Steven

