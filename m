Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269160AbUIYHZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269160AbUIYHZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 03:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269255AbUIYHZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 03:25:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20968 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269160AbUIYHZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 03:25:17 -0400
Date: Sat, 25 Sep 2004 08:25:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups and a bugfix
Message-ID: <20040925072516.GS23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org> <Pine.LNX.4.60.0409242059420.5443@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409241930510.2317@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 07:46:20PM -0700, Linus Torvalds wrote:
> So I would stronly suggest (and I may make sparse warn) against using
> non-integertyped enum values with any enum that actually has any backing
> store (ie if you ever use a variable of type "enum myenum", that would
> result in a warning - you can really just use the values "one" and "two"
> directly).

Linus, backing store is irrelevant here (and BTW, variables are no better
or worse than arguments / structure fields / return values / argument of
sizeof / etc.)

a) integer type equivalent to particular enum is up to compiler; anything
that depends on it is at the very least non-portable.

b) __bitwise doesn't break anything; __le32 enum members are just as OK as
int ones.

c) its enum members where we are not doing what gcc does; enum itself is
trivial to deal with.  So that's where the warnings should be.

Anyway, I'll send you sparse patches tomorrow when I rediff that stuff to
your current tree...
