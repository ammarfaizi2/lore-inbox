Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285079AbRLRUuO>; Tue, 18 Dec 2001 15:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285147AbRLRUt5>; Tue, 18 Dec 2001 15:49:57 -0500
Received: from 70.191.38.66.gt-est.net ([66.38.191.70]:41993 "EHLO
	worm.hmi.net") by vger.kernel.org with ESMTP id <S285079AbRLRUr6>;
	Tue, 18 Dec 2001 15:47:58 -0500
Content-Type: text/plain; charset=US-ASCII
From: Olivier Daigle <odaigle@harfangmicro.com>
Organization: Harfang Microtechniques
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: __get_free_pages and page_count
Date: Tue, 18 Dec 2001 15:47:40 -0500
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121815474002.04766@hubble>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,
  Simple question regarding __get_free_pages and (struct page*)->count. Why 
does only the first page returned by __get_free_pages have it's count set to 
1 and all other pages have their count set to 0?

  Example:

#define ORDER 2

  unsigned long p, offset=0;
  struct page *page;
    
  if(!(p=__get_free_pages(SLAB_KERNEL, ORDER))) {
    goto err;
  }

  while(offset < PAGE_SIZE<<ORDER) {
    page=virt_to_page(p+offset);
    SC_DEBUG("  offset: %lu, page_count is %d", offset, page_count(page));
    offset+=PAGE_SIZE;
  }


Resulting output is:
Dec 18 15:36:14 meteor kernel: sc:   offset: 0, page_count is 1 
Dec 18 15:36:14 meteor kernel: sc:   offset: 4096, page_count is 0 
Dec 18 15:36:14 meteor kernel: sc:   offset: 8192, page_count is 0 
Dec 18 15:36:14 meteor kernel: sc:   offset: 12288, page_count is 0 

Thanks,

  Olivier

- -- 
Olivier Daigle <odaigle@harfangmicro.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8H6tsOVJ6DEeRbpERAgTLAKCV6nBuOKKskB8mdhBSwIzoyPGR0gCgh0JN
apjYQFpFixJMiDmn8JrmkXg=
=koo5
-----END PGP SIGNATURE-----
