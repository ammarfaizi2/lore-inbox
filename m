Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbUDNQ1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264278AbUDNQ1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:27:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36992 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264274AbUDNQ0i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:26:38 -0400
Date: Wed, 14 Apr 2004 17:26:37 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] BME, noatime and nodiratime
Message-ID: <20040414162637.GF31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406145544.GA19553@MAIL.13thfloor.at> <20040406204843.GL31500@parcelfarce.linux.theplanet.co.uk> <20040406231136.GN31500@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0404140803040.12398@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404140803040.12398@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2004 at 08:14:18AM -0700, Linus Torvalds wrote:
> Ignoring noatime is potentially the only one we should look at, but since 
> tty's really _are_ "noatime" as far as the filesystem is concerned, I 
> think it makes sense in the situation we are in anyway. The real reason 
> for "noatime" is to avoid unnecessary filesystem activity, not that we 
> necessarily want a constant atime.

Another thing we are ignoring is r/o.  Oh, well - the same arguments apply.
 
> > There are similar places in some other char drivers.  Obvious step would
> > be to have them do file_accessed() instead; however, I'd really like to
> > hear the rationale for existing behaviour.  Comments?
> 
> I don't know about other char drivers, those may well be wrong. But for
> tty's in particular, idle time calculations really do pretty much require
> the behaviour (apart from #3 - and #3 is, I think, effectively required by
> not wanting to touch the disk on keyboard accesses).

AFAICS, they simply copy what tty_io.c does.  Out of these guys busmouse.c
might have a similar excuse; qtronix.c and sonypi.c AFAICS have no reason
to touch atime at all.  No idea what should usb/core/devio.c do...

Anyway, I'm going down right now; expect a patchbomb tonight after I get
some sleep...
