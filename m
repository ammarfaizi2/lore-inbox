Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUJJFOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUJJFOh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 01:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUJJFOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 01:14:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:36329 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268126AbUJJFOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 01:14:35 -0400
Date: Sat, 9 Oct 2004 22:12:06 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041009221206.45e957b6.pj@sgi.com>
In-Reply-To: <1250810000.1097160595@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That makes no sense to me whatsoever, I'm afraid. Why if they were allowed
> "to steal a few cycles" are they so fervently banned from being in there?

One substantial advantage of cpusets (as in the kernel patch in *-mm's
tree), over variations that "just poke the affinity masks from user
space" is the task->cpuset pointer.  This tracks to what cpuset a task
is attached.  The fork and exit code duplicates and nukes this pointer,
managing the cpuset reference counter.

It matters to batch schedulers and the like which cpuset a task is in,
and which tasks are in a cpuset, when it comes time to do things like
suspend or migrate the tasks currently in a cpuset.

Just because it's ok to share a little compute time in a cpuset doesn't
mean you don't care to know who is in it.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
