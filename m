Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130765AbQL2AXg>; Thu, 28 Dec 2000 19:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132963AbQL2AXZ>; Thu, 28 Dec 2000 19:23:25 -0500
Received: from hermes.mixx.net ([212.84.196.2]:55566 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130765AbQL2AXL>;
	Thu, 28 Dec 2000 19:23:11 -0500
Message-ID: <3A4BD1BB.EB20F7BD@innominate.de>
Date: Fri, 29 Dec 2000 00:50:19 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: innd mmap bug in 2.4.0-test12
In-Reply-To: <3A4BA45E.4ADEB2DF@innominate.de> <Pine.LNX.4.10.10012281241240.788-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Ok, pre-5 should have all the same places you found already fixed, but
> please do give it some heavy-duty testing to make sure there isn't
> anything hidden..

I've beaten on it fairly heavily with the BUG in there as you suggested,
with no problems.

This kernel even seems a little faster:

      Test machine: 64 meg, 500 Mhz K6, IDE, Ext2, Blocksize=4K
      Test: dbench 48

      pre4        9.5 MB/sec      11 min 6 secs
      pre5       10.8 MB/sec       9 min 48 secs

I think it would be an awfully good idea to let the BUG out for mass
consumption:

+       if (PageDirty(page)) BUG();
        remove_page_from_inode_queue(page);
        remove_page_from_hash_queue(page);
        page->mapping = NULL;

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
