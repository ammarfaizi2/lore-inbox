Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267446AbUHFC1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267446AbUHFC1n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUHFC1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:27:43 -0400
Received: from holomorphy.com ([207.189.100.168]:48583 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267446AbUHFC1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:27:41 -0400
Date: Thu, 5 Aug 2004 19:27:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806022734.GN17188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andy Isaacson <adi@hexapodia.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	"Mr. Berkley Shands" <berkley@cse.wustl.edu>,
	linux-kernel@vger.kernel.org
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet> <20040806020930.GA23072@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806020930.GA23072@hexapodia.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>>> Some form of changelogging to enumerate what the contents of the
>>> 2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
>>> between 2.6.6-bk6 and 2.6.6-bk7 is needed.

On Thu, Aug 05, 2004 at 09:09:30PM -0500, Andy Isaacson wrote:
> If you're willing to use bk, it's trivial.  Each changeset refers to a
> particular state of the tree.  If "bk -r check -acv" reports no errors,
> and "bk changes -r+ -d:KEY:" reports a particular key, you are
> guaranteed that your tree state matches exactly the state of anyone else
> who has that key at any point in the past. [1]
> So if the -bkX creation script doesn't already, it should "bk changes
> -r+ -d:KEY: > key-bk$X" when it creates the tarball.  Then anyone can
> "bk clone -r`cat key-bk7` linux-2.5 linux-2.6-bk7" and duplicate the
> -bk7 state of the tree, and then "bk changes -L ../linux-2.6-bk6" to
> find the list of changesets differing.

Once we get there, there must be some way to construct intermediate
points between those two faithful at the very least to the snapshot
ordering if not true chronological ordering.


On Thu, Aug 05, 2004 at 07:33:19PM -0300, Marcelo Tosatti wrote:
>> Indeed its nasty, the problem is there is no tagging in the main BK
>> repository representing the -bk tree's. It shouldnt be too hard to
>> do something about this? I can't think of anything which could help...

On Thu, Aug 05, 2004 at 09:09:30PM -0500, Andy Isaacson wrote:
> Tagging isn't the answer for snapshots.  Rather, the snapshot metadata
> needs to include the cset key at the snapshot instant.
> [1] well, caveat -- bk isn't cryptographically secure, so probably a
>     motivated attacker could construct a tree which would pass this test
>     but have different contents.  This wouldn't allow the attacker to
>     push invalid contents to other trees, just to have different
>     contents in their tree.

Yes, this would be very helpful.


-- wli
