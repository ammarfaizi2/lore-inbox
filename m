Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbTKZXnq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264387AbTKZXnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:43:45 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:60103 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S264384AbTKZXmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:42:55 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Fredrik Tolf <fredrik@dolda2000.com>
Date: Thu, 27 Nov 2003 10:42:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16325.14967.248703.483363@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 nfsd troubles - stale filehandles
In-Reply-To: message from Fredrik Tolf on Wednesday November 26
References: <16325.11418.646482.223946@pc7.dolda2000.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday November 26, fredrik@dolda2000.com wrote:
> Hi!
> 
> I'm running my NFSv3 server at home on a 2.6 kernel, and it seems to
> have some issues, to say the least. The clients sporadically get stale
> handle errors, and I don't really know how to debug it.

I'll see if I can help.

I suspect that if you add the "no_subtree_check" export option the
problem will go away.  If you could confirm that, and then set it back
to "subtree_check" so we can keep hunting, that would be good.

Next, some better tracing.
The Linux NFS client will never re-try a filehandle that it thinks is
stale, so the tracing you did doesn't actually show any access of the stale
filehandle. 
So you need to have tracing on when the filehandle goes stale.

If you could:

  echo 2 >  /proc/sys/sunrpc/nfsd_debug 

and then try to create a stale file/directory, then the trace produced
by that could well be helpful.

Finally, when you have create a stale filehandle and got a good trace,
could you send it to me and include an
   ls -l
for the bad file/directory and every parent up to the export point.

Thanks,
NeilBrown
