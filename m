Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312661AbSCVD1P>; Thu, 21 Mar 2002 22:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312663AbSCVD1F>; Thu, 21 Mar 2002 22:27:05 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:11676 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312661AbSCVD1A>; Thu, 21 Mar 2002 22:27:00 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Erik McKee <camhanaich99@yahoo.com>
Date: Fri, 22 Mar 2002 14:28:43 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15514.42219.386145.249902@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Raid 5 & linux 2.5.x
In-Reply-To: message from Erik McKee on Thursday March 21
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 21, camhanaich99@yahoo.com wrote:
> Hello!
> 
> I've noticed that RAID5 needs porting from BH's to BIO's.  Where would one
> start if interested in doing this.  I notice that one would need to change the
> arrays of BH's in the raid5 struct in raid5.h, as well as renaming several
> other variables which currently have md_ prepended to the beginning.  This
> leaves all the BH handling code in raid5.c.  Does this require algorithm
> changes, or is it basically replace bh code for simmilar code using bio's?

I think there is a fundamental issue that raid5 want to deal in 4k
sized requests and bios can be much bigger than this.  So there needs
to be a clean mechanism to dice up a bio into little bits (without
blocking on memory allocation at the wrong time) and to give them to
raid5.  A similar dicing up is needed for raid0, which would want chunk
sized bits, and linear, which would sometimes want to cut a bio in
half and some particular point.

It's on my list of things to worry about but I just haven't had a
chance yet.

NeilBrown
