Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273495AbRIUMsk>; Fri, 21 Sep 2001 08:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273496AbRIUMsa>; Fri, 21 Sep 2001 08:48:30 -0400
Received: from [195.66.192.167] ([195.66.192.167]:65284 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S273495AbRIUMsP>; Fri, 21 Sep 2001 08:48:15 -0400
Date: Fri, 21 Sep 2001 15:46:54 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <7126003481.20010921154654@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
In-Reply-To: <15275.1922.771056.17407@charged.uio.no>
In-Reply-To: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
 <shswv2tpyvq.fsf@charged.uio.no>
 <1978861221.20010921110112@port.imtp.ilyichevsk.odessa.ua>
 <15275.1922.771056.17407@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Trond,
Friday, September 21, 2001, 12:25:22 PM, you wrote:
TM> Bullshit. killall5 is definitely *not* a well accepted method for
TM> shutting down applications. Try doing that while your network is
TM> running via a ppp link...

And what is the well accepted method? I'd like to fix my system,
so please somebody enlighten me...

TM> Some programs *have* to be shutdown in a certain order. All RPC
TM> servers fall into that category.

Somehow, I feel I'm beginning to dislike RPC... Until now,
I see only added difficulties with RPC-based services
compared to "ordinary" ones (http etc).

TM>> So, why modified killall5 does the job?
TM> I've no idea how you modified killall5, but if it manages to kill nfsd
TM> before killing the portmapper, then all will work.

I commented out kill(..SIGSTOP..) / kill(..SIGCONT..) in killall5 source.

TM>> Why not make portmapper+NFS daemons killable by TERM, giving
TM>> them the chance to do proper cleanups rather than abrupt KILL?
TM> NFS daemons *do* perform proper cleanups. That's the whole essence of
TM> your problem - they are waiting on the portmapper to acknowledge that
TM> it has unregistered their service. These are *kernel* daemons and so
TM> KILL acts just like any signal as far as they are concerned.

Hmm... NFS daemons wait for portmapper which is gone.
This reminds me of #include order problems in C.

Why nfsd does not die on TERM? It will have a chance of
unregistering (if portmapper does not bail out upon TERM
but waits for all RPC services to unregister first).
Isn't that going to work?
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


