Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVKLNxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVKLNxH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 08:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbVKLNxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 08:53:07 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:3256 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S932375AbVKLNxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 08:53:05 -0500
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2 OOPS - packet writing
References: <6bffcb0e0511111601j6c53f646m@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 12 Nov 2005 14:52:58 +0100
In-Reply-To: <6bffcb0e0511111601j6c53f646m@mail.gmail.com>
Message-ID: <m3fyq2ug5h.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Piotrowski <michal.k.k.piotrowski@gmail.com> writes:

> On 11/11/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm2/
> 
> Oops while cat /proc/driver/pktcdvd/pktcdvd0
> 
> Linux version 2.6.14-mm2 (michal@debian) (gcc version 4.0.3 20051023

There is an old bug in the pkt_count_states() function that causes
stack corruption. When compiling with gcc 3.x or 2.x it is harmless,
but gcc 4 allocates local variables differently, which makes the bug
visible. Fixed by this patch.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 drivers/block/pktcdvd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 391ced8..b5f67b1 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1188,7 +1188,7 @@ static void pkt_count_states(struct pktc
 	struct packet_data *pkt;
 	int i;
 
-	for (i = 0; i <= PACKET_NUM_STATES; i++)
+	for (i = 0; i < PACKET_NUM_STATES; i++)
 		states[i] = 0;
 
 	spin_lock(&pd->cdrw.active_list_lock);

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
