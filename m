Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285099AbRLLJDb>; Wed, 12 Dec 2001 04:03:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285110AbRLLJDW>; Wed, 12 Dec 2001 04:03:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:58893 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S285099AbRLLJDE>;
	Wed, 12 Dec 2001 04:03:04 -0500
Date: Wed, 12 Dec 2001 10:02:53 +0100
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: anton@samba.org, plars@austin.ibm.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Scsi problems in 2.5.1-pre9
Message-ID: <20011212090253.GR13498@suse.de>
In-Reply-To: <20011211212802.GA30520@krispykreme> <20011211.140409.21593464.davem@redhat.com> <20011211221747.GB30520@krispykreme> <20011211.142714.115908324.davem@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <20011211.142714.115908324.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 11 2001, David S. Miller wrote:
>    From: Anton Blanchard <anton@samba.org>
>    Date: Wed, 12 Dec 2001 09:17:47 +1100
>     
>    > In that case you perhaps should be defining DMA_CHUNK_SIZE in
>    > asm/dma.h :-)
>    
>    Hmm I have it defined, just not in dma.h :) I'll fix it now and retest.
> 
> Oh nevermind then, the location really is almost arbitrary.
> As long as scsi_merge.c sees it.
> 
> Note this is one area Jens hasn't been able to test and I've been
> trying first to solidify my sparc64 setup without DMA_CHUNK_SIZE
> defined.

Dave nailed this bug, Anton you'll want to apply it before testing :-)
It fixes a case of too much copy'n paste with back merges +
DMA_CHUNK_SIZE enabled.

-- 
Jens Axboe


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=merge-dma-chunk-1

--- /opt/kernel/linux-2.5.1-pre10/drivers/scsi/scsi_merge.c	Tue Dec 11 13:30:36 2001
+++ drivers/scsi/scsi_merge.c	Wed Dec 12 03:59:58 2001
@@ -307,7 +307,7 @@
 	}
 
 #ifdef DMA_CHUNK_SIZE
-	if (MERGEABLE_BUFFERS(bio, req->bio))
+	if (MERGEABLE_BUFFERS(req->biotail, bio))
 		return scsi_new_mergeable(q, req, bio);
 #endif
 

--x4pBfXISqBoDm8sr--
