Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263224AbTJPXod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 19:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263238AbTJPXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 19:44:33 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:504 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263224AbTJPXob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 19:44:31 -0400
Date: Thu, 16 Oct 2003 17:42:28 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016174227.K7000@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Eli Billauer <eli_billauer@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com> <20031016121825.D7000@schatzie.adilger.int> <3F8F26F0.6080002@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F8F26F0.6080002@pobox.com>; from jgarzik@pobox.com on Thu, Oct 16, 2003 at 07:17:04PM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2003  19:17 -0400, Jeff Garzik wrote:
> Andreas Dilger wrote:
> > It isn't a matter of unbreakable crypto, but the fact that we want
> > relatively unique values that will not be the same on a reboot.  Currently
> > we do just as you propose for our "crappy PRNG", which is "grab 8 bytes
> > via get_random_bytes and increment", but that is a little _too_ easy to
> > guess (although good enough for the time being).
> 
> If you care at all about it being easy to guess, then why bother with 
> the crappy PRNG?  :)
> 
> If you _don't_ care about the numbers being easy to guess -- i.e. you 
> simply want unique values -- then it doesn't seem like a PRNG is needed 
> at all.  With a random number you have to deal with collisions between 
> nodes choosing the same number coincidentally _anyway_, so why not just 
> use sequence numbers?

For the current version of Lustre security is not a primary concern (our
customers run Lustre in very secure network environments).  We started
with get_random_bytes() but had to remove it because of the overhead.
Note that the random numbers are produced and consumed local to a single
node but are passed over the network to clients as an opaque handle,
so cross-node collisions are not a concern.

At some point in the future we may need to increase the security of such
handles, but it would be nice to not increase the CPU usage as much as
get_random_bytes() did.  Direct HW RNG would suit this perfectly.

Note that the security of these handles isn't really that critical to
the overall security model when implemented (which will be kerberos based
like AFS and DCE), but it would be nice from a warm-n-fuzzy point of view
to have something better than "last handle + N" which is what we have now.

In any case, this is getting off topic for l-k now so we should probably
end the discussion here.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

