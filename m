Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbVCPAFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbVCPAFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 19:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbVCPAD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 19:03:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:14272 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262126AbVCOX7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 18:59:25 -0500
Date: Tue, 15 Mar 2005 15:58:51 -0800
From: Chris Wright <chrisw@osdl.org>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rmk+lkml@arm.linux.org.uk
Subject: Re: Capabilities across execve
Message-ID: <20050315235851.GF5389@shell0.pdx.osdl.net>
References: <1110627748.2376.6.camel@boxen> <20050313032117.GA28536@shell0.pdx.osdl.net> <20050315215719.A12283@flint.arm.linux.org.uk> <20050315224219.GA5389@shell0.pdx.osdl.net> <1110930112.1210.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110930112.1210.44.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg (alexn@dsv.su.se) wrote:
> tis 2005-03-15 klockan 14:42 -0800 skrev Chris Wright:
> > It was meant to work with capabilities in the filesystem like setuid bits.
> > So the patches that have floated around from myself, Andy Lutomirski
> > and Alex Nyberg are attempts to make something half-way sane out of the
> > mess.  The trouble is then convincing yourself that it's not some way to
> > leak capabilities (esp. since some programs use the interface already,
> > like bind9).
> 
> Anyone who uses the current interfaces should not play with the
> inheritable flag, the text I looked at said it was specifically for
> execve. Thus if the application doesn't modify the inheritable mask
> things will look like it has always done. And it really should not mess
> with inheritable mask if it doesn't intend to, that would be a security
> bug.
> We really should be safe doing this.

That's one of the points.  Latent bugs getting triggered is what makes
the change deserving of being conservative.

> > All I can say is work is underway.  There's 3 different patches that
> > will get you to your goal.  I understand that it's a real pain right now.
> > One of the authors of the withdrawn draft has told me that the notion of
> > capabilities w/out filesystem support was considered effectively useless.
> > So, we're in uncharted territory.  BTW, thanks for reminding me of
> > scripts, I had been testing just C programs.
> 
> I wouldn't call it useless, retaining capabilities across execve +
> pam_cap is a very useful thing, on my machine I can give myself a few
> capabilities that have always annoyed me (iirc the database that wanted
> mlock as regular user would have been solved aswell).

Yes, that's useful, but having 3 sets and complicated rules for
combining task and file based sets is not really necessary for that.

> Regarding fs attributes:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0211.0/0171.html
> 
> I can see useful scenarios of having the possiblity of capabilities per
> inode (it appears the xattr way wins somewhat in the previous
> discussion).

It's how it should be done.

> Chris, have you seen any capabilities+xattr patches around?

http://www.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4-fcap/

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
