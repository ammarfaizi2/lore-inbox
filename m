Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbTCNQcs>; Fri, 14 Mar 2003 11:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263368AbTCNQcs>; Fri, 14 Mar 2003 11:32:48 -0500
Received: from 237.oncolt.com ([213.86.99.237]:42694 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263365AbTCNQcr>; Fri, 14 Mar 2003 11:32:47 -0500
Subject: Re: [PATCH] Fix stack usage for amd_flash.c
From: David Woodhouse <dwmw2@infradead.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: Jonas Holmberg <jonas.holmberg@axis.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030314161916.GA23161@wohnheim.fh-wedel.de>
References: <20030314154642.GC27154@wohnheim.fh-wedel.de>
	 <1047657910.14792.153.camel@passion.cambridge.redhat.com>
	 <20030314161916.GA23161@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1047660209.14792.211.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 14 Mar 2003 16:43:30 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 16:19, Joern Engel wrote:
> On Fri, 14 March 2003 16:05:10 +0000, David Woodhouse wrote:
> > On Fri, 2003-03-14 at 15:46, Joern Engel wrote:
> > 
> > Urgh. That should never have been on the stack in the first place. Make
> > it static. The comment about being deallocated when the probe is done is
> > bogus -- where do we think we get the contents of the table from when
> > _entering_ the probe function anyway? It's elsewhere in the kernel
> > image.
> 
> Ok, done.
> Is the new patch ok?

I'd probably have left it where it was and had a one-line patch just
which made it static, to keep the size of the patch down and avoid
conflicts with people trying to add new chip idents -- but since I don't
want people adding new chip idents anyway I suppose that's fine.

> Right. But since 2.[567] is going towards 4k kernel stack, those
> drivers should be fixed or revomed. If you don't remove it, I'll try
> to fix it. :)

True. Thanks.

> > Btw you're sending out 8-bit mail with charset 'unknown-8bit'. What
> > should be a ö isn't.
> 
> Correct. I noticed that my inline patches were getting screwed up
> somehow and played around with the character set. It turned out that
> lkml is converting my mails to QP, no matter what I do. So the
> solution appears to be to include the important people in TO|CC and
> ignore the QP problem.

It's not converting to QP for me. My response to you, for example,
returned via lkml with...
	Content-Type: text/plain; charset=UTF-8
	Content-Transfer-Encoding: 8bit

Er, on further investigation it seems that Evolution actually _sent_ it
QP, and it got converted _from_ QP to 8-bit somewhere en route. That's
just bizarre. 

-- 
dwmw2

