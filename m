Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269413AbRIBVaS>; Sun, 2 Sep 2001 17:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269437AbRIBVaJ>; Sun, 2 Sep 2001 17:30:09 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:32662 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S269413AbRIBV3u>; Sun, 2 Sep 2001 17:29:50 -0400
Date: Sun, 2 Sep 2001 23:30:08 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Bob McElrath <mcelrath+linux@draal.physics.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Editing-in-place of a large file
Message-ID: <20010902233008.Q9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu>; from mcelrath+linux@draal.physics.wisc.edu on Sun, Sep 02, 2001 at 03:21:37PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 02, 2001 at 03:21:37PM -0500, Bob McElrath wrote:
> I would like to take an extremely large file (multi-gigabyte) and edit
> it by removing a chunk out of the middle.  This is easy enough by
> reading in the entire file and spitting it back out again, but it's
> hardly efficent to read in an 8GB file just to remove a 100MB segment.
> 
> Is there another way to do this?
 
It's basically changing ownership (in terms of "which inode owns
which blocks") of blocks. 

There is just no POSIX-API to do this, that's why there is no
simple way to do this.

Applications handling such large files usally implement a chunk
management, which can mark chunks as "unused" and skip them while
processing the file.

What's needed is a generalisation of sparse files and truncate().
They both handle similar problems.

For now I would seriously consider editing the ext2-structures
for this, because that's the only way you can do this right now.

Regards

Ingo Oeser
-- 
In der Wunschphantasie vieler Mann-Typen [ist die Frau] unsigned und
operatorvertraeglich. --- Dietz Proepper in dasr
