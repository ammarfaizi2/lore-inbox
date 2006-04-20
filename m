Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWDTPPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWDTPPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 11:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWDTPPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 11:15:49 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:64188 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1750987AbWDTPPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 11:15:47 -0400
Subject: Re: Removing EXPORT_SYMBOL(security_ops) (was Re: Time to remove
	LSM)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Greg KH <greg@kroah.com>
Cc: tonyj@suse.de, James Morris <jmorris@namei.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060420150037.GA30353@kroah.com>
References: <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	 <20060419154011.GA26635@kroah.com>
	 <Pine.LNX.4.64.0604191221100.4408@d.namei>
	 <20060419181015.GC11091@kroah.com>
	 <1145536791.16456.37.camel@moss-spartans.epoch.ncsc.mil>
	 <20060420150037.GA30353@kroah.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 20 Apr 2006 10:20:11 -0400
Message-Id: <1145542811.3313.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-20 at 08:00 -0700, Greg KH wrote:
> I agree.  In looking over the code some more, I'm trying to figure out
> why we are exporting that variable at all.  Is it because of people
> wanting to stack security modules?
> 
> I see selinux code using it, but you are always built into the kernel,
> right?  So unexporting it would not be an issue to you.

Various in-tree modules (e.g. ext3) call security hooks via the static
inlines and end up referencing security_ops directly.  We'd have to wrap
all such hooks in the same manner as capable and permission.

Although I was actually talking about eliminating security_ops, not just
un-exporting it ;)

> Tony, would AppArmor have problems if we don't export that variable
> anymore?

-- 
Stephen Smalley
National Security Agency

