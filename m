Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbREQWSY>; Thu, 17 May 2001 18:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262199AbREQWSO>; Thu, 17 May 2001 18:18:14 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7434 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262196AbREQWRx>; Thu, 17 May 2001 18:17:53 -0400
Date: Thu, 17 May 2001 17:40:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: mm/memory.c: Missing pte_mkyoung() on mk_pte() calls?
Message-ID: <Pine.LNX.4.21.0105171733020.30965-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

I was looking at mm/memory.c (2.4), and I've noticed that we don't call
pte_mkyoung() on newly created pte's for most of the fault paths.
break_cow(), for example:

 establish_pte(vma, address, page_table, pte_mkwrite(pte_mkdirty(mk_pte(new_page, v ma->vm_page_prot))));

Is there any reason why we don't set the young bit on such places ?

I don't think that the window between the pte creation and the actual
access of the pte by the process is always big enough to avoid kswapd (or
other task trying to free memory) from ripping a created pte. 



