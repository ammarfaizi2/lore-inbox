Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275739AbRJFVJp>; Sat, 6 Oct 2001 17:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275743AbRJFVJf>; Sat, 6 Oct 2001 17:09:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16913 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S275739AbRJFVJ2>; Sat, 6 Oct 2001 17:09:28 -0400
Subject: Re: %u-order allocation failed
To: mikulas@artax.karlin.mff.cuni.cz
Date: Sat, 6 Oct 2001 22:13:41 +0100 (BST)
Cc: anton@samba.org (Anton Blanchard), riel@conectiva.com.br (Rik van Riel),
        kszysiu@main.braxis.co.uk (Krzysztof Rusocki), linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1011006203014.7808A-100000@artax.karlin.mff.cuni.cz> from "Mikulas Patocka" at Oct 06, 2001 09:07:31 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15pylR-0002LE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is perfectly OK to have a bit slower access to task_struct with
> probability 1/1000000.

Except that you added a bug where some old driver code would crash the 
machine by doing so.

> Yes, but there are still other dangerous usages of kmalloc and
> __get_free_pages. (The most offending one is in select.c)

Nothing dangeorus there. The -ac vm isnt triggering these cases.

> not abort his operation when it happens. Instead - they are trying to make
> high-order allocations fail less often :-/  How should random
> Joe-driver-developer know, that kmalloc(4096) is safe and kmalloc(4097) is
> not?

4096 is not safe - there is no safe size for a kmalloc, you can always run
out of memory - deal with it.

Alan
