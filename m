Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWDTQbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWDTQbE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWDTQbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:31:04 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:64461 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750730AbWDTQbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:31:01 -0400
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove
	LSM)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg KH <greg@kroah.com>, tonyj@suse.de, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060420162309.GA18726@infradead.org>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <20060419154011.GA26635@kroah.com>
	 <Pine.LNX.4.64.0604191221100.4408@d.namei>
	 <20060419181015.GC11091@kroah.com>
	 <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420150037.GA30353@kroah.com>
	 <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420161552.GA1990@kroah.com>  <20060420162309.GA18726@infradead.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 12:34:57 -0400
Message-Id: <1145550897.3313.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 17:23 +0100, Christoph Hellwig wrote:
> On Thu, Apr 20, 2006 at 09:15:52AM -0700, Greg KH wrote:
> > On Thu, Apr 20, 2006 at 10:20:11AM -0400, Stephen Smalley wrote:
> > > On Thu, 2006-04-20 at 08:00 -0700, Greg KH wrote:
> > > > I agree.  In looking over the code some more, I'm trying to figure out
> > > > why we are exporting that variable at all.  Is it because of people
> > > > wanting to stack security modules?
> > > > 
> > > > I see selinux code using it, but you are always built into the kernel,
> > > > right?  So unexporting it would not be an issue to you.
> > > 
> > > Various in-tree modules (e.g. ext3) call security hooks via the static
> > > inlines and end up referencing security_ops directly.  We'd have to wrap
> > > all such hooks in the same manner as capable and permission.
> > 
> > Ah, and people like making their file systems as modules :(
> 
> But actually yes, calling into rndom lsm hooks in modules is not a good
> thing.a  The only think filesystems calls is security_inode_init_security
> and it would make a lot of sense to make that an out of line wrapper
> instead of exporting security_ops.

There are other cases as well, I think, e.g. af_unix calls certain hooks
to ensure mediation of even the abstract namespace.  But the problem is
avoided altogether if the security static inlines compile down to direct
selinux function calls (which can be exported as needed).

-- 
Stephen Smalley
National Security Agency

