Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131460AbREIUVP>; Wed, 9 May 2001 16:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131481AbREIUVG>; Wed, 9 May 2001 16:21:06 -0400
Received: from Huntington-Beach.Blue-Labs.org ([208.179.59.198]:18773 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131460AbREIUUt>; Wed, 9 May 2001 16:20:49 -0400
Message-ID: <3AF9A65F.4050208@blue-labs.org>
Date: Wed, 09 May 2001 13:19:43 -0700
From: David <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: david chan <cat@waulogy.stanford.edu>
CC: Linus Torvalds <torvalds@transmeta.com>,
        emu10k1-devel@opensource.creative.com,
        Ed Okerson <eokerson@quicknet.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fixes for Incorrect kmalloc() Sizes
In-Reply-To: <Pine.LNX.4.30.0105082303170.23207-100000@waulogy.stanford.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel ixj.c and associated files are severely out of date and cause 
hard machine hangs when used (kernel 2.4.n).  I suggest that the files 
in the telephony directory be brought up to date with the current CVS 
code.  At least the CVS code only causes an OOPS and doesn't kill the 
whole machine.

David

david chan wrote:

>Hi,
>
>These two patches fix silly kmalloc errors that allocate too little space.
>
>
>Thank you,
>David Chan
>
>
>---snip---
>--- drivers/sound/emu10k1/midi.c.orig	Fri Feb  9 11:30:23 2001
>+++ drivers/sound/emu10k1/midi.c	Tue May  8 19:43:43 2001
>@@ -56,7 +56,7 @@
> {
> 	struct midi_hdr *midihdr;
>
>-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr
>*), GFP_KERNEL)) == NULL) {
>+	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct
>midi_hdr), GFP_KERNEL)) == NULL) {
> 		ERROR();
> 		return -EINVAL;
> 	}
>@@ -328,7 +328,7 @@
> 	if (!access_ok(VERIFY_READ, buffer, count))
> 		return -EFAULT;
>
>-	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct midi_hdr
>*), GFP_KERNEL)) == NULL)
>+	if ((midihdr = (struct midi_hdr *) kmalloc(sizeof(struct
>midi_hdr), GFP_KERNEL)) == NULL)
> 		return -EINVAL;
>
> 	midihdr->bufferlength = count;
>---snip---
>
>---snip---
>--- drivers/telephony/ixj.c.orig	Tue May  8 20:00:07 2001
>+++ drivers/telephony/ixj.c	Tue May  8 20:00:25 2001
>@@ -4475,7 +4475,7 @@
> {
> 	IXJ_FILTER_CADENCE *lcp;
>
>-	lcp = kmalloc(sizeof(IXJ_CADENCE), GFP_KERNEL);
>+	lcp = kmalloc(sizeof(IXJ_FILTER_CADENCE), GFP_KERNEL);
> 	if (lcp == NULL)
> 		return -ENOMEM;
> 	if (copy_from_user(lcp, (char *) cp, sizeof(IXJ_FILTER_CADENCE)))
>---snip---
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


