Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTLUVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTLUVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 16:12:16 -0500
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:19072
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S264128AbTLUVML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 16:12:11 -0500
Date: Sun, 21 Dec 2003 16:12:03 -0500
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Mika Penttil? <mika.penttila@kolumbus.fi>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       jariruusu@users.sourceforge.net
Subject: Re: [PATCH] loop.c patches, take two
Message-ID: <20031221211201.GC4721@fukurou.paranoiacs.org>
Mail-Followup-To: Ben Slusky <sluskyb@paranoiacs.org>,
	Mika Penttil? <mika.penttila@kolumbus.fi>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	jariruusu@users.sourceforge.net
References: <20031030134137.GD12147@fukurou.paranoiacs.org> <3FA15506.B9B76A5D@users.sourceforge.net> <20031030133000.6a04febf.akpm@osdl.org> <20031031005246.GE12147@fukurou.paranoiacs.org> <20031031015500.44a94f88.akpm@osdl.org> <20031101002650.GA7397@fukurou.paranoiacs.org> <20031102204624.GA5740@fukurou.paranoiacs.org> <20031221195534.GA4721@fukurou.paranoiacs.org> <3FE6076B.3090908@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FE6076B.3090908@kolumbus.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Dec 2003 22:49:47 +0200, Mika Penttil? wrote:
> Yet another Big Loop Patch... :)
> 
> It's not obvious which parts are bug fixes, and which performance 
> improvements. What exactly breaks loops on journalling filesystems, and 
> how do you solve it?

See <URL:http://www.ussg.iu.edu/hypermail/linux/kernel/0310.3/1151.html>...
I'd submitted these patches a while back. Andrew observed that the
problems they fixed did not manifest in file-backed loops, so his
solution (which was merged into -mm but not mainstream) was to cut out
the block-backed code path entirely. THAT is what breaks journaling
filesystems on loops (note: not vice versa).

> What's the clone_bio() business? Why on reads only?

There's no need to allocate memory for a second copy of the data on
a read. This is a performance improvenment but I'd say it's closely
related to the main point of the patch (i.e. take what pages you can get
and recycle them); I'm making the block-backed code path significantly
more complex and at the same time having reads take a shortcut. But I
could split that into a separate patch if desired.

-- 
Ben Slusky                      | Yakka foob mog. Grug pubbawup
sluskyb@paranoiacs.org          | zink wattoom gazork. Chumble
sluskyb@stwing.org              | spuzz.
PGP keyID ADA44B3B              |               -Calvin
