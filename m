Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbSJPDic>; Tue, 15 Oct 2002 23:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264839AbSJPDib>; Tue, 15 Oct 2002 23:38:31 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:49546 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S264836AbSJPDib>; Tue, 15 Oct 2002 23:38:31 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Hirokazu Takahashi <taka@valinux.co.jp>
Date: Wed, 16 Oct 2002 13:44:04 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.57476.858253.961941@notabene.cse.unsw.edu.au>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] zerocopy NFS for 2.5.36
In-Reply-To: message from Hirokazu Takahashi on Monday October 14
References: <20020918.171431.24608688.taka@valinux.co.jp>
	<15786.23306.84580.323313@notabene.cse.unsw.edu.au>
	<20021014.210144.74732842.taka@valinux.co.jp>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 14, taka@valinux.co.jp wrote:
> >  I'm bit I'm not very sure about is the 'shadowsock' patch for having
> >  several xmit sockets, one per CPU.  What sort of speedup do you get
> >  from this?  How important is it really?
> 
> It's not so important.
> 
> davem> Personally, it seems rather essential for scalability on SMP.
> 
> Yes.
> It will be effective on large scale SMP machines as all kNFSd shares
> one NFS port. A udp socket can't send data on each CPU at the same
> time while MSG_MORE/UDP_CORK options are set.
> The UDP socket have to block any other requests during making a UDP frame.
> 

After thinking about this some more, I suspect it would have to be
quite large scale SMP to get much contention.
The only contention on the udp socket is, as you say, assembling a udp
frame, and it would be surprised if that takes a substantial faction
of the time to handle a request.

Presumably on a sufficiently large SMP machine that this became an
issue, there would be multiple NICs.  Maybe it would make sense to
have one udp socket for each NIC.  Would that make sense? or work?
It feels to me to be cleaner than one for each CPU.

NeilBrown
