Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbRG3WJr>; Mon, 30 Jul 2001 18:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268628AbRG3WJh>; Mon, 30 Jul 2001 18:09:37 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:10248 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268598AbRG3WJU>; Mon, 30 Jul 2001 18:09:20 -0400
Date: Mon, 30 Jul 2001 17:39:22 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Use-once change and inactive shortage calculation
Message-ID: <Pine.LNX.4.21.0107301729470.7432-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi, 

With Daniel's use-once change added in pre1, we have all pages added to
the pagecache moved to the inactive dirty list. 

We're doing lazy list movement, so we don't update the information on the
inactive dirty list until we have a free shortage (that is, page_launder()
is not called until we have a free shortage).

This means we're not going to age pages/ptes without a free shortage,
since we always think the inactive lists have enough "inactive" pages.
Really really bad.

The best solution, IMO, is to unlazy queue movement. Doing this would
result in accurate inactive/free information.



