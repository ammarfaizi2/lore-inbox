Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbTJaAw7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 19:52:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbTJaAw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 19:52:58 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:7297
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S262709AbTJaAw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 19:52:57 -0500
Date: Thu, 30 Oct 2003 19:52:49 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove useless highmem bounce from loop/cryptoloop
Message-ID: <20031031005246.GE12147@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	Andrew Morton <akpm@osdl.org>,
	Jari Ruusu <jariruusu@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030133000.6a04febf.akpm@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 13:30:00 -0800, Andrew Morton wrote:
> Ben, I confess that I'd forgotten about #1198.  I'll take a look at your
> memory allocation fix - it seems to be unfortunately large, but we may need
> to go that way.

The current memory allocation procedure really is inadequate. It worked
ok up thru 2.4 because the loop device was used almost exclusively
as a nifty hack to make an initrd or to double-check the ISO you just
created. Throw strong crypto into the mix and it becomes reasonable to
have your laptop mount all its filesystems and swap off of loop devices.

> One question is: why do we go down a different code path for blockdevs
> nowadays anyway?  The handoff to the loop thread seems to work OK for
> file-backed loop, and providing a bmap() for blockdevs is easy enough?

The code path for file-backed loop handles one page at a time, as that's
the limit of the FS interface. Block-backed loop devices can throw
huge bios at their backing device with one make_request. If we could
get both working on the same code path, would that be worth hobbling
block-backed loop?

-- 
Ben Slusky                      | If you're not part of the
sluskyb@paranoiacs.org          | solution, there's good money
sluskyb@stwing.org              | to be made in prolonging the
PGP keyID ADA44B3B              | problem.      www.despair.com
