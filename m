Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274569AbRITRPp>; Thu, 20 Sep 2001 13:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274567AbRITRPa>; Thu, 20 Sep 2001 13:15:30 -0400
Received: from mons.uio.no ([129.240.130.14]:54158 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S274568AbRITRPL>;
	Thu, 20 Sep 2001 13:15:11 -0400
To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS daemons in D state for 2 minutes at shutdown
In-Reply-To: <3531863216.20010920164639@port.imtp.ilyichevsk.odessa.ua>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 20 Sep 2001 19:15:21 +0200
In-Reply-To: VDA's message of "Thu, 20 Sep 2001 16:46:39 +0300"
Message-ID: <shswv2tpyvq.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == VDA  <VDA@port.imtp.ilyichevsk.odessa.ua> writes:

     > Hi NFS folks, I am still fighting witn nfsd/lockd not dying
     > upon killall5.  (they are stuck in D state for 2 mins and then
     > die with "rpciod: active tasks at shutdown?!" at console)

     > I found out that nfsd and lockd die as expected when I use
     > modified killall5 which do not SIGSTOP all tasks before killing
     > them.

     > Any idea why this makes such difference? Is this a bug in
     > nfsd/lockd or in killall5?

killall5 is a bad idea as a method for killing nfsd/lockd. You are
better off using something more targeted so you can ensure the correct
ordering.
If you kill the portmapper before the nfs/lockd daemons have finished
unregistering their services then the above behaviour is completely
normal.

Cheers,
  Trond
