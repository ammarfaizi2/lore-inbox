Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTF0H6W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 03:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTF0H6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 03:58:22 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7690 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262254AbTF0H6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 03:58:21 -0400
Message-ID: <3EFBFDD1.4000603@aitel.hist.no>
Date: Fri, 27 Jun 2003 10:18:25 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Bill Davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
References: <3EFAC408.4020106@aitel.hist.no> <5.2.0.9.2.20030627071904.00c890e0@pop.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

> The thought of building/passing "connection" information around in the 
> scheduler gives me a bad case of the willies.  I can imagine a process 
> struct containing a list of components and their cpu usage information 
> as a means to defeat fairness/starvation issues, but I can't imagine how 
> to do that and retain high speed low drag O(1) scheduling.
> 
The idea isn't that complicated.  When a process wakes up, make
a simple check to see what it woke up from.  Ordinary
io is handled as today, with a io boost.

A pipe wakeup can be handled by taking a look at the other end.
If the other process has interactivity bonus, grab half of
it.  (And halve the bonus belonging to that process.)
No bonus is created in this case, so no risk of DOS.
It is merely redistributed.

And it is simple - there is one thing that woke the
process up - so only one thing to check.

Hard corner cases can be avoided.  Perhaps bunch of pipes,
files, devices, sockets and page-ins becomes ready
simultaneosly.  A detailed priority calculation is clearly
pointless, so just use one of the things - or none.

> Until someone demonstrates that the DoS/abuse scenarios I might be 
> imagining are real, in C, I think I'll do the smart thing: try to stop 
> worrying about it and stick to very very simple stuff.

I thought the Irman thing was what killed the previous attempt
at redistributing priorities?

Helge Hafting

