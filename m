Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269923AbTGKM3k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269922AbTGKM2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:28:45 -0400
Received: from village.ehouse.ru ([193.111.92.18]:32786 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S269915AbTGKM1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:27:09 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: linux-kernel@vger.kernel.org
Subject: [Fixed] Re: [Bug 898] New: Very HIGH File & VM system latencies and system stop responding while extracting big tar archive file.
Date: Fri, 11 Jul 2003 16:41:49 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111641.49453.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 14:45, Andrew Morton wrote:
> Nick Piggin <piggin@cyberone.com.au> wrote:
> > You're sure 2.5.74 got processes stuck in D? That means its possibly
> >  a driver bug. If you can get 2.5.75 to hang, please also try with
> >  elevator=deadline. Thank you.

Yes it hangs also with both 2.5.74 and 2.5.75 elevatot=deadline

>
> No, this will be the reiserfs bug.

Yes, this was a real fix.

Thank you all for your quick response :).

>
> --- 25/fs/reiserfs/tail_conversion.c~reiserfs-dirty-memory-fix        
2003-07-10
> 22:22:54.000000000 -0700 +++
> 25-akpm/fs/reiserfs/tail_conversion.c 2003-07-10 22:22:54.000000000 -0700
> @@ -191,7 +191,7 @@ unmap_buffers(struct page *page, loff_t
>       bh = next ;
>        } while (bh != head) ;
>        if ( PAGE_SIZE == bh->b_size ) {
> -     ClearPageDirty(page);
> +     clear_page_dirty(page);
>        }
>      }
>    }
>
> _
-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
