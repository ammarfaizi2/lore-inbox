Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUDSNi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264421AbUDSNhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:37:35 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:60169 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264433AbUDSNb4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:31:56 -0400
Message-ID: <4083D511.6040702@aitel.hist.no>
Date: Mon, 19 Apr 2004 15:33:05 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Antti Lankila <alankila@elma.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: elevator=as, or actually gpm doesn't get time from scheduler???
References: <Pine.A41.4.58.0404191609060.42820@tokka.elma.fi>
In-Reply-To: <Pine.A41.4.58.0404191609060.42820@tokka.elma.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antti Lankila wrote:
> In response to Nick Piggin's:
> 
> 
>>The only other problems I can think of that you might be
>>having are chipset problems, or CPU scheduler problems.
>>Which reminds me, do you have your X server at nice 0?
> 
> 
> X has been reniced to zero. But hey! I was doing "cat /dev/psaux" when mouse
> stopped moving in X, and I _did_ see data coming from /dev/psaux! So this is
> a major update to my understanding of the problem.
> 
> But make no mistake, I have been doing this cat /dev/psaux test earlier and
> at that time I did _not_ see chars coming out of psaux when the mouse
> stopped. That is why I thought I had established that the problem is in the
> kernel. I must retest this on the other machines involved when I get to
> their consoles next week. I can not explain why this time psaux appears to
> work regardless of the userland mouse stall, so for now I must assume some
> other factor confused the cat /dev/psaux test at that time.
> 
> My X reads gpmdata, so perhaps that's the problem? I now undercut gpm in
> order to examine the situation, and my system behaves _perfectly_ as far as
> I can see. The mouse issues are all gone. (gpm is still running in the
> background, X just reads psaux directly. As I have understood, this is
> possible in 2.6 while in 2.4 it caused a problem for multiple readers.)
> 

Gpm might be a problem in high-load situations, for two reasons:

1. gpm is another process.  The mouse moves, it takes some time before gpm
   gets to read it because the cpu is busy.  Then it pass stuff onto the
   fifo that X reads from, but now X waits for a while because so much is going on.
2. You may play with the priority of x in order to get better response, but
   this does not affect the priority of gpm.

With X reading psaux directly, you avoid some waiting.  And X may get a priority
boost for waiting for the mouse to move. With gpm this bonus goes to gpm which
may have a lot less to do with it.

Helge Hafting

