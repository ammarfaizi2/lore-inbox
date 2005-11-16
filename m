Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVKPPW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVKPPW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 10:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVKPPW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 10:22:56 -0500
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:16338 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S1030233AbVKPPWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 10:22:55 -0500
Message-ID: <437B4EB0.3080908@kolumbus.fi>
Date: Wed, 16 Nov 2005 17:22:24 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
       Andi Kleen <ak@suse.de>
Subject: DMA32 zone unusable
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP1|June 19, 2005) at 16.11.2005 17:22:37,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP1|June
 19, 2005) at 16.11.2005 17:23:31,
	Serialize complete at 16.11.2005 17:23:31
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new DMA32 zone (which at least x86-64 has) is quite "interesting" :

#define __GFP_DMA32    ((__force gfp_t)0x04) <-----!!!!!  

#define GFP_ZONEMASK    0x03   <------!!!!!

#define gfp_zone(mask) ((__force int)((mask) & (__force gfp_t)GFP_ZONEMASK))

static inline struct page *alloc_pages_node(int nid, gfp_t gfp_mask,
                        unsigned int order)
{
    if (unlikely(order >= MAX_ORDER))
        return NULL;

    return __alloc_pages(gfp_mask, order,
        NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
}


So with GFP_DMA32 you never get those pages (but DMA instead).

--Mika

