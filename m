Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282146AbRK1OQX>; Wed, 28 Nov 2001 09:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283057AbRK1OPf>; Wed, 28 Nov 2001 09:15:35 -0500
Received: from mons.uio.no ([129.240.130.14]:19585 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S283061AbRK1OO6>;
	Wed, 28 Nov 2001 09:14:58 -0500
To: <kernel@alon.wox.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: NFS long wait problem
In-Reply-To: <Pine.LNX.4.33L2.0111281553120.786-100000@alon1.dhs.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Nov 2001 15:14:38 +0100
In-Reply-To: <Pine.LNX.4.33L2.0111281553120.786-100000@alon1.dhs.org>
Message-ID: <shsu1vfrnht.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == kernel  <kernel@alon.wox.org> writes:

     > 06:45:23.270071 192.168.1.2.1402759134 > 192.168.1.1.2049: 100
     > null (DF) 06:45:23.271049 192.168.1.1.2049 >
     > 192.168.1.2.1402759134: reply ok 24 null (DF) 06:45:23.271105
     > 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh
     > 96,1/197709 960 bytes @ 0x04019e000 (DF) 06:45:24.670061
     > 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh
     > 96,1/197709 960 bytes @ 0x04019e000 (DF) 06:45:27.470062
     > 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh
     > 96,1/197709 960 bytes @ 0x04019e000 (DF) 06:45:33.070065
     > 192.168.1.2.1302095838 > 192.168.1.1.2049: 1100 write fh
     > 96,1/197709 960 bytes @ 0x04019e000 (DF) 06:45:44.270083
     > 192.168.1.2.1419536350 > 192.168.1.1.2049: 100 null (DF)
     > 06:45:44.270563 192.168.1.1.2049 > 192.168.1.2.1419536350:
     > reply ok 24 null (DF) 06:45:44.270619 192.168.1.2.1302095838 >
     > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @
     > 0x04019e000 (DF) 06:45:47.070068 192.168.1.2.1302095838 >
     > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @
     > 0x04019e000 (DF) 06:45:52.670060 192.168.1.2.1302095838 >
     > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @
     > 0x04019e000 (DF) 06:46:03.870068 192.168.1.2.1302095838 >
     > 192.168.1.1.2049: 1100 write fh 96,1/197709 960 bytes @
     > 0x04019e000 (DF) 06:46:04.115689 192.168.1.1.2049 >
     > 192.168.1.2.1302095838: reply ok 136 write [|nfs] (DF)

     >   This cannot be a physical link problem, as other packets get
     >   transferred
     > correctly on the same link. When this happens, it's always with
     > NFS V3 WRITE calls. Any ideas?

The client isn't seeing any replies from the server. Each and every
one of those write requests should normally be followed up with an
'OK' from the server.

Either the server isn't seeing the write requests, or it isn't
replying to them (because it is busy?) or they are getting lost
somewhere on your network on the way back to the client.

A comparison of 'tcpdump' on the client and the server will tell you
which of these 3 hypotheses is correct.

Cheers,
  Trond
