Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbVKYNRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVKYNRE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 08:17:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVKYNRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 08:17:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:174 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932316AbVKYNRC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 08:17:02 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Nix <nix@esperi.org.uk>
Subject: Re: pivot_root broken in 2.6.15-rc1-mm2
Date: Fri, 25 Nov 2005 07:16:28 -0600
User-Agent: KMail/1.8
Cc: Neil Brown <neilb@suse.de>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org
References: <17283.52960.913712.454816@cse.unsw.edu.au> <200511230602.53960.rob@landley.net> <87psopkkqm.fsf@amaterasu.srvr.nix>
In-Reply-To: <87psopkkqm.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511250716.29127.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 November 2005 05:52, Nix wrote:
> On 23 Nov 2005, Rob Landley gibbered uncontrollably:
> > Rather than unmounting rootfs, it deletes everything out of it to free up
> > the space.  (It basically does the functional equivalent of "find / -xdev
> > | xargs rm -rf"
>
> Er, find / -xdev | xargs rm -f, I hope.

Yeah. :)

> (rm won't respect the -xdev you gave to find, and, well, if your new root
> is mounted at all, you're dead :) )

It's C code, not shell, so that was off the top of my head. :)

And that, in fact, is one of the big reasons that there's a utility for it: 
not accidentally deleting anything out of your root partition is kind of 
important.

(Another is that calling chroot and such after deleting their binaries out of 
initramfs but before the paths are adjusted so that the ones in the new root 
can find their shared libraries is a bit of a headache.  It's a lot easier to 
just have it all in one binary that's already loaded everything it needs and 
frees its memory on exec.)

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
