Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143484AbRAHMIo>; Mon, 8 Jan 2001 07:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143451AbRAHMIe>; Mon, 8 Jan 2001 07:08:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:4100 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S143484AbRAHMIW>; Mon, 8 Jan 2001 07:08:22 -0500
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
To: viro@math.psu.edu (Alexander Viro)
Date: Mon, 8 Jan 2001 12:09:36 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        stefan@hello-penguin.com (Stefan Traby), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0101080647090.4061-100000@weyl.math.psu.edu> from "Alexander Viro" at Jan 08, 2001 06:50:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fb7L-0004Q2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I put it into generic_file_write. That covers most fs's it seems. The jffs 
> > guys are going to switch to generic_file_write soon and the other fs's 
> > that dont are wacko ones I dont care about ;)
> 
> Alan, we have to deal with get_block() failures anyway. -ENOSPC, -EDQUOT,
> not to mention plain and simple -EIO. -EFBIG handling is not different.

EFBIG is very different in several ways. To start with the get_block code
doesnt have enough information to correctly implement the SUS specification
rules.

The generic cases can be handled in generic code. They cannot cleanly be
handled by copying that code into every file system. Ditto with truncate.
Since the VFS can handle them nicely the VFS should handle them.

Alan
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
