Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278265AbRJSBKk>; Thu, 18 Oct 2001 21:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278263AbRJSBKb>; Thu, 18 Oct 2001 21:10:31 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21145 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S278261AbRJSBK0>; Thu, 18 Oct 2001 21:10:26 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Tim Walberg <twalberg@mindspring.com>
Date: Fri, 19 Oct 2001 11:07:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15311.31962.850647.50079@notabene.cse.unsw.edu.au>
Cc: James Sutherland <jas88@cam.ac.uk>, Ben Greear <greearb@candelatech.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: RFC - tree quotas for Linux (2.4.12, ext2)
In-Reply-To: message from Tim Walberg on Thursday October 18
In-Reply-To: <3BCE6E6E.3DD3C2D6@candelatech.com>
	<Pine.SOL.4.33.0110180937420.13081-100000@yellow.csi.cam.ac.uk>
	<20011018132035.A444@mikef-linux.matchmail.com>
	<20011018154709.E29662@mindspring.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday October 18, twalberg@mindspring.com wrote:
> A semi-random thought on the tree-quota concept:
> 
> Does it really make sense to charge a tree quota to a single specific
> user? I haven't really looked into what would be required to implement
> it, but my mental picture of a tree quota is somewhat divorced from the
> user concept, other than maybe the quota table containing a pointer to
> a contact for quota violations. The bookkeeping might be easier if each
> tree quota root just held a cumulative total of allocated space, and
> maybe a just a user name for contacts (or on the fancier side, a hook
> to execute something...).

My original thought was that the "Treeid" in each inode would be the
inode number of the root of the quota-tree.  That would work and allow
treequotas to use a separate number space.

However I actually want to charge usage to users.
There is a natural mapping from users to directory trees via the
concept of the home-directory.  It is home directories that I want to
impose quotas on.  So it seems natural to charge space usage to a
users.

Certainly there are entities that need space allocation that are not
users in the traditional sense of the word.  Groups (as in collections
of people, not necessarily as in unix groups) is an obvious example.

So instead of "users", lets call them "accounts".  
Each account has
   a name
   a home directory
   a space quota

Some also have passwords and shells that allow people to log into
them.
(Each account also has an expiry date, a printer allocation, an
internet-usage allocation .... but thats another story).

So for me, quotas are not at all divorced from the "Account" concept.

The idea of keeping the cumulative total of usage in the root of the
quota tree is appealing, but is frustrated by hard links.  Though we
can try to avoid them, they will happen and there has to be a clear
way to handle them.  Recording with each inode the information about
who is charged for that inode is the simplest by far.

Or possibly you meant that each directory should contain the
cumulative sum of usage beneath it.. Even if that were well defined,
it would be a performance problem updating lots of directory inode for
each change.

NeilBrown

> 
> I know it's kinda half-baked, but that's my $0.015...
> 
> 				tw
> 
> On 10/18/2001 13:20 -0700, Mike Fedyk wrote:
> >>	Actually, it looks like Niel is creating a two level Quota system.  In ther
> >>	normal quota system, if you own a file anywhere, it is attributed to you.
> >>	But, in the tree quota system, it is attributed to the owner of the tree...
> >>	
> >>	Niel, how do you plan to notify someone that their tree quota has been
> >>	exceeded instead of their normal quota?
> >>	-
> >>	To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >>	the body of a message to majordomo@vger.kernel.org
> >>	More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>	Please read the FAQ at  http://www.tux.org/lkml/
> End of included message
> 
> 
> 
> -- 
> twalberg@mindspring.com
