Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSGaDcR>; Tue, 30 Jul 2002 23:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317705AbSGaDcR>; Tue, 30 Jul 2002 23:32:17 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:64655 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S317701AbSGaDcQ>; Tue, 30 Jul 2002 23:32:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "jeff millar" <wa1hco@adelphia.net>
Date: Wed, 31 Jul 2002 13:32:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15687.23114.805995.595589@notabene.cse.unsw.edu.au>
Cc: "Bill Davidsen" <davidsen@tmr.com>,
       "Jakob Oestergaard" <jakob@unthought.net>,
       "Kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: Re: RAID problems
In-Reply-To: message from jeff millar on Tuesday July 30
References: <Pine.LNX.3.96.1020730223102.6974A-100000@gatekeeper.tmr.com>
	<004501c23841$03265a30$6a01a8c0@wa1hco>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 30, wa1hco@adelphia.net wrote:
> 
> Raid needs an automatic way to maintain device synchronization.  Why should
> I have to...
>     manually examine the device data (lsraid)
>     find two devices that match
>     mark the others failed in /etc/raidtab
>     reinitialize the raid devices...putting all data at risk
>     hot add the "failed" device
>     wait for it to recover (hours)
>     change /etc/raidtab again
>     retest everything
> 
> This is 10 times worse that e2fsck and much more error prone.  The file
> system guru's worked hard on journalling to minimize this kind of risk.
> 

Part of the answer is to use mdadm
   http://www.cse.unsw.edu.au/~neilb/source/mdadm/

mdadm --assemble --force ....

will do a lot of that for you.

Another part of the answer is that raid5 should never mark two drives
as failed.  There really isn't any point.
If they are both really failed, you've lost your data anyway.
If it is really a cable failure, then it should be easier to get back
to where you started from.
I hope to have raid5 working better in this respect in 2.6.

A finally part of the answer is that even perfect raid software cannot
make up for buggy drivers, shoddy hard drives, or flacky cabling.

NeilBrown
