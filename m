Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271456AbUJVQcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271456AbUJVQcx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271457AbUJVQcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:32:53 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:38119 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S271456AbUJVQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:32:47 -0400
Message-ID: <41793628.30208@nortelnetworks.com>
Date: Fri, 22 Oct 2004 10:32:40 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       Kasper Sandberg <lkml@metanurb.dk>,
       =?ISO-8859-1?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost> <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com> <200410221215.32597.gene.heskett@verizon.net>
In-Reply-To: <200410221215.32597.gene.heskett@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

> Stable, yes.  But only after about 3 or 4 iterations.  The first 3 
> rather handily used 500+ megs of memory that I did not get back when 
> I stopped it and cleaned up the mess.

Did you run a memory hog to put memory pressure on the system?

The following is with 2.6.9-rc4

-bash-2.05b$ while true ; do tar -xjf linux-2.6.7.tar.bz2 ; rm -rf linux-2.6.7 ; 
vmstat ; done
procs                      memory      swap          io     system         cpu
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  1  0      0 1675768 104004 112576    0    0     0     1   11     2  0  0  0 10
procs                      memory      swap          io     system         cpu
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  1  1      0 1649032 110792 112724    0    0     0     1   11     3  0  0  0 10
procs                      memory      swap          io     system         cpu
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  1  0      0 1630472 118580 112620    0    0     0     2   11     3  0  0  0 10
procs                      memory      swap          io     system         cpu
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  1  0      0 1607560 125500 112636    0    0     0     2   11     3  0  0  0 10


After running a memory hog,

-bash-2.05b$ vmstat
procs                      memory      swap          io     system         cpu
  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
  0  0      0 1890248    672   4836    0    0     0     3   11     3  0  0  0 10


Looks like the cached memory all got freed, which is exactly as expected.

Chris
