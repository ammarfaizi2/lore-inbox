Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289140AbSA1IMU>; Mon, 28 Jan 2002 03:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289159AbSA1IME>; Mon, 28 Jan 2002 03:12:04 -0500
Received: from nixpbe.pdb.sbs.de ([192.109.2.33]:61904 "EHLO nixpbe.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S289140AbSA1IL7>;
	Mon, 28 Jan 2002 03:11:59 -0500
Date: Mon, 28 Jan 2002 09:13:36 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Richard Gooch <rgooch@atnf.csiro.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH]: Fix MTRR handling on HT CPUs (improved)
In-Reply-To: <Pine.LNX.4.33.0201251237470.1871-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0201280908500.2067-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So why not just set it twice - surely that is harmless ? Why add complex
> > code ?
>
> At the _least_ you have to serialize the thing, which is most of what the
> patch actually does.

I suppose you're talking about the Intel patch, not mine, which is
obviously out. I admit it was too complex.

The problem with the original code is that it combines reading the status
of the MTRR default register and disabling cache in a single step that
is performed simultaneously by all CPUs.
The patch from Intel inserts synchronization between these two steps,
thereby avoiding that the second CPU reads a "defaults status" that in
reality is the "cache disabled" status the first CPU had set before.
This suffices to fix the problem.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





