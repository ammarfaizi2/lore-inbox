Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbTDJCIX (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 22:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTDJCIX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 22:08:23 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:35334 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261694AbTDJCIV (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 22:08:21 -0400
Subject: Re: 64-bit kdev_t - just for playing
From: James Bottomley <James.Bottomley@steeleye.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304092202570.5042-100000@serv>
References: <1049913637.1993.73.camel@mulgrave> 
	<Pine.LNX.4.44.0304092202570.5042-100000@serv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 09 Apr 2003 21:19:48 -0500
Message-Id: <1049941189.4467.186.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-09 at 15:54, Roman Zippel wrote:
> Why do we need majors at all? There is no perfect way to partition the 
> device number, it will always be some compromise. This partitioning 
> creates more problems than it solves.

Because without them we need a user space tool or kernel policy add on
that doesn't yet exist.

> Simply start allocating from 0x10000 and you can have (2^32-2^16)/partnr 
> block devices.
> The sg nodes problem is also easy to solve, but it requires the character 
> device hash Andries removed.

But, isn't that, in part, the point of this discussion.  Sg with no code
changes will stand the expansion of the kernel dev_t.  There is only a
problem if you want the device numbers dynamically assigned.

> So let's "taste" a few ideas. I don't want any decision, I want to get a 
> discussion started, which explores some of the possibilities, so that we 
> have _some_ idea of what we need.

That discussion doesn't have much to do with the size of the kernel
dev_t, though.  For dynamic devices, it's just a number.

> > However, there is already consideration of this issue, see for example:
> > 
> > http://www.linuxsymposium.org/2003/view_abstract.php?talk=94
> 
> I'd love to see this implemented and I would certainly like to help, but 
> I'm mostly interested in the kernel side of this.
> I haven't found much information about this, so it's difficult to comment 
> on this.

Erm, I'm afraid I believe the idea to be based on leveraging the
existing infrastructure, so I'd be surprised if much kernel work were
required (well beyond what is already planned for hotplug, anyway).

> These "enterprise device demands" certainly shouldn't break existing 
> setups? The patches I've seen from Andries so far do exactly this.
> What I'm mostly trying to get out of this discussion is how this large 
> dev_t will be used during 2.6, as this requires decisions now, I'd like 
> to know and talk about the possible consequences.

I don't see how the current patches break anything, yet.  I've already
said how I plan to use a larger kernel dev_t in SCSI.

> In this mail 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104928874409158&w=2
> I demonstrated how new device numbers can be generated, without breaking 
> backwards compatibility, it's quite trivial to complete this patch.

I said in my last mail that "thanks to the work of Al Viro and others,
the problem of dynamic majors for block devices lies predominantly in
user space".  The piece that you label "trivial" is the missing
character device and user space components.  I don't happen to believe
it is at all trivial, but you're welcome to prove me wrong.

James


