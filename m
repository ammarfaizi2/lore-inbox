Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262379AbSI2Cn1>; Sat, 28 Sep 2002 22:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262381AbSI2Cn1>; Sat, 28 Sep 2002 22:43:27 -0400
Received: from host194.steeleye.com ([66.206.164.34]:19210 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S262379AbSI2Cn0>; Sat, 28 Sep 2002 22:43:26 -0400
Message-Id: <200209290248.g8T2mbx02015@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Luben Tuikov <luben@splentec.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: Message from Luben Tuikov <luben@splentec.com> 
   of "Sat, 28 Sep 2002 19:25:39 EDT." <3D963A73.F593F5F7@splentec.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 28 Sep 2002 22:48:36 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

luben@splentec.com said:
> TCQ goes hand in hand with Task Attributes. I.e. a tagged task is an
> I_T_L_Q nexus and has a task attribute (Simple, Ordered, Head of
> Queue, ACA; cf. SAM-3, 4.9.1). 

I believe the point I was making is that our only current expectation is 
simple tag, which is unordered.

> aybe the generator of tags (block layer, user process through sg, etc)
> should also set the tag attribute of the task, as per SAM-3. Most
> often (as currently implicitly) this would be a Simple task attribute.
> Why not the block layer borrow the idea from SAM-3, I see IDE only
> coming closer to SCSI...

> This way there'd be no need for explicit barriers. They can be
> implemented through Ordered and Head of Queue Tasks, everything else
> is Simple attribute task (IO scheduler can play with those as it
> wishes).

> This would provide for a more general basis the whole game (IO
> scheduling, TCQ, IO barriers, etc). 

That would be rather the wrong approach.  As the layers move up from the 
physical hardware, the level of abstraction becomes greater, so the current 
proposal is (descending the abstractions):

journal transaction->REQ_BARRIER->cache synchronise (ide) or ordered tag (scsi)

Most of the implementation is in ll_rw_blk.c if you want to take a look

James


