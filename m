Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310399AbSCLEAE>; Mon, 11 Mar 2002 23:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310387AbSCLD7y>; Mon, 11 Mar 2002 22:59:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:20816 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310389AbSCLD7s>; Mon, 11 Mar 2002 22:59:48 -0500
Date: Tue, 12 Mar 2002 05:01:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: oskar@osk.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020312050104.V10413@dualathlon.random>
In-Reply-To: <20020310210802.GA1695@oskar> <20020311112652.E10413@dualathlon.random> <20020312120452.3038c4bc.sfr@canb.auug.org.au> <20020312022046.R10413@dualathlon.random> <20020312135949.3be7d9ca.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312135949.3be7d9ca.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 01:59:49PM +1100, Stephen Rothwell wrote:
> My patch makes directory notifiers per thread group instead of per process
> tree (which they are now).

I overlooked that in your patch you changed the index for the lookup, so
yes, that looks a better fix.

> This would be equivalent to returning -EPERM if you tried to remove a
> lock on a file when you didn't set it ...

Lock are standard and we cannot change such API, but for a fairly new
API I'd prefer strict stuff. Anyways now -EPERM would be wrong and the
need of the errorback is also lower because there's no risk of
collisions anymore, now different current->files will be able to get
different notifiers, so if something it should be a -ENOENT, it's not a
matter of permissions/ownership anymore.

Andrea
