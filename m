Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbREHIaQ>; Tue, 8 May 2001 04:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131949AbREHIaG>; Tue, 8 May 2001 04:30:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:29870 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131899AbREHI3v>;
	Tue, 8 May 2001 04:29:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15095.44668.842241.185318@pizda.ninka.net>
Date: Tue, 8 May 2001 01:29:48 -0700 (PDT)
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105080019420.15378-100000@penguin.transmeta.com>
In-Reply-To: <15095.38698.313444.486904@pizda.ninka.net>
	<Pine.LNX.4.21.0105080019420.15378-100000@penguin.transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus Torvalds writes:
 > Maybe it's academic. Do we know that any of this actually makes any
 > performance difference at all?

We know that dirty swap pages can accumulate to the point where the
swapper starves before it gets to enough of the "second pass" cases of
the page_launder loop to run in order to get rid of them.

That was the behavior I saw that let me to hacking up my broken patch.

Even simple "memory hog" test programs can trigger this behavior.
Just write a program which "grows almost completely into swap then
subsides" over and over again.

Later,
David S. Miller
davem@redhat.com

