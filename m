Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSLJWKv>; Tue, 10 Dec 2002 17:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSLJWKv>; Tue, 10 Dec 2002 17:10:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:22682 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264943AbSLJWKu>;
	Tue, 10 Dec 2002 17:10:50 -0500
Date: Tue, 10 Dec 2002 14:14:51 -0800 (PST)
Message-Id: <20021210.141451.66294590.davem@redhat.com>
To: raul@pleyades.net
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [BK-2.4] [PATCH] Small do_mmap_pgoff correction
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021210221357.GA46@DervishD>
References: <20021210205906.GA82@DervishD>
	<20021210.132207.23687680.davem@redhat.com>
	<20021210221357.GA46@DervishD>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: DervishD <raul@pleyades.net>
   Date: Tue, 10 Dec 2002 23:13:57 +0100
   
       Sincerely, I don't understand why this patch is bad. Is no worse
   than the previous situation :??
   
How about something like:

	if (len == 0)
		return addr;

	len = PAGE_ALIGN(len);
	if (len > TASK_SIZE || len == 0)
		return -EINVAL;

That should cover all cases and not make the TASK_SIZE assumption.
