Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272048AbTHDRZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272049AbTHDRZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:25:56 -0400
Received: from www.13thfloor.at ([212.16.59.250]:34697 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S272048AbTHDRZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:25:41 -0400
Date: Mon, 4 Aug 2003 19:25:47 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804172547.GB14588@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804134415.GA4454@win.tue.nl> <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com> <20030804175609.7301d075.skraw@ithnet.com> <20030804161657.GA6292@www.13thfloor.at> <20030804183545.01b7a126.skraw@ithnet.com> <20030804165435.GB9409@www.13thfloor.at> <20030804191828.6554afe2.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804191828.6554afe2.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 07:18:28PM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 18:54:35 +0200
> Herbert Pötzl <herbert@13thfloor.at> wrote:
> 
> > On Mon, Aug 04, 2003 at 06:35:45PM +0200, Stephan von Krawczynski wrote:
> > > On Mon, 4 Aug 2003 18:16:57 +0200
> > > Herbert Pötzl <herbert@13thfloor.at> wrote:
> > > 
> > > > on the other hand, if you want somebody to implement
> > > > this stuff for you, you'll have to provide convincing
> > > > arguments for it, I for example, would be glad if
> > > > hardlinks where removed from unix altogether ...
> > > 
> > > Huh, hard stuff!
> > > 
> > > Explain your solution for a very common problem:
> > > 
> > > You have a _big_ fileserver, say some SAN or the like with Gigs.
> > > Your data on it is organized according to your basic user 
> > > structure, because it is very handy to have all data from one 
> > > user altogether in one directory.
> > 
> > I already do something like this, although not for thousands
> > of users, but I guess this would scale well ...
> > 
> > consider a storage device (maybe a partition) for each 
> > category of data you want to store/provide/serve
> > 
> > /mnt/webspace, /mnt/database, /mnt/email, /mnt/wossname ...
> 
> I have one objection: it is the poorest possible implementation in terms of
> storage usage. You may have TBs free on database and ran full on webspace,
> fluctuation on email is dramatic. You waste a damn lot of resources with this
> approach.

hmm, I guess this objection can be ignored, because you
do not have to use a separate partition, if you do not want
to, do you?

> I consider it usable but inferior in terms of costs and scalability. One can
> very well argue you have to waste bucks to avoid hardlinks (which you don't
> have at this point). Not having hardlinks costs obviously more. In fact a very
> good commercial argument pro hardlinks.
> If you have all your partitions only logically organised on one SAN you have to
> remount via nfs quite a bit to get things in the right trees. That does not
> sound like a performance setup. Did you manage to remount "mount --bind"
> volumes?
> 
> and ...
> 
> > on the access server (where the customer maintains the data)
> > you'll end up mounting all the storage categories, required
> > for access and you do an additional restructuring for each
> > customer (which of course is automated)
> > 
> > /home/customer/charlie is populated with symlinks to
> > /mnt/*/customer/charlie named by category
> > 
> > /home/customer/charlie/webspace -> /mnt/webspace/customer/charlie
> > /home/customer/charlie/email -> /mnt/email/customer/charlie
> > ...
> 
> which basically means on your access server you have to follow 
> symlinks which is yet another security issue in itself.
> 
> Basically you avoid a clean hardlink-setup with a symlink-setup 
> rising possible
> security drawbacks and a lot of remounting to get things straight...
> I am not really convinced.

no remounting so far, and security is the same with or
without symlinks, either you have access to the data or not,
in any way, the symlink doesn't change this behaviour ...

best,
Herbert

> Regards,
> Stephan
> 
