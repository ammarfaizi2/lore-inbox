Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267018AbSLKFBj>; Wed, 11 Dec 2002 00:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSLKFBj>; Wed, 11 Dec 2002 00:01:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:62665 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267018AbSLKFBh>;
	Wed, 11 Dec 2002 00:01:37 -0500
Message-ID: <3DF6C866.71597CD3@digeo.com>
Date: Tue, 10 Dec 2002 21:08:54 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with mm1 patch for 2.5.51
References: <94F20261551DC141B6B559DC4910867201DE24@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 05:08:54.0824 (UTC) FILETIME=[671C3280:01C2A0D3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> Hi,
> I applied mm1 patch to kernel 2.5.51 and I ran LM bench to test its performance.
> Here are the errors that I obtained.
> 
> EXT3-fs error (device ide0(3,6)) in start_transaction: Journal has aborted

An off-by-one was gratuitously added to ext3_free_blocks


--- 25/fs/ext3/balloc.c~dud-patch	Tue Dec 10 21:07:20 2002
+++ 25-akpm/fs/ext3/balloc.c	Tue Dec 10 21:07:27 2002
@@ -122,7 +122,7 @@ void ext3_free_blocks (handle_t *handle,
 	es = EXT3_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
-	    block + count >= le32_to_cpu(es->s_blocks_count)) {
+	    block + count > le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = %lu, count = %lu", block, count);
