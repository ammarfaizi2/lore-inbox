Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269621AbUHZU7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbUHZU7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269647AbUHZU4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:56:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:38297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269413AbUHZUs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 16:48:58 -0400
Date: Thu, 26 Aug 2004 13:47:37 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>, Diego Calleja <diegocg@teleline.es>,
       jamie@shareable.org, christophe@saout.de, christer@weinigel.se,
       spam@tnonline.net, akpm@osdl.org, wichert@wiggy.net, jra@samba.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0408261344150.2304@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408261356330.27909-100000@chimarrao.boston.redhat.com>
 <200408262128.41326.vda@port.imtp.ilyichevsk.odessa.ua>
 <Pine.LNX.4.58.0408261132150.2304@ppc970.osdl.org>
 <20040826191323.GY21964@parcelfarce.linux.theplanet.co.uk>
 <20040826203228.GZ21964@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Argh...  OK, now I remember why I went for -EBUSY for unlink() (we obviously
> are not bound by SuS on that one).  Consider the following scenario:
> 	* local file foo got something else bound on it for a while
> 	* we are tight on space - time to clean up
> 	* oh, look - contents of foo is junk
> 	* rm foo
> 	* ... oh, fuck, there goes the underlying file.

Hey, that's a valid reason for doing -EBUSY for normal bind-mounts, but it
actually _is_ what we want for an "implied-by-way-of-container-mount". 
After all, when you do a "rm foo", you do mean "remove the container foo".

I replied to your earlier off-list mail in private, so let's re-iterate
for the list: the easiest way to handle this is to just have a "mount
option", and have "MNT_ALLOWUNLINK" that gets set for containers, and that
users could possibly choose to set for regular mounts too (as a mount
option) if they really want to (and if we want them to).

So there's no reason we'd have to drop existing mount behaviour only 
because we also have special files that look like mountpoints. 

		Linus
