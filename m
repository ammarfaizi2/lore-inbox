Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135318AbREHUoB>; Tue, 8 May 2001 16:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135328AbREHUnm>; Tue, 8 May 2001 16:43:42 -0400
Received: from fungus.teststation.com ([212.32.186.211]:6050 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S135318AbREHUnb>; Tue, 8 May 2001 16:43:31 -0400
Date: Tue, 8 May 2001 22:43:00 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>, Xuan Baldauf <xuan--lkml@baldauf.org>,
        "James H. Puttick" <james.puttick@kvs.com>
Subject: Re: [PATCH][RFT] smbfs bugfixes for 2.4.4
In-Reply-To: <9d6mur$df1$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0105082131350.4308-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 May 2001, Linus Torvalds wrote:

> It has code to do that in smb_revalidate_inode(), but it may be that
> something else refreshes the inode size _without_ doing the proper
> invalidation checks. Or maybe Urban broke that logic by mistake while
> fixing the other one ;)

No, I broke it when copying the ncpfs dircache code.

That code will reuse an old inode if it already exists (and thus also any
pages attached to it), which is what I wanted and should be fine except
that it needs to invalidate_inode_pages() if something changed.


Xuan and James, you have both seen this bug with smbfs not properly
handling changes made on the server. Could you please test this patch vs
2.4.4 and let me know if it helps or not.

http://www.hojdpunkten.ac.se/054/samba/smbfs-2.4.4-truncate+retry-4.patch
(Apply with 'patch -p1' in the linux/ source dir)

/Urban

