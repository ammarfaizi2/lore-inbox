Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284305AbSBGGwM>; Thu, 7 Feb 2002 01:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284970AbSBGGwC>; Thu, 7 Feb 2002 01:52:02 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22679 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284305AbSBGGvl>;
	Thu, 7 Feb 2002 01:51:41 -0500
Date: Wed, 06 Feb 2002 22:49:40 -0800 (PST)
Message-Id: <20020206.224940.122062252.davem@redhat.com>
To: akpm@zip.com.au
Cc: bcrl@redhat.com, hugh@veritas.com, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C621C74.8A005EB6@zip.com.au>
In-Reply-To: <3C6214F0.A66C89CF@zip.com.au>
	<20020206.215539.33252283.davem@redhat.com>
	<3C621C74.8A005EB6@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Wed, 06 Feb 2002 22:19:32 -0800
   
   It's only a problem if this is the final put_page().  In the
   case of sendfile(), process-context code can be taught to take
   a temporary reference on the page, and only release it after the network
   stack is known to have finished with the page. sendfile is synchronous, yes?

Userspace can return long before the SKBs are free'd up.  That SKB
free doesn't happen until the ACKs come back from the receiver.
