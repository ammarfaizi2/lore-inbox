Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312575AbSCVAUd>; Thu, 21 Mar 2002 19:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312574AbSCVAUZ>; Thu, 21 Mar 2002 19:20:25 -0500
Received: from pat.uio.no ([129.240.130.16]:30131 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S312573AbSCVAUL>;
	Thu, 21 Mar 2002 19:20:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15514.30892.392730.325607@charged.uio.no>
Date: Fri, 22 Mar 2002 01:19:56 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Oleg Drokin <green@namesys.com>, sneakums@zork.net,
        linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <20020321154500.117e8acc.skraw@ithnet.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > Trond: can you please tell me in short, what the common case
     > (or your guess) is why I see this stale file handles on the
     > client side. I am going to try and find out myself what the
     > problem with reiserfs is here, it gets a bit on my nerves
     > now. Do you suspect the fs to drop some inodes under the
     > nfs-server?

Hold on thar: are you using nfs-server (a.k.a. unfsd) or are you using
knfsd?

The client will only return ESTALE if the server has first told it to
do so. For knfsd, this is only supposed to occur if the file has
actually been deleted on the server (knfsd is supposed to be able to
retrieve ReiserFS file that have fallen out of cache).
For unfsd, the 'falling out of cache' business might indeed be a
problem...

Cheers,
  Trond
