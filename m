Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272953AbRIUJZk>; Fri, 21 Sep 2001 05:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272913AbRIUJZV>; Fri, 21 Sep 2001 05:25:21 -0400
Received: from pat.uio.no ([129.240.130.16]:48539 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S272835AbRIUJZM>;
	Fri, 21 Sep 2001 05:25:12 -0400
MIME-Version: 1.0
Message-ID: <15275.1922.771056.17407@charged.uio.no>
Date: Fri, 21 Sep 2001 11:25:22 +0200
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
In-Reply-To: <1978861221.20010921110112@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
	<shswv2tpyvq.fsf@charged.uio.no>
	<1978861221.20010921110112@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == VDA  <VDA@port.imtp.ilyichevsk.odessa.ua> writes:

     > Well, do you mean I must update my shutdown script whenever I
     > install something new just because this "something new" does
     > not like standard, well accepted method of signalling apps to
     > exit?  Come on, this sounds like The Wrong Way.

Bullshit. killall5 is definitely *not* a well accepted method for
shutting down applications. Try doing that while your network is
running via a ppp link...

Some programs *have* to be shutdown in a certain order. All RPC
servers fall into that category.

     > So, why modified killall5 does the job?

I've no idea how you modified killall5, but if it manages to kill nfsd
before killing the portmapper, then all will work.

     > Why not make portmapper+NFS daemons killable by TERM, giving
     > them the chance to do proper cleanups rather than abrupt KILL?

NFS daemons *do* perform proper cleanups. That's the whole essence of
your problem - they are waiting on the portmapper to acknowledge that
it has unregistered their service. These are *kernel* daemons and so
KILL acts just like any signal as far as they are concerned.

Cheers,
   Trond
