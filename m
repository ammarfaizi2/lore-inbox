Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282717AbRK0Bcr>; Mon, 26 Nov 2001 20:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282716AbRK0Bch>; Mon, 26 Nov 2001 20:32:37 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:64206 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S282715AbRK0Bc0>; Mon, 26 Nov 2001 20:32:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Alok K. Dhir" <alok@dhir.net>
Date: Tue, 27 Nov 2001 12:31:49 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15362.60677.183036.620610@esther.cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Possible md bug in 2.4.16-pre1
In-Reply-To: message from Alok K. Dhir on Monday November 26
In-Reply-To: <000c01c1769c$187cc390$9865fea9@pcsn630778>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday November 26, alok@dhir.net wrote:
> 
> On kernel 2.4.16-pre1 software RAID (tested with levels 0 and 1 on the
> same two drives), it is not possible to "raidstop /dev/md0" after
> mounting and using it, even though the partition is unmounted.  Attempts
> are rejected with "/dev/md0: Device or resource busy".  Even shutting
> down to single user mode does not release the device for stopping.  I
> had to reboot to single user mode, then I was able to stop it,
> unconfigure it, etc.

I think this might be due to a buggy "raidstop".  I seem to recall
someone having a similar problem some months ago.  It turned out that
they we using a vendor supplied raidstop that did the wrong thing.

Could you try compiling raid-tools from 
http://www.kernel.org/pub/linux/daemons/raid/alpha/raidtools-19990824-0.90.tar.bz2   

and see if that works.

Alternaltely, get mdctl from

  http://www.cse.unsw.edu.au/~neilb/source/mdctl/

and use 
   mdctl --stop /dev/md0

If this still doesn't work, please send me an "strace" of raidstop
running and failing.

NeilBrown
