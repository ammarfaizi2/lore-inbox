Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271933AbRH2Isa>; Wed, 29 Aug 2001 04:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271934AbRH2IsV>; Wed, 29 Aug 2001 04:48:21 -0400
Received: from pat.uio.no ([129.240.130.16]:11650 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S271933AbRH2IsG>;
	Wed, 29 Aug 2001 04:48:06 -0400
MIME-Version: 1.0
Message-ID: <15244.44115.209683.288790@charged.uio.no>
Date: Wed, 29 Aug 2001 10:48:19 +0200
To: volodya@mindspring.com
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: NFS in 2.4.9
In-Reply-To: <Pine.LNX.4.20.0108282041120.23923-100000@node2.localnet.net>
In-Reply-To: <shsbsl0ij35.fsf@charged.uio.no>
	<Pine.LNX.4.20.0108282041120.23923-100000@node2.localnet.net>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == volodya  <volodya@mindspring.com> writes:


    >> > NFS: NFSv3 not supported.  nfs warning: mount version older
    >> > than kernel
    >>
    >> You forgot to enable NFSv3 support in your 2.4.9 kernel.

     > I did.. I'll make clean and recompile the kernel again, just in
     > case. But still: why complain about mount ? Why allow to mount
     > a partition ?  I do not think this is the cause (also see
     > below).

The mount format changed when we added NFSv3. The new format is
backward compatible, but we still print out a message in order to
ensure people get the combination NFS + mount correct.

     > the interface. Setting wsize and rsize to 5000 helped - thank
     > you very much ! I guess that between 2.4.7 and 2.4.9 the
     > default rsize and wsize went up.

No. The default should still be the same. I changed the latter last in
the 2.4.0 pre series. You can check what the actual value is using
'/proc/mounts'.

     > Now I am wondering what is wrong with large udp packets ? (my
     > mtu is 1500 and they do get chopped up in smaller packets, but
     > so do size 5524). Any ideas ?

You're probably seeing fragments disappearing. UDP has no mechanism
detect this, so when it happens, the RPC layer first has to time out
and then resend the entire request. In TCP connections, only the
missing fragment needs to be resent.
Now as to the reason why fragments are disappearing, I suggest you
look at your network layout and try to measure (with the aid of a
packet sniffer such as tcpdump) on which segment the loss is occuring.

Cheers,
  Trond
