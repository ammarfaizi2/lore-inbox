Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143372AbRAHIMb>; Mon, 8 Jan 2001 03:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137125AbRAHIMV>; Mon, 8 Jan 2001 03:12:21 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:22022
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S143372AbRAHIMJ>; Mon, 8 Jan 2001 03:12:09 -0500
Date: Mon, 8 Jan 2001 21:12:06 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108211206.C4993@metastasis.f00f.org>
In-Reply-To: <20010107045346.B696@metastasis.f00f.org> <Pine.GSO.4.21.0101080250330.2221-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101080250330.2221-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 02:56:10AM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 02:56:10AM -0500, Alexander Viro wrote:

    	Plenty. ext2, for one - e.g. with 4Kb blocks you have limit
    at 0x4010040c000 for files and 0x100000000 for directories. With
    1Kb blocks the limit for files is 0x404043000. Notice that the
    latter is not a multiple of page size on Alpha.

There is code to support this in 2.4.0-ac4 -- initially I didn't like
the way Alan had done things (I was think -EFBIG should be used only
for LFS violations) but after some thought has decided that what he
has makes a lot of sense.

The FS calculates the largest suitable byte-size for a file in put it
in the superblock; when the VFS checks in the generic_file_* paths.
The only time this won't work is if some complex criteria allows some
files to be larger than others, in which case -- we add a callback to
the fs.



  --cw

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
