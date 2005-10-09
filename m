Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVJIHol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVJIHol (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 03:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbVJIHok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 03:44:40 -0400
Received: from nproxy.gmail.com ([64.233.182.197]:34799 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932234AbVJIHok convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 03:44:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kwS9tEzcEseybfXCIQn4rsGu+zEK8eL09eUi82u+f0qN+EHQuV93BofcTi+0ONiOI/wfgeY9UGPXrLn8JD3hp3J/LNt2uoXbm+zFy52OVh+G8shqp+vh51aSIGsVKumDZNQn+9G4rtA5LXVYYvZgsQN/p2O77kWPuUrw2dfJ7DU=
Message-ID: <2cd57c900510090044o249258cbycf8afab644902e7@mail.gmail.com>
Date: Sun, 9 Oct 2005 15:44:38 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: "stable" vs "security stable"
Cc: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, security@kernel.org
In-Reply-To: <200510090714.j997Ek2i032551@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
	 <200510090714.j997Ek2i032551@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Sun, 09 Oct 2005 14:07:19 +0800, Coywolf Qi Hunt said:
> > Hello,
> >
> > I find the kernel.org first page inconvenient for some people somehow
> > since the security stable came.
>
> Unfortunately, it's a "stable", not "security stable" release.  Although

It is "security stable". Let's take this new notation from now on.
"Security Stable" doesn't have to be all security related.

(you want stable@kernel.org to replace security@kernel.org too?)

> a large proportion of the fixes are security-related, the aren't *all*
> security - there's also the occasional brown-bag bug or unexpected side
> effect that simply causes incorrect operation of the kernel.
>
> Having said that, Coywolf *is* right in that it's a bit unclear that
> you have to fetch the 'F'(ull) 2.6.13.3, then get the patch, put that
> on with patch -R to get a 2.6.13 tree, and then apply the 2.6.14-rc3 patch.
> (Although if you realize that 14-rc3 is diffed off 13.0, not 13.3, it's not
> that bad at all)...
>
> I admit being torn between encouraging more people to try -rc kernels, and
> wanting to enforce a minimum clue level on those trying to do so....
>
> Hmm.. what if we did something like this:

What you did is so stupid to me to to use -R every time. -R implies
something wrong, and need to revert.

>
> diff -rup linux-2.6.13/dot.release linux-2.6.13.3/dot.release
> --- linux-2.6.13/dot.release    2005-10-09 03:09:54.000000000 -0400
> +++ linux-2.6.13.3/dot.release  2005-10-09 03:12:02.000000000 -0400
> @@ -1,2 +1,2 @@
> -This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
> -and the final 2.6.14 patch should be applied to this.
> +This is a dot release. You need to patch -R the .3 patch before
> +attempting to apply a .14-rc or .14 patch.
>
> And then build the 14-rc3 patch:
>
> diff -rup linux-2.6.13/dot.release linux-2.6.14-rc3/dot.release
> --- linux-2.6.13/dot.release    2005-10-09 03:09:54.000000000 -0400
> +++ linux-2.6.14-rc3/dot.release        2005-10-09 03:03:40.000000000 -0400
> @@ -1,2 +1,3 @@
> -This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
> -and the final 2.6.14 patch should be applied to this.
> +This is a 14-rc3 release.  The patch will bomb out if you try
> +to apply it to anything other than a 2.6.13.0 tree.  Did you
> +remember to 'patch -R' any 2.6.13.N 'stable' patch first?
>
> Now if we arrange for that to be the first diff in the patchfile, and
> they get it wrong, they'll see:
>
> % patch -p1 < 2.6.14-rc3.patch
> patching file dot.release
> Hunk #1 FAILED at 1.
> 1 out of 1 hunk FAILED -- saving rejects to file dot.release.rej
> % cat dot.release.rej
> ***************
> *** 1,2 ****
> - This is a base release 2.6.13.  Stable patches, 2.6.14-rc patches,
> - and the final 2.6.14 patch should be applied to this.
> --- 1,3 ----
> + This is a 14-rc3 release.  The patch will bomb out if you try
> + to apply it to anything other than a 2.6.13.0 tree.  Did you
> + remember to 'patch -R' any 2.6.13.N 'stable' patch first?
>
> (OK, it's a silly 3AM idea. ;)

(3pm here. :)
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
