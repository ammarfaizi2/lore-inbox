Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270224AbRH1FET>; Tue, 28 Aug 2001 01:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270253AbRH1FEJ>; Tue, 28 Aug 2001 01:04:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39691 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270224AbRH1FEA>; Tue, 28 Aug 2001 01:04:00 -0400
Date: Tue, 28 Aug 2001 00:36:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: page_launder() on 2.4.9/10 issue
Message-ID: <Pine.LNX.4.21.0108272356100.7602-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

I just noticed that the new page_launder() logic has a big bad problem.

The window to find and free previously written out pages by page_launder()
is the amount of writeable pages on the inactive dirty list.

We'll keep writing out dirty pages (as long as they are available) even if
have a ton of cleaned pages: its just that we don't see them because we
scan a small piece of the inactive dirty list each time.

That obviously did not happen with the full scan behaviour.

With asynchronous i_dirty->i_clean movement (moving a cleaned page to the
clean list at the IO completion handler. Please don't consider that for
2.4 :)) this would not happen, too.


