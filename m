Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135580AbREHDSy>; Mon, 7 May 2001 23:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135953AbREHDSp>; Mon, 7 May 2001 23:18:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32940 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135580AbREHDSh>;
	Mon, 7 May 2001 23:18:37 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.25990.868966.309506@pizda.ninka.net>
Date: Mon, 7 May 2001 20:18:30 -0700 (PDT)
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105072231470.7685-100000@freak.distro.conectiva>
In-Reply-To: <15095.24153.737361.998494@pizda.ninka.net>
	<Pine.LNX.4.21.0105072231470.7685-100000@freak.distro.conectiva>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo Tosatti writes:
 > I just thought about this case:
 >   
 > We find a dead swap cache page, so dead_swap_page goes to 1.
 > 
 > We call swap_writepage(), but in the meantime the swapin readahead code   
 > got a reference on the swap map for the page.
 > 
 > We write the page out because "(swap_count(page) > 1)", and we may
 > not have __GFP_IO set in the gfp_mask. Boom.

Hmmm, can't this happen without my patch?

Nothing stops people from getting references to the page
between the "Page is or was in use?" test and the line
which does "TryLockPage(page)".

Later,
David S. Miller
davem@redhat.com

