Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTK0Ntv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTK0Ntv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:49:51 -0500
Received: from as6-4-8.rny.s.bonet.se ([217.215.27.171]:14856 "EHLO
	pc2.dolda2000.com") by vger.kernel.org with ESMTP id S264522AbTK0Ntt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:49:49 -0500
From: Fredrik Tolf <fredrik@dolda2000.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16326.253.163939.9953@pc7.dolda2000.com>
Date: Thu, 27 Nov 2003 14:49:49 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 nfsd troubles - stale filehandles
In-Reply-To: <16325.14967.248703.483363@notabene.cse.unsw.edu.au>
References: <16325.11418.646482.223946@pc7.dolda2000.com>
	<16325.14967.248703.483363@notabene.cse.unsw.edu.au>
X-Mailer: VM 7.17 under Emacs 21.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown writes:
 > On Wednesday November 26, fredrik@dolda2000.com wrote:
 > > Hi!
 > > 
 > > I'm running my NFSv3 server at home on a 2.6 kernel, and it seems to
 > > have some issues, to say the least. The clients sporadically get stale
 > > handle errors, and I don't really know how to debug it.
 > 
 > I'll see if I can help.
 > 
 > I suspect that if you add the "no_subtree_check" export option the
 > problem will go away.  If you could confirm that, and then set it back
 > to "subtree_check" so we can keep hunting, that would be good.

That actually does seem to have done the job. I thought subtree_check
only affected exports that aren't entire filesystems, but I guess it
does something to the filehandles anyway. Thank you, at least now I
have something to fall back upon if no other solution presents itself.

 > Next, some better tracing.
 > The Linux NFS client will never re-try a filehandle that it thinks is
 > stale, so the tracing you did doesn't actually show any access of the stale
 > filehandle. 

I see... I thought it would try to get a new filehandle to the same
file somehow.

 > So you need to have tracing on when the filehandle goes stale.
 > 
 > If you could:
 > 
 >   echo 2 >  /proc/sys/sunrpc/nfsd_debug 
 > 
 > and then try to create a stale file/directory, then the trace produced
 > by that could well be helpful.
 > 
 > Finally, when you have create a stale filehandle and got a good trace,
 > could you send it to me and include an
 >    ls -l
 > for the bad file/directory and every parent up to the export point.

I'll do my best, but I don't know how long it will take me. It is
extremely hard to predict when it will happen, so tracing the actual
fault won't be easy.

I'll post again when (and if) I manage to get a good trace.

Fredrik Tolf

