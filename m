Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266200AbUIIVUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266200AbUIIVUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIIVUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:20:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:24795 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266200AbUIIVFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:05:36 -0400
Date: Thu, 9 Sep 2004 14:05:11 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
       William Lee Irwin III <wli@holomorphy.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909140511.D1924@build.pdx.osdl.net>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil> <20040909205531.GA17088@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040909205531.GA17088@k3.hellgate.ch>; from rl@hellgate.ch on Thu, Sep 09, 2004 at 10:55:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Luethi (rl@hellgate.ch) wrote:
> On Thu, 09 Sep 2004 16:01:06 -0400, Stephen Smalley wrote:
> > > For the same reason, I'm not comfortable with implementing SELinux type
> > > access controls myself. How about:
> > > 
> > > config NPROC
> > > 	depends on !SECURITY_SELINUX
> > > 
> > > Adding access control later won't be a problem for anyone who groks
> > > SELinux.
> > 
> [...]
> > Most obvious place to hook would be nproc_ps_get_task; we could then
> > perform a check based on the sender's credentials and the target task's
> > credentials, and simply return NULL if permission is not granted for
> > that pair, thus skipping that task as if it didn't exist.  That requires
> > propagating the sender's credentials down to that function.
> > 
> > Untested patch below.
> 
> I used a somewhat different approach in my development tree (not
> SELinuxy, though): Most fields were world readable, some required
> credentials.
> 
> I don't have any strong feelings on access control, so I'd be happy
> with any mechanism that doesn't completely botch performance. Anyway,
> I do not consider lack of access controls to be a showstopper.

Some of these things become quite sensitive, esp across setuid, etc.
For prototyping, I agree, not a showstopper.  For merging, it should be
figured out properly.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
