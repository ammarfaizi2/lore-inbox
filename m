Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268092AbUHFCpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268092AbUHFCpQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268097AbUHFCow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:44:52 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:19828 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S268063AbUHFCmX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:42:23 -0400
Date: Thu, 5 Aug 2004 21:42:21 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: William Lee Irwin III <wli@holomorphy.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       "Mr. Berkley Shands" <berkley@cse.wustl.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
Message-ID: <20040806024221.GA19333@hexapodia.org>
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com> <4112917A.3080003@cse.wustl.edu> <20040805204615.GJ17188@holomorphy.com> <20040805223319.GA18155@logos.cnet> <20040806020930.GA23072@hexapodia.org> <20040806022734.GN17188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806022734.GN17188@holomorphy.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 07:27:34PM -0700, William Lee Irwin III wrote:
> At some point in the past, I wrote:
> >>> Some form of changelogging to enumerate what the contents of the
> >>> 2.6.6-bk6 -> 2.6.6-bk7 delta are and to reconstruct intermediate points
> >>> between 2.6.6-bk6 and 2.6.6-bk7 is needed.
> 
> On Thu, Aug 05, 2004 at 09:09:30PM -0500, Andy Isaacson wrote:
> > So if the -bkX creation script doesn't already, it should "bk changes
> > -r+ -d:KEY: > key-bk$X" when it creates the tarball.  Then anyone can
> > "bk clone -r`cat key-bk7` linux-2.5 linux-2.6-bk7" and duplicate the
> > -bk7 state of the tree, and then "bk changes -L ../linux-2.6-bk6" to
> > find the list of changesets differing.
> 
> Once we get there, there must be some way to construct intermediate
> points between those two faithful at the very least to the snapshot
> ordering if not true chronological ordering.

Well, the state of the "central tree" is represented by a cset key at
each point.  So the answer to your question is a list of keys.  But the
keys in question aren't "special" in any bk sense; they're just some
keys.  You can keep track of keys outside of BK if you want, to keep a
history of "state of this tree at time X", but BK can't keep track of
that info.

Anyways, maybe an example is in order.

% bk prs -hnd:KEY: -rv2.5.4-pre6..v2.5.4 ChangeSet
torvalds@home.transmeta.com|ChangeSet|20020211032403|18448
torvalds@home.transmeta.com|ChangeSet|20020211014924|18455
torvalds@home.transmeta.com|ChangeSet|20020211013331|26396
paulus@quango.(none)|ChangeSet|20020211005601|64956
davej@suse.de|ChangeSet|20020211004458|26395
rml@tech9.net|ChangeSet|20020210234603|34727
kai@vaio.(none)|ChangeSet|20020210234057|58664
gkernel.adm@hostme.bitkeeper.com|ChangeSet|20020210215119|34443
rml@tech9.net|ChangeSet|20020210205932|34726

Those are the changesets that are present in 2.5.4 that aren't present
in 2.5.4-pre6 (note how I used tag..tag in the -r option.)  Similarly,
you can do
-r'rml@tech9.net|ChangeSet|20020210205932|34726..davej@suse.de|ChangeSet|20020211004458|26395'
(that is, "key1..key2") to find the keys implied by key2 and not implied
by key1.  (Read "bk help set" for even more sophisticated options.)

Pick the interesting csets and do a binary search...  (Or better, write
a script to do it!)

-andy
