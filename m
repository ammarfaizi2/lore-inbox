Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVGQBd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVGQBd7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 21:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVGQBd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 21:33:57 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:44451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261650AbVGQBcx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 21:32:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=XtXQK/rraRk7gMJr9s4n7gBLEK8nmVk9J7r7FqRa6Z6z/+f8D1rKJ3Gl9l29SlDN1BV0R50LzBgEuylOyvFOitLGZV39S9bVtCwyWLKWDDHR1RvJVxyjn6og01z8Qg157TxDwOxfP8CHIel3lEWjx9TMAYT91K2riH7owyPQspI=
Date: Sat, 16 Jul 2005 21:32:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm1
Message-ID: <20050717013248.GA10673@nineveh.rivenstone.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050715013653.36006990.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050715013653.36006990.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2005 at 01:36:53AM -0700, Andrew Morton wrote:
> 
 ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc3/2.6.13-rc3-mm1/
 
> +suspend-update-documentation.patch
> +swsusp-fix-printks-and-cleanups.patch
> +swsusp-fix-remaining-u32-vs-pm_message_t-confusion.patch
> +swsusp-switch-pm_message_t-to-struct.patch
> +swsusp-switch-pm_message_t-to-struct-pmac_zilog-fix.patch
> +swsusp-switch-pm_message_t-to-struct-ppc32-fixes.patch
> +fix-pm_message_t-stuff-in-mm-tree-netdev.patch

    I'm getting this (on ppc32, though I don't think it matters):

  CC      drivers/video/chipsfb.o
drivers/video/chipsfb.c: In function `chipsfb_pci_suspend':
drivers/video/chipsfb.c:465: error: invalid operands to binary ==
drivers/video/chipsfb.c:467: error: invalid operands to binary !=
make[3]: *** [drivers/video/chipsfb.o] Error 1
make[2]: *** [drivers/video] Error 2
make[1]: *** [drivers] Error 2
make[1]: Leaving directory
`/usr/src/linux-ctesiphon/linux-2.6.13-rc3-mm1'
make: *** [stamp-build] Error 2

    The above-quoted patches seem to be the culprit, but my feeble
attempts at making a patch didn't work out.

    While I'm complaining:

> Q: Why we cannot suspend to a swap file?

> A: Because accessing swap file needs the filesystem mounted, and
> filesystem might do something wrong (like replaying the journal)
> during mount. [Probably could be solved by modifying every filesystem
> to support some kind of "really read-only!" option. Patches welcome.]

    I seem to recall that swsusp2 can do this.

    I don't hold out much hope that suspend will ever work on my
laptop, with its i815 video chipset, at least not from X (and then
there's no point).  The i81x and the linux video architecture just
don't get along, even if I do away with i810fb and DRM support.

    But I can't help but notice that every linux-suspend HOWTO tells
you to patch in swsusp2 as a first step -- the consensus seems to be
that it you want clean and conservative code, use swsusp1; if you want
suspending to *work*, use swsusp2.  How many people are actually able
to make use of swsusp1?  Is anyone testing it besides Mr. Machek?

    This is a case in point; every time I partition a system for
Linux, I have to consider whether or not I'm ever going to want swsusp
to work on that box.   The performance penalty for swap files went
away in 2.6, so this is sort of a regression.

    I know I'm not going to be writing any of those patches, but I'd
sure be nice if Linux got around to having usable suspend support
without being beholden to the whatever patches Mr. Cunningham gets
around to putting out.

-- 
Joseph Fannin
jhf@rivenstone.net

 /* So there I am, in the middle of my `netfilter-is-wonderful'
talk in Sydney, and someone asks `What happens if you try
to enlarge a 64k packet here?'. I think I said something 
eloquent like `fuck'. - RR */
