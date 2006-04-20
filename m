Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWDTQXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWDTQXx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWDTQXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 12:23:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47833 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751057AbWDTQXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 12:23:52 -0400
Date: Thu, 20 Apr 2006 17:23:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, tonyj@suse.de,
       James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove LSM)
Message-ID: <20060420162309.GA18726@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, Stephen Smalley <sds@tycho.nsa.gov>,
	tonyj@suse.de, James Morris <jmorris@namei.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Andrew Morton <akpm@osdl.org>, T?r?k Edwin <edwin@gurde.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Wright <chrisw@sous-sol.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <20060419154011.GA26635@kroah.com> <Pine.LNX.4.64.0604191221100.4408@d.namei> <20060419181015.GC11091@kroah.com> <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil> <20060420150037.GA30353@kroah.com> <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil> <20060420161552.GA1990@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060420161552.GA1990@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 09:15:52AM -0700, Greg KH wrote:
> On Thu, Apr 20, 2006 at 10:20:11AM -0400, Stephen Smalley wrote:
> > On Thu, 2006-04-20 at 08:00 -0700, Greg KH wrote:
> > > I agree.  In looking over the code some more, I'm trying to figure out
> > > why we are exporting that variable at all.  Is it because of people
> > > wanting to stack security modules?
> > > 
> > > I see selinux code using it, but you are always built into the kernel,
> > > right?  So unexporting it would not be an issue to you.
> > 
> > Various in-tree modules (e.g. ext3) call security hooks via the static
> > inlines and end up referencing security_ops directly.  We'd have to wrap
> > all such hooks in the same manner as capable and permission.
> 
> Ah, and people like making their file systems as modules :(

But actually yes, calling into rændom lsm hooks in modules is not a good
thing.a  The only think filesystems calls is security_inode_init_security
and it would make a lot of sense to make that an out of line wrapper
instead of exporting security_ops.
