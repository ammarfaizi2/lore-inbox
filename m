Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262618AbSI0V1P>; Fri, 27 Sep 2002 17:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262619AbSI0V1P>; Fri, 27 Sep 2002 17:27:15 -0400
Received: from beppo.feral.com ([192.67.166.79]:23058 "EHLO beppo.feral.com")
	by vger.kernel.org with ESMTP id <S262618AbSI0V1N>;
	Fri, 27 Sep 2002 17:27:13 -0400
Date: Fri, 27 Sep 2002 14:32:21 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, Andrew Morton <akpm@digeo.com>,
       Jens Axboe <axboe@suse.de>,
       "Pedro M. Rodrigues" <pmanuel@myrealbox.com>,
       Mathieu Chouquet-Stringer <mathieu@newview.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Warning - running *really* short on DMA buffers while 
 doingfiletransfers
In-Reply-To: <200209272123.g8RLNAi21161@localhost.localdomain>
Message-ID: <Pine.BSF.4.21.0209271428440.22542-100000@beppo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mjacob@feral.com said:
> > Duh. There had been race conditions in the past which caused all of us
> > HBA writers to in fact start swalloing things like QFULL and
> > maintaining internal queues. 
> 
> That was true of 2.2, 2.3 (and I think early 2.4) but it isn't true of late 
> 2.4 and 2.5

Probably. But I'll like leave the 2.4 driver alone. I'm about to fork my
bk repository into 2.2, 2.4 and 2.5 streams and put the 2.4 version into
maintenance mode. 

It turns out that there are other reasons why I maintain an internal
queue that have to do more with hiding fibre channel issues. For
example, if I get a LIP or an RSCN, I have to go out and re-evaluate the
loop/fabric and make sure I've tracked any changes in the identity of
the devices. The cleanest way to handle this right now for linux is to
accept comamnds, disable the scsi timer on them, and restart them once I
get things sorted out again. Maybe this will change for 2.5.

