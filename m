Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291969AbSBAUWe>; Fri, 1 Feb 2002 15:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291968AbSBAUWN>; Fri, 1 Feb 2002 15:22:13 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:25311 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S291966AbSBAUWL>; Fri, 1 Feb 2002 15:22:11 -0500
Date: Fri, 1 Feb 2002 14:22:10 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Continuing /dev/random problems with 2.4
Message-ID: <20020201142210.E8599@asooo.flowerfire.com>
In-Reply-To: <20020201031744.A32127@asooo.flowerfire.com> <1012582401.813.1.camel@phantasy> <a3enf3$93p$1@cesium.transmeta.com> <20020201133833.B8599@asooo.flowerfire.com> <20020201125703.H763@lynx.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201125703.H763@lynx.adilger.int>; from adilger@turbolabs.com on Fri, Feb 01, 2002 at 12:57:03PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:57:03PM -0700, Andreas Dilger wrote:
| Hmm, you may also need to delete /dev/urandom too.  Reading from
| /dev/urandom will also deplete the entropy pool just as much as
| reading from /dev/random.  The only difference is that /dev/random
| will block if there aren't enough bits as requested, while reads
| from /dev/urandom will happily continue to return data which isn't
| "backed" by any entropy.

*forehead smack*  Very good point.

| You could also enable debugging in drivers/char/random.c to see what
| is going on (it may be very verbose).  You could even change the one
| message in extract_entropy() to include the command name, like:
| 
| 	DEBUG_ENT("%s has %d bits, %s wants %d bits\n",
| 		  r == sec_random_state ? "secondary" :
| 		  r == random_state ? "primary" : "unknown",
| 		  current->comm, r->entropy_bits, nbytes * 8);
|
| (not sure of exact usage for current->comm, but you could use ->pid
| instead).

I'll add this and see what pops up, thanks!

| Note that even traffic over the network will deplete your entropy
| pool, because it is using secure_tcp_sequence_number() and secure_ip_id().
| Also, using SYN cookies appears to increase the amount of entropy used.

Very good to know.  The machines that this has happened on don't all
have tcp_syncookies enabled, and some have very little network traffic,
so at first glance those don't seem to be involved.

Thanks,
-- 
Ken.
brownfld@irridia.com

| 
| Cheers, Andreas
| --
| Andreas Dilger
| http://sourceforge.net/projects/ext2resize/
| http://www-mddsp.enel.ucalgary.ca/People/adilger/
