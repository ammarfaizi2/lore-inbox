Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271312AbTGWUrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 16:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271313AbTGWUrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 16:47:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:27049 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S271312AbTGWUrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 16:47:13 -0400
Message-ID: <3F1EF7DB.2010805@namesys.com>
Date: Thu, 24 Jul 2003 01:02:19 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       reiserfs mailing list <reiserfs-list@namesys.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Reiser4 status: benchmarked vs. V3 (and ext3)
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please look at http://www.namesys.com/benchmarks/v4marks.html

In brief, V4 is way faster than V3, and the wandering logs are indeed 
twice as fast as fixed location logs when performing writes in large 
batches.

We are able to perform all filesystem operations fully atomically, while 
getting dramatic performance improvements.  (Other attempts at 
introducing transactions into filesystems are said to have failed for 
performance reasons.)

Balancing at flush time works well, not using blobs works well, 
allocating at flush time works well.  CPU time is good enough to get by, 
and it will improve over the next few months as we tweak a lot of little 
details, but the IO performance is what matters, and this performance is 
quite good enough to use.  In all the places where V3 sacrifices 
performance to save disk space, V4 saves more disk space and gains 
rather than loses performance. 

The plugin infrastructure works well, expect lots of plugins over the 
next year or two.

Look for a repacker to come out in a few weeks that will make these 
numbers especially good for filesystems that have 80% of their files 
unmoving for long periods of time (which is to say most systems), and 
might otherwise suffer from fragmentation.

These benchmarks mean to me that our performance is now good enough to 
ship V4 to users (which means we need persons willing to try to crash it 
so that the stability can become good enough to ship to users).  
Sometime during the next week or two we will probably send a patch in, 
and ask for inclusion.  We need to run another round of stress tests 
after our latest tweaks, and kill off two bugs that got added just 
recently, and then we will ask for testers. 

I will be going to Budapest to discuss filesystem semantics with Peter 
Foldiak for a week, so V4 may get sent in for inclusion by members of my 
team while I am absent.  If so, please include it in 2.5/2.6.

-- 
Hans


