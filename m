Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWITXhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWITXhf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 19:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWITXhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 19:37:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65428 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750699AbWITXhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 19:37:34 -0400
Date: Wed, 20 Sep 2006 16:37:22 -0700
From: Paul Jackson <pj@sgi.com>
To: "Paul Menage" <menage@google.com>
Cc: alan@lxorguk.ukuu.org.uk, clameter@sgi.com, npiggin@suse.de,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, devel@openvz.org
Subject: Re: [ckrm-tech] [patch00/05]: Containers(V2)- Introduction
Message-Id: <20060920163722.1442c5c1.pj@sgi.com>
In-Reply-To: <6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	<Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	<1158773699.7705.19.camel@localhost.localdomain>
	<6599ad830609201030w38b6ae59ia0d4a4ccabb47054@mail.google.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul M., responding to Alan:
> > I'm also not clear how you handle shared pages correctly under the fake
> > node system, can you perhaps explain that further how this works for say
> > a single apache/php/glibc shared page set across 5000 containers each a
> > web site.
> 
> If you can associate files with containers, you can have a "shared
> libraries" container that the libraries/binaries for apache/php/glibc
> are associated with - all pages from those files are then accounted to
> the shared container. 

The way you "associate" a file with a cpuset is to have some task in
that cpuset open that file and touch its pages -- where that task does
so before any other would be user of the file.  Then so long as those
pages have any users or aren't reclaimed, they stay in memory or swap,
free for anyone to reference (free so far as cpusets cares, which is
not in the slightest.)

Such pre-touching of files is common occurrence on the HPC (High Perf
Comp.) apps that run on the big honkin NUMA iron where cpusets were
born.  I'm guessing that someone hosting 5000 web servers would rather
not deal with that particular hastle.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
