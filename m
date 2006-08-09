Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWHIS2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWHIS2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWHIS2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 14:28:46 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:36785 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751300AbWHIS2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 14:28:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FnrAyIqU58YFYEIK8hGRoQQAqhSWpQaardf8qkutWxkM1kmXgCnvoHMgpT3srHDKhZZqvBJm3HUm7UOrhK5BjaYV6k1yEleViglcG14Zr/RHHYUXM5GQJBz4pdVBkMEqQXJB+p/GUGOgNJXAA8DD+T6G18+cmFyr4Nc2FB0MO6g=
Message-ID: <62b0912f0608091128n4d32d437h45cf74af893dc7c8@mail.gmail.com>
Date: Wed, 9 Aug 2006 20:28:34 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Michael Loftis" <mloftis@wgops.com>
Subject: Re: ext3 corruption
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>
	 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>
	 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
	 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
	 <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Loftis wrote:
> > Is there no intelligent ordering of
> > shutdown events in Linux at all?
>
> The kernel doesn't perform those, your distro's init scripts do that.

Right.  It's all just "Linux" to me ;-).

(Maybe the kernel SHOULD coordinate it somehow,
 seems like some of the distros are doing a pretty bad job as is.)

> And various distros have various success at doing the right thing.  I've had
> the best luck with Debian and Ubuntu doing this in the right order.  RH
> seems to insist on turning off the network then network services such as
> sshd.

Seems things are worse than that.  Seems like it actually kills the
block device before it has successfully (or forcefully) unmounted the
filesystems.  Thus the killing must also be before stopping Samba,
since that's what was (always is) holding the filesystem.

It's indeed a redhat, though - Red Hat Linux release 9 (Shrike).

> > Samba was serving files to remote computers and had no desire to let
> > go of the filesystem while still running.  After 5 seconds or so,
> > Linux just shutdown the MD device with the filesystem still mounted.
>
> The kernel probably didn't do this, usually by the time the kernel gets to
> this point init has already sent kills to everything.  If it hasn't it
> points to problems with your init scripts, not the kernel.

Ok, so LKML is not appropriate for the init script issue.
Never mind that, I'll just try another distro when time comes.

I'd really like to know what the "Block bitmap for group not in group"
message means (block bitmap is pretty self explanatory, but what's a
group?).

And what will e2fsck do to my dear filesystem if I let it have a go at it?
