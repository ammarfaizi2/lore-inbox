Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263429AbUIDNwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263429AbUIDNwr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUIDNwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:52:47 -0400
Received: from pengo.systems.pipex.net ([62.241.160.193]:16363 "EHLO
	pengo.systems.pipex.net") by vger.kernel.org with ESMTP
	id S263429AbUIDNwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:52:44 -0400
Message-ID: <4139C8A3.6010603@tungstengraphics.com>
Date: Sat, 04 Sep 2004 14:52:35 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com> <4139A9F4.4040702@tungstengraphics.com> <20040904115442.GD2785@redhat.com> <4139B03A.6040706@tungstengraphics.com> <20040904122057.GC26419@redhat.com>
In-Reply-To: <20040904122057.GC26419@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Sep 04, 2004 at 01:08:26PM +0100, Keith Whitwell wrote:
> 
>  > So, we are coming out of a period of history where it was extremely 
>  > difficult to get our drivers to users through the 'official' channels - to 
>  > the extent that many people have given up on the possibility of them 
>  > working properly. Maybe things will improve now.
>  > 
>  > Are you suggesting for instance, that RedHat might pick up individual 
>  > drivers out of Xorg or better still Mesa, rather than waiting for a full 
>  > stable release?  That would probably be the biggest help - by comparison 
>  > kernel releases are very frequent.
> 
> I don't speak for X packaging (which is why I Cc'd Mike), 

In fact this drags back to my mind the last time a similar conversation came 
up.  That conversation lead in part to the descision to pull the userspace DRI 
drivers out of the DRI tree into Mesa, and to likewise spin the DRM off into a 
project of its own.  At that point Mike did indicate that he might consider 
pulling drivers directly from our releases (if I remember correctly).  Shortly 
after this the XFree86 slow-motion trainwreck started, and history overtook 
that idea.

What does all this mean?  Not much except that we've been hoping to speed up 
this process for a long time, and have been working to improve how we do 
things for about as long.

It's still a difficult problem though.  We've got three distinct, major 
projects that have to coordinate to get a release to users - Linux kernel 
(DRM), X.org (DDX) and Mesa (DRI 3D client).  These are all big, stable trees 
that have their own and changing release strategies.

Currently we have to perform two merges and three releases to get a driver to 
a users:

	Merge DRM CVS --> LK
	Release stable kernel  --> Picked up by vendor
	Release stable Mesa 3D
	Merge Mesa 3D --> X.org
	Release stable X.org  --> Picked up by vendor

Now that there's no development/stable kernel divide, the kernel releases 
should be the quickest part of this, though I'm not as optimistic as some 
about users pulling them down (but please, let's not go back to that, I'm 
prepared to believe...).

The fact is that X is already very modular, although not in terms of it's 
build process.  (If you believe the hype, a DDX compiled on i386 Linux should 
run on i386 Solaris, SCO, BSD, wherever, without modification.)

In any case, X isn't a monolithic binary, there is scope to pull in 
incremental updates if the will is there to do the validation.  If vendors are 
serious about making ad-hoc binary driver updates unnecessary, there has to be 
a willingness to address the whole problem.

Keith

