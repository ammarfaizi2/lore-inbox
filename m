Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273007AbRINSTy>; Fri, 14 Sep 2001 14:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273369AbRINSTo>; Fri, 14 Sep 2001 14:19:44 -0400
Received: from [207.167.207.80] ([207.167.207.80]:33512 "EHLO mx.atitech.ca")
	by vger.kernel.org with ESMTP id <S273007AbRINSTh>;
	Fri, 14 Sep 2001 14:19:37 -0400
Message-ID: <761E23C7F09AD51188990008C74C26141222@fgl00exh01.atitech.com>
From: Alexander Stohr <AlexanderS@ati.com>
To: Alexander Stohr <AlexanderS@ati.com>, linux-kernel@vger.kernel.org
Subject: 2.4.9 highmem.h/bh_kmap raises "void*" warnings
Date: Fri, 14 Sep 2001 20:18:18 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this code:

  static inline char *bh_kmap(struct buffer_head *bh)

  {

      return kmap(bh->b_page) + bh_offset(bh);

  }

 
  static inline void *kmap(struct page *page) { return page_address(page); }

raises a "void* used in arithmetics" warning.

you might want to fix that by applying this
change to the critical line.

      return (char*)kmap(bh->b_page) + bh_offset(bh);


of course not anybody does run their compiles with most warnings on,
but in order to reason my proposal, its better to explicitely 
specify and fix the size of the elements than passing this size 
decision over to the compiler designer.

regards AlexS

PS: i am not subscribed to this list.

