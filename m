Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTEISl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTEISl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:41:27 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:50090 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S263274AbTEISlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:41:25 -0400
Message-ID: <3EBC16FE.506@wanadoo.fr>
Date: Fri, 09 May 2003 21:00:46 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paubert <paubert@iram.es>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andi Kleen <ak@suse.de>, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] Mask mxcsr according to cpu features.
References: <20030509004200.A22795@mrt-lx16.iram.es> <3EBB4B60.4080905@wanadoo.fr> <20030509104843.A16311@mrt-lx16.iram.es> <3EBBD861.5070404@wanadoo.fr> <20030509165051.A31465@mrt-lx16.iram.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

paubert wrote:
> On Fri, May 09, 2003 at 04:33:37PM +0000, Philippe Elie wrote:

>>The only problem we can get is an old processor which write non
>>zero but random bits in the 16 upper bits.
> 
> 
> I don't believe that there is any, but that maybe some which don't
> write anything, hence the requirement for clearing the area in the
> DAZ detection algorithm.

right


>>my documentation says to fxsave and get the features mask from
>>the mxcsr mask but to fall back to 0xffbf if mask == 0, quoting
>>docs 11.6.6:
>>
>>1 setup a fxsave area
>>2 clear this area
>>3 fxsave in this area
>>4 if mxcsr == 0 use mask 0xffbf else use mxcsr mask
> 
> 
> Too expensive unless the mask is computed at boot time once and for 

yeps,

> all (thrashing half a kB  for a single 32 bit constant, sigh). I did 

uh? you just need to fxsave on stack, extract the mask, the struct
is 512 bytes length, surely during kernel init 512 bytes stack
allocation is right

> not want to touch too many files in my patch, but it seems unavoidable. 


> Now a last question, are there SMP systems in which one processor
> supports DAZ and the other does not, just to complicate matters a
> little more?

Such system are not symetric. I don't think we must take care
about this theorical things and I'm pretty sure than mixing old
P4 and newers in a box can't work. Anyway even if it works
userspace program using DAZ will be not reliable since they can
run from time to time on cpu with DAZ then cpu w/o DAZ.

regards,
Phil


