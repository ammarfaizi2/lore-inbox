Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265010AbUD3AEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbUD3AEL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265028AbUD3AEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:04:11 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:2348 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S265010AbUD3AEI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:04:08 -0400
Date: Thu, 29 Apr 2004 19:04:08 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, vonbrand@inf.utfsm.cl, nickpiggin@yahoo.com.au,
       jgarzik@pobox.com, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040430000408.GA29096@hexapodia.org>
References: <40904A84.2030307@yahoo.com.au> <200404292001.i3TK1BYe005147@eeyore.valparaiso.cl> <20040429133613.791f9f9b.pj@sgi.com> <20040429141947.1ff81104.akpm@osdl.org> <20040429143403.35a7a550.pj@sgi.com> <20040429145725.267ea7b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429145725.267ea7b8.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 02:57:25PM -0700, Andrew Morton wrote:
> > When I'm working late, I want my updatedb/backup jobs
> > to scrunch themselves into a corner, even as my builds
> > and gui desktop continue to fly and suck up RAM.
> 
> Sure.  That's not purely a cacheing thing though. Even if the background
> activity was clamped to just a few megs of cache you'll find that the
> seek activity is a killer, and needs a limitation mechanism.  Although the
> anticipatory scheduler helps here a lot.

I grant that in the updatedb case (or the backup case), the seeks are
going to suck and they're inherently on the same spindle as the user's
data, so there's no fixing it (short of a real "IO nice").

But in a related case, I have a background daemon that does a lot of IO
(mostly sequential, one page at a time read/modify/write of a multi-GB
file) to a filesystem on a separate spindle from my main filesystems.
I'd like to use a similar mechanism to say "don't let this program eat
my pagecache" that will let the daemon crunch away without severely
impacting my desktop work.

-andy
