Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbRBHIWn>; Thu, 8 Feb 2001 03:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129164AbRBHIWd>; Thu, 8 Feb 2001 03:22:33 -0500
Received: from adsl-63-205-85-133.dsl.snfc21.pacbell.net ([63.205.85.133]:26128
	"EHLO schmee.sfgoth.com") by vger.kernel.org with ESMTP
	id <S129033AbRBHIWS>; Thu, 8 Feb 2001 03:22:18 -0500
Date: Thu, 8 Feb 2001 00:22:12 -0800
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: "David S. Miller" <davem@redhat.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
        linux-kernel@vger.kernel.org
Subject: Re: dentry cache order 7 is broken
Message-ID: <20010208002212.Q12227@sfgoth.com>
In-Reply-To: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org> <14978.21605.98365.252519@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <14978.21605.98365.252519@pizda.ninka.net>; from davem@redhat.com on Thu, Feb 08, 2001 at 12:10:13AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> -	hash = hash ^ (hash >> D_HASHBITS) ^ (hash >> D_HASHBITS*2);
> +	hash = hash ^ (hash >> D_HASHBITS) ^
> +		(hash >> (D_HASHBITS+(D_HASHBITS/2)));

Two comments:
  1. The inode-cache has the exact same problem, but it'll require a lot
     of RAM to run into it.  The buffer and page caches don't have the
     same problem.
  2. Given that D_HASHBITS is not a constant I wonder if there isn't
     a more efficient hash to be found.  But I guess I'll leave that
     to the hashing experts.

-Mitch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
