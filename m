Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAJT1t>; Wed, 10 Jan 2001 14:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbRAJT1j>; Wed, 10 Jan 2001 14:27:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44676 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129436AbRAJT1c>;
	Wed, 10 Jan 2001 14:27:32 -0500
Date: Wed, 10 Jan 2001 11:27:03 -0800
Message-Id: <200101101927.LAA06160@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: torvalds@transmeta.com
CC: ebiederm@xmission.com, andrea@suse.de, dwmw2@infradead.org,
        zlatko@iskon.hr, riel@conectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com>
	(message from Linus Torvalds on Wed, 10 Jan 2001 11:03:21 -0800 (PST))
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 10 Jan 2001 11:03:21 -0800 (PST)
   From: Linus Torvalds <torvalds@transmeta.com>

   "Feel free to try" is definitely the open source motto.

I basically came to the conclusion that it sucks when I
gave it a go.

In my scheme I tried to save space by using very small descriptors to
keep track of anonymous areas in processes.  This was essentially a
vma->vm_anon pointer that kept track of the pages for you.

After trying to fight this for a few days I determined that this
doesn't work at all because of how COW dups the pages around on you.
Also it was a devil to work out anonymous pages created due to writes
to private mmaps of a file, as soon as one of these were made for the
first time on a vma you had to cook up one of the anon descriptors.

Yeah, I got the anon descriptor down to 2 pointers and an atomic
counter, but it didn't work so this achievement was worthless :-)

There are a few approaches that work, but they tend to take up too
much space to be considerable, as Linus mentioned.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
