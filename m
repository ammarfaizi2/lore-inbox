Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266616AbUIISZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266616AbUIISZR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 14:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUIISXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 14:23:00 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:36557 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S266391AbUIISCa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 14:02:30 -0400
Date: Thu, 9 Sep 2004 19:53:42 +0200
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909175342.GA27518@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil> <20040909172200.GX3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909172200.GX3106@holomorphy.com>
X-Operating-System: Linux 2.6.9-rc1-bk13 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Sep 2004 10:22:00 -0700, William Lee Irwin III wrote:
> On Thu, Sep 09, 2004 at 07:53:31AM -0400, Stephen Smalley wrote:
> > They aren't world readable when using a security module like SELinux;
> > they are then typically only accessible by processes in the same
> > security domain, aside from processes in privileged domains. 
> > security_task_to_inode() hook sets the security attributes on the
> > /proc/pid inodes based on their security context, and then
> > security_inode_permission() hook controls access to them.  So you need
> > at least comparable controls.
> 
> Can you make a more specific suggestion regarding the controls to use?
> It's a bit awkward for those highly unfamiliar with the subsystem to

For the same reason, I'm not comfortable with implementing SELinux type
access controls myself. How about:

config NPROC
	depends on !SECURITY_SELINUX

Adding access control later won't be a problem for anyone who groks
SELinux.

Roger
