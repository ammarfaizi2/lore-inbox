Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310138AbSCKO4c>; Mon, 11 Mar 2002 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSCKO4X>; Mon, 11 Mar 2002 09:56:23 -0500
Received: from ns.ithnet.com ([217.64.64.10]:58896 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S310138AbSCKO4J>;
	Mon, 11 Mar 2002 09:56:09 -0500
Date: Mon, 11 Mar 2002 16:57:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: trond.myklebust@fys.uio.no
Cc: green@namesys.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
Message-Id: <20020311165722.692209c3.skraw@ithnet.com>
In-Reply-To: <15500.47144.705329.809604@charged.uio.no>
In-Reply-To: <shswuwkujx5.fsf@charged.uio.no>
	<200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com>
	<20020311155937.A1474@namesys.com>
	<20020311154852.3981c188.skraw@ithnet.com>
	<20020311165140.A1839@namesys.com>
	<15500.47144.705329.809604@charged.uio.no>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 14:59:04 +0100
Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> >>>>> " " == Oleg Drokin <green@namesys.com> writes:
> 
>      > Trod, do you think that'll work or should some other non-ext2
>      > fs be tried?
> 
> Ext2 should work fine: I've never seen any problems such as that which
> Stephan describes, and certainly not with 2.4.18 clients.
> 
> In any case, any occurence of an ESTALE error *must* first have
> originated from the server. The client itself cannot determine that a
> filehandle is stale.

Next try:
I have now in addition to the /backup and /mnt reiserfs exports created another
ext2 export. First test case:
mount /backup, mount the ext2 fs on /test, then mount /mnt, do i/o on /mnt and
umount /mnt.
After that everything works! /test works _and_ /backup works!

Second test case: (server and client have several network cards, so I can mount
on other ips as well)
mount /backup, mount /mnt on ip1, mount /test on ip2 (from same server). do i/o
on /mnt and umount /mnt.
After that /test works, but/backup is stale.

Conclusion: reiserfs has a problem being nfs-mounted as the only fs to a
client. If you add another fs (here ext2) mount, then even reiserfs is happy.
The problem is originated at the server side.

Any ideas for a fix?

Regards,
Stephan

