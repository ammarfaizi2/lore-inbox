Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154077AbQBHKJd>; Tue, 8 Feb 2000 05:09:33 -0500
Received: by vger.rutgers.edu id <S154146AbQBHJs0>; Tue, 8 Feb 2000 04:48:26 -0500
Received: from fwns2d.raleigh.ibm.com ([204.146.167.236]:4282 "EHLO fwns2.raleigh.ibm.com") by vger.rutgers.edu with ESMTP id <S154412AbQBHJV5>; Tue, 8 Feb 2000 04:21:57 -0500
Message-ID: <38A01C80.ACCA2B9E@raleigh.ibm.com>
Date: Tue, 08 Feb 2000 08:39:12 -0500
From: Ralph Blach <rcblach@raleigh.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: new 16k page size for a PPC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

I am trying to port Linux to an embedded power pc.  I need to use a 16k
page size 
because this processor uses a virtually indexed real tagged instruction
cache.  With a
4k page size this results in instruction synonyms.  If I were to stay
with 4k pages,
then each time I want to invalidate the instruction cache, the synonyms
would have to  be invalidated.
This would require a search of the TLB to verify that the synonym
address was mapped in the TLB.
Execution of an ICBI on a non mapped instruction would result in a
tranlsation error.

With a 16k page size there are no synonyms and therefore there will not
be a TLB search for the
synonym.

I have made the following changes in pgtable.h

#define PMD_SHIFT       24 
#define PGDIR_SHIFT     24

If you have any suggestions please make it to this forum.

Thanks

Chip

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
