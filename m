Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131977AbRBFBT3>; Mon, 5 Feb 2001 20:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbRBFBTT>; Mon, 5 Feb 2001 20:19:19 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:49412 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S131977AbRBFBTF>; Mon, 5 Feb 2001 20:19:05 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Byron Stanoszek <gandalf@winds.org>
Date: Tue, 6 Feb 2001 12:18:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14975.20733.827783.777739@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: NFS stop/start problems (related to datagram shutdown bug?)
In-Reply-To: message from Byron Stanoszek on Monday February 5
In-Reply-To: <14975.15829.623996.534161@notabene.cse.unsw.edu.au>
	<Pine.LNX.4.21.0102051935270.1746-100000@winds.org>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday February 5, gandalf@winds.org wrote:
> On Tue, 6 Feb 2001, Neil Brown wrote:
> 
> > How repeatable is this?  Is the server SMP?
> 
> I've tested this on two UP Athlons and 2 SMP Pentium 3's and the same problem
> occurred. I have not tested it more than once on the same system (I left the
> NFS servers untouched after the reboot).
> 
> The Athlon systems running NFS were 2.4.1-ac3 and the Pentiums were running
> 2.2.19-pre7. All computers exporting the FS had one directory mounted at least
> once.
> 
> In one case, only 1 directory was mounted once and then unmounted before
> shutting off the NFS server. When I realized I forgot to copy a directory over,
> I went to restart NFS on the server and found out I was unable to. Probably
> irrelevant, but this had been after transferring 7 gigs of data over 100 Mbps.
> 
> I still have the 'broken' server running, so if you would like me to run a
> command or two on it I can show you the results.

I don't think that there is much useful that I could look at, thanks.

> 
> > The attached patch might fix it, so if you are having reproducable
> > problems, it might be worth applying this patch.
> 
> I can try it tomorrow and see if it fixes the problem, but since this problem
> also occurred on a UP, using spin locks probably will not correct it. Perhaps
> it's something else.

On second thoughts, this doesn't need to be SMP related.  I don't know
much about "bottom halves" but I gather that they get run after an
interrupt has been handled and interrupts have been re-enabled, but
before the original process is rescheduled.  If this is the case, then
the "_bh" part of the "spin_lock_bh" (which does a local_bh_disable)
could be the bit that is important on a UP system.

NeilBrown


> 
> > [patch snipped]
> 
>  -Byron
> 
> -- 
> Byron Stanoszek                         Ph: (330) 644-3059
> Systems Programmer                      Fax: (330) 644-8110
> Commercial Timesharing Inc.             Email: byron@comtime.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
