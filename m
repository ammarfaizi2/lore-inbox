Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131426AbRAOUiz>; Mon, 15 Jan 2001 15:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRAOUip>; Mon, 15 Jan 2001 15:38:45 -0500
Received: from inje.iskon.hr ([213.191.128.16]:61705 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S131426AbRAOUif>;
	Mon, 15 Jan 2001 15:38:35 -0500
To: "Vlad Bolkhovitine" <vladb@sw.com.sg>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: mmap()/VM problems in 2.4.0
In-Reply-To: <3A5EFB40.6080B6F3@sw.com.sg> <3A62C5F0.80C0E8B5@sw.com.sg>
Reply-To: zlatko@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko@iskon.hr>
Date: 15 Jan 2001 21:31:56 +0100
In-Reply-To: "Vlad Bolkhovitine"'s message of "Mon, 15 Jan 2001 17:42:08 +0800"
Message-ID: <87hf30d0ar.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Peisino,Ak(B)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Vlad Bolkhovitine" <vladb@sw.com.sg> writes:

> Here is updated info for 2.4.1pre3:
> 
> Size is MB, BlkSz is Bytes, Read, Write, and Seeks are MB/sec
> 
> with mmap()
> 
>  File   Block  Num          Seq Read    Rand Read   Seq Write  Rand Write
>  Dir    Size   Size    Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     1024   4096    2  1.089 1.24% 0.235 0.45% 1.118 4.11% 0.616 1.41%
> 
> without mmap()
>    
>  File   Block  Num          Seq Read    Rand Read   Seq Write  Rand Write
>  Dir    Size   Size    Thr Rate (CPU%) Rate (CPU%) Rate (CPU%) Rate (CPU%)
> ------- ------ ------- --- ----------- ----------- ----------- -----------
>    .     1024   4096    2  28.41 41.0% 0.547 1.15% 13.16 16.1% 0.652 1.46%
> 
> 
> Mmap() performance dropped dramatically down to almost unusable level. Plus,
> system was unusable during test: "vmstat 1" updated results every 1-2 _MINUTES_!
> 

You need Marcelo's patch. Please apply and retest.



--- linux.orig/mm/vmscan.c      Mon Jan 15 02:33:15 2001
+++ linux/mm/vmscan.c   Mon Jan 15 02:46:25 2001
@@ -153,7 +153,7 @@

                        if (VALID_PAGE(page) && !PageReserved(page)) {
                                try_to_swap_out(mm, vma, address, pte,
page);
-                               if (--count)
+                               if (!--count)
                                        break;
                        }
                }


-- 
Zlatko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
