Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUHFCNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUHFCNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265490AbUHFCNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:13:07 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:33176 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S268057AbUHFCJb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:09:31 -0400
Date: Thu, 5 Aug 2004 21:09:30 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806020930.GA23072@hexapodia.org>
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805223319.GA18155@logos.cnet>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:33:19PM -0300, Marcelo Tosatti wrote:
> On Thu, Aug 05, 2004 at 01:46:15PM -0700, William Lee Irwin III wrote:
> > > the problem does not exist using 2.6.6-bk6, but exists on 2.6.6-bk7. 
> > > -bk8 and -bk9 faile to build.
> > > these are from patches-2.6.6-bk6 off snapshots/old and applied to a 
> > > vanilla 2.6.6 kernel.
> > 
> > This is the closest it appears to be possible to narrow down where the
> > regression happened.
> > 
> > Some form of changelogging to enumerate what the contents of the
> > 2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
> > between 2.6.6-bk6 and 2.6.6-bk7 is needed.

If you're willing to use bk, it's trivial.  Each changeset refers to a
particular state of the tree.  If "bk -r check -acv" reports no errors,
and "bk changes -r+ -d:KEY:" reports a particular key, you are
guaranteed that your tree state matches exactly the state of anyone else
who has that key at any point in the past. [1]

So if the -bkX creation script doesn't already, it should "bk changes
-r+ -d:KEY: > key-bk$X" when it creates the tarball.  Then anyone can
"bk clone -r`cat key-bk7` linux-2.5 linux-2.6-bk7" and duplicate the
-bk7 state of the tree, and then "bk changes -L ../linux-2.6-bk6" to
find the list of changesets differing.

> Indeed its nasty, the problem is there is no tagging in the main BK repository
> representing the -bk tree's. It shouldnt be too hard to do something about 
> this? I can't think of anything which could help...

Tagging isn't the answer for snapshots.  Rather, the snapshot metadata
needs to include the cset key at the snapshot instant.

[1] well, caveat -- bk isn't cryptographically secure, so probably a
    motivated attacker could construct a tree which would pass this test
    but have different contents.  This wouldn't allow the attacker to
    push invalid contents to other trees, just to have different
    contents in their tree.

-andy
