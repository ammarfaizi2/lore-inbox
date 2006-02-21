Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161308AbWBUELB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWBUELB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 23:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161309AbWBUELB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 23:11:01 -0500
Received: from dsl092-073-214.bos1.dsl.speakeasy.net ([66.92.73.214]:63706
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S1161308AbWBUELA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 23:11:00 -0500
Date: Mon, 20 Feb 2006 23:06:20 -0500
From: Sonny Rao <sonny@burdell.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Dave Jones <davej@redhat.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       bjd <bjdouma@xs4all.nl>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: kernel oops: trying to mount a corrupted xfs partition (2.6.16-rc3)
Message-ID: <20060221040620.GA2176@kevlar.burdell.org>
References: <20060216183629.GA5672@skyscraper.unix9.prv> <20060217063157.B9349752@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0602171753590.27452@yvahk01.tjqt.qr> <20060220082946.A9478997@wobbly.melbourne.sgi.com> <20060219215209.GB7974@redhat.com> <20060220070916.GA8101@kevlar.burdell.org> <20060221020447.GB1588@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060221020447.GB1588@frodo>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 01:04:47PM +1100, Nathan Scott wrote:
> On Mon, Feb 20, 2006 at 02:09:16AM -0500, Sonny Rao wrote:
> > On Sun, Feb 19, 2006 at 04:52:09PM -0500, Dave Jones wrote:
> > <snip> 
> > > Just for kicks, I just hacked this up..
> > > 
> > > #!/bin/bash
> > > wget http://www.digitaldwarf.be/products/mangle.c
> > > gcc mangle.c -o mangle
> > > 
> > > dd if=/dev/zero of=data.img count=70000
> > > 
> > > while [ 1 ];
> > > do
> > >         mkfs.xfs -f data.img >/dev/null
> > > 		./mangle data.img $RANDOM
> > >         sudo mount -t xfs data.img mntpt -o loop
> > >         sudo ls -R mntpt
> > >         sudo umount mntpt
> > > done
> > ...
> > > 
> > > xfs wins the award for 'noisiest fs in the face of corruption' :-)
> > > After a few dozen backtraces from xfs_corruption_error,
> > > this fell out...
> > > 
> > > divide error: 0000 [1] SMP
> > <snip trace>
> >  
> > > (The kernel is based on 2.6.16rc4)
> > 
> > I see a similar breakage (divide error) on x86 using 2.6.15
> 
> From a quick look at the image you sent me Sonny, I guess this is
> the same problem Dave was seeing too -- a divide by zero when we're
> working out some of the per-mount constants during mount(2).  There
> is probably one or two other superblock fields that could use more
> verification, but this will do for now.

yep, this patch fixes it

Sonny
