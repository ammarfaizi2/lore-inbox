Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVJVRB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVJVRB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJVRB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 13:01:26 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:12688
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750732AbVJVRBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 13:01:25 -0400
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: David Leimbach <leimy2k@gmail.com>
Subject: Re: /etc/mtab and per-process namespaces
Date: Wed, 19 Oct 2005 22:42:03 -0500
User-Agent: KMail/1.8
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
In-Reply-To: <3e1162e60510021508r6ef8e802p9f01f40fcf62faae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510192242.03309.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 October 2005 17:08, David Leimbach wrote:
> I've been just playing around with the v9fs work and private
> namespaces from yesterday's [October 1, 2005] top of tree from Linus'
> git archive and I was looking at /etc/mtab's reaction to having
> multiple namespaces with bind mounts.

Oh you don't need namespaces to hork mtab.  Do a mount from a chroot 
environment.  Or try to use --bind or --move mounts (at all) and watch it beg 
for mercy.  (I accidentally ran UserMode Linux as root once, using a hostfs 
root filesystem to borrow the existing Linux's root filesystem, and its' 
mounts edited the parent system's /etc/mtab.  Yeah, that was user error on my 
part, but it's also the _only_ gotcha I've found when doing that.)

/etc/mtab is simply brittle.  Personally, on systems I build, I ln 
-s /proc/mounts /etc/mtab

Rob
