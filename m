Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136448AbRAHLtw>; Mon, 8 Jan 2001 06:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135386AbRAHLtc>; Mon, 8 Jan 2001 06:49:32 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24083 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S137124AbRAHLtZ>; Mon, 8 Jan 2001 06:49:25 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: cw@f00f.org (Chris Wedgwood)
Date: Mon, 8 Jan 2001 11:50:29 +0000 (GMT)
Cc: viro@math.psu.edu (Alexander Viro), alan@lxorguk.ukuu.org.uk (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <20010108211206.C4993@metastasis.f00f.org> from "Chris Wedgwood" at Jan 08, 2001 09:12:06 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Faoq-0004Mu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is code to support this in 2.4.0-ac4 -- initially I didn't like
> the way Alan had done things (I was think -EFBIG should be used only
> for LFS violations) but after some thought has decided that what he
> has makes a lot of sense.

Its based on the docs I have + a test program for the non LFS/limit cases that
sct provided. -ac4 isnt quite compliant (sends SIGXFZ on a short write case
which is wrong and also doesnt do a write partiall overlapping the disk limit)

-ac5 should fix those

> The only time this won't work is if some complex criteria allows some
> files to be larger than others, in which case -- we add a callback to
> the fs.

You don't need to add the callback. Set the limit infinite and handle it in your
truncate and writing paths.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
