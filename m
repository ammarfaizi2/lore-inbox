Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274963AbRIXUjK>; Mon, 24 Sep 2001 16:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274962AbRIXUjA>; Mon, 24 Sep 2001 16:39:00 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:2321 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274952AbRIXUiq>; Mon, 24 Sep 2001 16:38:46 -0400
Date: Mon, 24 Sep 2001 17:38:45 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] minor page aging update
Message-ID: <Pine.LNX.4.33L.0109241734490.1864-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

here is the promised minor page aging update to 2.4.9-ac15:

1) use min()/max() for age_page_{up,down}, now the
   thing is resistant to people changing PAGE_AGE_DECL ;)

2) in try_to_swap_out(), still adjust the page age even if
   the zone does have enough inactive pages ... this is a
   very cheap operation and will keep the page aging info
   in zones better up to date

3) only call do_try_to_free_pages() when we have a free
   shortage, this means kswapd() won't waste CPU time on
   working sets which fit in memory, but "spill over"
   into the inactive list ... also update comments a bit

4) remove run_task_queue(&tq_disk) from kswapd() since
   page_launder() will already have done this if needed

regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

