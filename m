Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272443AbTGZAFP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 20:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272444AbTGZAFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 20:05:15 -0400
Received: from evrtwa1-ar2-4-33-045-074.evrtwa1.dsl-verizon.net ([4.33.45.74]:35546
	"EHLO grok.yi.org") by vger.kernel.org with ESMTP id S272443AbTGZAFJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 20:05:09 -0400
Message-ID: <3F21C93D.6000005@candelatech.com>
Date: Fri, 25 Jul 2003 17:20:13 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marco Roeland <marco.roeland@xs4all.nl>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Eli Barzilay <eli@barzilay.org>
Subject: Re: Repost: Bug with select?
References: <16112.10166.989608.288954@mojave.cs.cornell.edu> <16159.28266.868297.372200@mojave.cs.cornell.edu> <20030725134155.GA19211@localhost>
In-Reply-To: <20030725134155.GA19211@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Roeland wrote:
> On Thursday July 24th 2003 at 01:28 uur Eli Barzilay wrote:
> 
> 
>>When I run the following program, and block the terminal's output
>>(C-s), the `select' doesn't seem to have any effect, resulting in a
>>100% cpu usage (this is on a RH8, with 2.4.18).  I wouldn't be
>>surprised if I'm doing something stupid, but it does seem to work fine
>>on Solaris.
>>
>>Is there anything wrong with this, or is this some bug?
>>
>>======================================================================
>>#include <unistd.h>
>>#include <fcntl.h>
>>int main() {
>>  int flags, fd, len; fd_set writefds;
>>  fd = 1;
>>  flags = fcntl(fd, F_GETFL, 0);
>>  fcntl(fd, F_SETFL, flags | O_NONBLOCK);
> 
> 
> You use non-blocking mode here.
> 
> 
>>  while (1) {
>>    FD_ZERO(&writefds);
>>    FD_SET(fd, &writefds);
>>    len = select(fd + 1, NULL, &writefds, NULL, NULL);
> 
> 
> A select with no timeout, so it will immediately return.
> 
> 
>>    if (!FD_ISSET(fd,&writefds)) exit(0);
> 
> 
> This might be what Solaris does differently, by _not_ including '1' in
> the returned descriptors? Linux will say (rightly) that a following call
> will not block, which is something very different than 'will not fail'!

I thought select is supposed to tell you when you can read/write at least something without
failing.  Otherwise it would be worthless when doing non-blocking IO because you can
both read and write w/out blocking at all times.  If you run similar code on a tcp
socket instead of std-out, do you see the same busy spin?  (To do it right, make
sure the network between source and destination is slower than the CPU can handle,
ie 10bt hub.)


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


