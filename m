Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbTJMIgA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJMIgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:36:00 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:41478 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S261567AbTJMIf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:35:58 -0400
Message-ID: <3F8A661B.80909@aitel.hist.no>
Date: Mon, 13 Oct 2003 10:45:15 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Joel Becker <Joel.Becker@oracle.com>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: statfs() / statvfs() syscall ballsup...
References: <Pine.LNX.4.44.0310120909050.12190-100000@home.osdl.org> <878ynq3y7n.fsf@stark.dyndns.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
[...]
> 
> But then vacuum comes along and tries to read the entire table sequentially.
> In the best case the sequential read will take up a lot of the available disk
> bandwidth and delay transactions. In the worst case the OS will actually
> prefer the sequential read because the elevator algorithm always sees that it
> can get more bandwidth by handling it ahead of the random access.
> 
> In reality there is no time pressure on the vacuum at all. As long as it
> completes faster than dead records can pile up it's fast enough. The
> transactions on the other hand must complete as fast as possible.

This seems almost trivial.  If the vacuum job runs too much,
overusing disk bandwith - throttle it!
This is easier than trying to tell the kernel that the job is
less important, that goes wrong wether the job runs too much
or too little.  Let that job  sleep a little when its services
aren't needed, or when you need the disk bandwith elsewhere.


Helge Hafting



