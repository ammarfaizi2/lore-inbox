Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143608AbRAHPdF>; Mon, 8 Jan 2001 10:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143961AbRAHPc4>; Mon, 8 Jan 2001 10:32:56 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31135 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S143608AbRAHPcr>;
	Mon, 8 Jan 2001 10:32:47 -0500
Date: Mon, 8 Jan 2001 10:32:44 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <E14Fduy-0004jm-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0101081010330.4061-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Alan Cox wrote:

> > Which happens to be remarkably ugly. And it will not get better tomoorow...
> 
> Its really only ugly in one way which is that you pass an int for the item
> rather than having a struct of all the data

You know as well as I do that as soon as we add it glibc folks _will_
start whin^Wasking for "just one more field". So structure is out of
question for pretty obvious reasons... Wanna bet that they'll ask for
maximal size of symlink that could be created in directory? Or truncate
long names vs. reject long names policy. And everything from /proc/mounts,
since "binary data is easier to parse". And case sensitivity. And
NLS used. And timezone of that filesystem. And SGID policy (BSD vs. SysV).
And subset of mode bits available on that fs. And ability to create
device nodes. And...  There is a lot of crap that could be asked for.
General rule with GNU seems to be that _every_ piece of crap somebody
had thought about gets tossed into the mix.

Prediction:
	* Any attempt to decide on a fixed structure will generate a flamewar,
where everyone and his mom will advocate their pet features.
	* There will be regular requests to play syscall of the week game.
I.e. new version of pathconf(2) that will support more new features. Old
ones will not go away, indeed.
	* There will be regular requests to make syscall versioned (read:
magic number + pointer to structure with layout depending on that number).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
