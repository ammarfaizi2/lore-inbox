Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTBFPIu>; Thu, 6 Feb 2003 10:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267323AbTBFPIu>; Thu, 6 Feb 2003 10:08:50 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:59913 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267276AbTBFPIt>; Thu, 6 Feb 2003 10:08:49 -0500
Date: Thu, 6 Feb 2003 15:18:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: greg@kroah.com, torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030206151820.A11019@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <200302061502.KAA06538@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200302061502.KAA06538@moss-shockers.ncsc.mil>; from sds@epoch.ncsc.mil on Thu, Feb 06, 2003 at 10:02:37AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 10:02:37AM -0500, Stephen D. Smalley wrote:
> The capabilities module is one example, albeit a limited one.  As for
> modules like SELinux, it seems better to wait until all of the
> necessary hooks have either been accepted or definitively rejected
> before submitting an adapted form of the module for mainline.  After
> this set of changes, the only thing remaining is the networking hooks,
> which have already gone through a feedback cycle with the networking
> maintainers and are being pruned and revised accordingly.

Well, selinux is still far from a mergeable shape and even needed additional
patches to the LSM tree last time I checked.  This think of submitting hooks
for code that obviously isn't even intende to be merged in mainline is what
I really dislike, and it's the root for many problems with LSM.

There has been a history in Linux to only implement what actually needed
now instead of "clever" overdesigns that intend to look into the future,
LSM is a gross voilation of that principle.  Just look at the modules in
the LSM source tree:  the only full featured security policy in addition
to the traditional Linux model is LSM, all the other stuff is just some
additionl checks here and there.

I'm very serious about submitting a patch to Linus to remove all hooks not
used by any intree module once 2.6.0-test.

Life would be a lot simpler if you got the core flask engine in a mergeable
shapre earlier and we could have merged the hooks for actually using it
incrementally during 2.5, discussing the pros and contras for each hook
given an actual example - but the current way of adding extremly generic
hooks (despite the naming they are in no ways tied to enforcing security
models at all) without showing and discussing the code behind them simply
makes that impossible.

So yes, my suggestion is to backout the whole LSM mess for 2.6, merge
a sample policy core (i.e. a cleaned up flask/selinux) in 2.7.<early> and
then add one hook after another and discussing the architecture openly
where it belongs (here on lkml!).

