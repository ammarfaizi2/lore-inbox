Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289757AbSAPHmr>; Wed, 16 Jan 2002 02:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289773AbSAPHma>; Wed, 16 Jan 2002 02:42:30 -0500
Received: from cs.huji.ac.il ([132.65.16.10]:3304 "EHLO cs.huji.ac.il")
	by vger.kernel.org with ESMTP id <S289757AbSAPHmZ>;
	Wed, 16 Jan 2002 02:42:25 -0500
Date: Wed, 16 Jan 2002 09:42:23 +0200 (IST)
From: Amar Lior <lior@cs.huji.ac.il>
To: linux-kernel@vger.kernel.org
Subject: sys_readahead.
In-Reply-To: <200201160718.g0G7IAE09882@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.20_heb2.08.0201160931100.29596-100000@mos214.cs.huji.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I tried to use the new syscall readahead and i found out the
following in do_readahead (mm/filemap.c)
--------------------------------------------------
   .....
/* And limit it to a sane percentage of the inactive list..*/
  max = nr_inactive_pages/ 2;
  if (nr > max)
       nr = max;
  
  while (nr) {
                page_cache_read(file, index);
                index++;
                nr--;
        }
....
---------------------------

My question is why use only nr_inactive_pages/2. I checked this
value on unloaded machine and it was very very small (~100) pages.
While the nr_free_pages() value was much larger.
Why not take into consideration also the value of nr_free_pages()
and do something like

  max = (nr_inactive_pages + nr_free_pages())/ 2;

So if i have free pages i would be able to perform large readaheads


10x

--lior


________________________________________________________________   
Lior Amar                       Distributed Computing Lab MOSIX
E-mail  : lior@cs.huji.ac.il                           
________________________________________________________________   


