Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbSK1B7q>; Wed, 27 Nov 2002 20:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbSK1B7q>; Wed, 27 Nov 2002 20:59:46 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:45828
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP
	id <S265077AbSK1B7o>; Wed, 27 Nov 2002 20:59:44 -0500
Subject: Re: [Ext2-devel] Re: [NFS] htree+NFS (NFS client bug?)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Ext2 devel <ext2-devel@lists.sourceforge.net>,
       NFS maillist <nfs@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021127150053.A2948@redhat.com>
References: <1038354285.1302.144.camel@sherkaner.pao.digeo.com>
	 <shsptsrd761.fsf@charged.uio.no>
	 <1038387522.31021.188.camel@ixodes.goop.org>
	 <20021127150053.A2948@redhat.com>
Content-Type: multipart/mixed; boundary="=-r0twb5nRmFtdgcnegw1F"
Organization: 
Message-Id: <1038449223.1464.17.camel@ixodes.goop.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 27 Nov 2002 18:07:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r0twb5nRmFtdgcnegw1F
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2002-11-27 at 07:00, Stephen C. Tweedie wrote:
> The dump looks problematic, but I'm not sure whether it's a client or
> a server problem.
> 
> Frame 6 is a READDIR reply, ending with 
>     Entry: file ID 294052, name vg_include.h~51-kill-inceip
>         Cookie: 1611747420
>     Entry: file ID 298407, name vg_libpthread.vs
>         Cookie: 1611747420
>     Value Follows: No
>     EOF: 1
> 
> Now, this final frame has EOF = 1, so the client should not be looking
> for any more data after it.  If the client _does_ try to progress,
> though, it will use that final cookie for the next request, and will
> naturally find the results already in cache so will repeat the final
> chunk of directory entries.

Hm, I just did a run with 8k NFS packets, and the results are slightly
different.  There's only a single READDIR reply, fragmented over 3 IP
packets.  vg_include.h~51-kill-inceip still has a cookie of 1611747420,
and vg_libpthread.vs is still the last entry returned, but it has a
cookie of 0.  As far as I can see, all the other cookies are unique.

Trace attached.

	J

--=-r0twb5nRmFtdgcnegw1F
Content-Disposition: attachment; filename=nfs-8k.pcap.gz
Content-Type: application/x-gzip; name=nfs-8k.pcap.gz
Content-Transfer-Encoding: base64

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

--=-r0twb5nRmFtdgcnegw1F--

