Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbRAFQHl>; Sat, 6 Jan 2001 11:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131393AbRAFQHb>; Sat, 6 Jan 2001 11:07:31 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:30724
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S130643AbRAFQHU>; Sat, 6 Jan 2001 11:07:20 -0500
Date: Sun, 7 Jan 2001 05:07:18 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Stefan Traby <stefan@hello-penguin.com>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010107050718.C696@metastasis.f00f.org>
In-Reply-To: <20010107045346.B696@metastasis.f00f.org> <E14Evjb-0001Dk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14Evjb-0001Dk-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 06, 2001 at 03:58:20PM +0000
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 06, 2001 at 03:58:20PM +0000, Alan Cox wrote:

    Ext2 handles large files almost properly. (properly on 2.2 +
    patches) NFSv3 handles large files but might be missing the
    O_LARGEFILE check.  I believe reiserfs went to at least 4Gig.

reiserfs 3.6.x under 2.4.x should go much higher unless i am reading
something wrong

<pause>

yup, it does.


as for NFS, I'm not sure how to pass O_LARGEFILE via the protocol and
since NFS isn't really POSIX like anyhow decided we might as well
just ingore it and have all sys_open calls for NFS look like
O_LARGEFILE was specified



move this check and also write/seek check into the VFS would make
sense; right now you can 


  f = open("blah",O_RDWR & ~O_LARGEFILE);
  lseek(f,1024*1024*1024,SEEK_CUR);
  lseek(f,1024*1024*1024,SEEK_CUR);
  lseek(f,1024*1024*1024,SEEK_CUR);
  write(f,"alan's beard",12);
  close(f);

and create a file you cannot open again with the same application




  --cw
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
