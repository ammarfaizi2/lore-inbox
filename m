Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUIIU57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUIIU57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUIIU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:57:48 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:59630 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S266204AbUIIU4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:56:54 -0400
Date: Thu, 9 Sep 2004 22:55:31 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909205531.GA17088@k3.hellgate.ch>
Mail-Followup-To: Stephen Smalley <sds@epoch.ncsc.mil>,
	William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
	James Morris <jmorris@redhat.com>, Chris Wright <chrisw@osdl.org>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com> <20040909175342.GA27518@k3.hellgate.ch> <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094760065.22014.328.camel@moss-spartans.epoch.ncsc.mil>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 16:01:06 -0400, Stephen Smalley wrote:
> > For the same reason, I'm not comfortable with implementing SELinux type
> > access controls myself. How about:
> > 
> > config NPROC
> > 	depends on !SECURITY_SELINUX
> > 
> > Adding access control later won't be a problem for anyone who groks
> > SELinux.
> 
[...]
> Most obvious place to hook would be nproc_ps_get_task; we could then
> perform a check based on the sender's credentials and the target task's
> credentials, and simply return NULL if permission is not granted for
> that pair, thus skipping that task as if it didn't exist.  That requires
> propagating the sender's credentials down to that function.
> 
> Untested patch below.

I used a somewhat different approach in my development tree (not
SELinuxy, though): Most fields were world readable, some required
credentials.

I don't have any strong feelings on access control, so I'd be happy
with any mechanism that doesn't completely botch performance. Anyway,
I do not consider lack of access controls to be a showstopper.

Roger
