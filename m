Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272627AbRIGMg1>; Fri, 7 Sep 2001 08:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272628AbRIGMgR>; Fri, 7 Sep 2001 08:36:17 -0400
Received: from mons.uio.no ([129.240.130.14]:27102 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S272627AbRIGMgK>;
	Fri, 7 Sep 2001 08:36:10 -0400
MIME-Version: 1.0
Message-ID: <15256.48964.101213.439253@charged.uio.no>
Date: Fri, 7 Sep 2001 14:36:20 +0200
To: ptb@it.uc3m.es
Cc: Mike Black <mblack@csihq.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.8 NFS Problems
In-Reply-To: <200109071206.OAA24577@nbd.it.uc3m.es>
In-Reply-To: <shsae07md9d.fsf@charged.uio.no>
	<200109071206.OAA24577@nbd.it.uc3m.es>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Peter T Breuer <ptb@it.uc3m.es> writes:

    >> Soft mount timeouts are not only due to network problems, but
    >> can equally well be due to internal congestion. The rate at
    >> which the network can transmit requests is usually (unless you
    >> are using Gigabit) way below the rate at which your machine can
    >> generate them.

     > But soft mounts at least break nicely and automatically.  And
     > since failures are inevitable, I prefer them.

The problem is that they need careful tuning if they are to work at
all. They assume a perfect setup.

For instance most servers will drop UDP requests if they don't have a
free thread to serve them. They assume that you will automatically
retry. soft mounts do retry, but give up eventually. IOW even on an
otherwise working setup you will, every once in a blue moon, get an
EIO due to a soft timeout and you will lose data.

Cheers,
  Trond
