Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272042AbTHDRSj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272043AbTHDRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:18:39 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:42181 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S272042AbTHDRSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:18:31 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Mon, 4 Aug 2003 19:18:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: herbert@13thfloor.at
Cc: beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-Id: <20030804191828.6554afe2.skraw@ithnet.com>
In-Reply-To: <20030804165435.GB9409@www.13thfloor.at>
References: <20030804134415.GA4454@win.tue.nl>
	<200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com>
	<20030804175609.7301d075.skraw@ithnet.com>
	<20030804161657.GA6292@www.13thfloor.at>
	<20030804183545.01b7a126.skraw@ithnet.com>
	<20030804165435.GB9409@www.13thfloor.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Aug 2003 18:54:35 +0200
Herbert Pötzl <herbert@13thfloor.at> wrote:

> On Mon, Aug 04, 2003 at 06:35:45PM +0200, Stephan von Krawczynski wrote:
> > On Mon, 4 Aug 2003 18:16:57 +0200
> > Herbert Pötzl <herbert@13thfloor.at> wrote:
> > 
> > > on the other hand, if you want somebody to implement
> > > this stuff for you, you'll have to provide convincing
> > > arguments for it, I for example, would be glad if
> > > hardlinks where removed from unix altogether ...
> > 
> > Huh, hard stuff!
> > 
> > Explain your solution for a very common problem:
> > 
> > You have a _big_ fileserver, say some SAN or the like with Gigs.
> > Your data on it is organized according to your basic user 
> > structure, because it is very handy to have all data from one 
> > user altogether in one directory.
> 
> I already do something like this, although not for thousands
> of users, but I guess this would scale well ...
> 
> consider a storage device (maybe a partition) for each 
> category of data you want to store/provide/serve
> 
> /mnt/webspace, /mnt/database, /mnt/email, /mnt/wossname ...

I have one objection: it is the poorest possible implementation in terms of
storage usage. You may have TBs free on database and ran full on webspace,
fluctuation on email is dramatic. You waste a damn lot of resources with this
approach.
I consider it usable but inferior in terms of costs and scalability. One can
very well argue you have to waste bucks to avoid hardlinks (which you don't
have at this point). Not having hardlinks costs obviously more. In fact a very
good commercial argument pro hardlinks.
If you have all your partitions only logically organised on one SAN you have to
remount via nfs quite a bit to get things in the right trees. That does not
sound like a performance setup. Did you manage to remount "mount --bind"
volumes?

and ...

> on the access server (where the customer maintains the data)
> you'll end up mounting all the storage categories, required
> for access and you do an additional restructuring for each
> customer (which of course is automated)
> 
> /home/customer/charlie is populated with symlinks to
> /mnt/*/customer/charlie named by category
> 
> /home/customer/charlie/webspace -> /mnt/webspace/customer/charlie
> /home/customer/charlie/email -> /mnt/email/customer/charlie
> ...

which basically means on your access server you have to follow symlinks which
is yet another security issue in itself.

Basically you avoid a clean hardlink-setup with a symlink-setup rising possible
security drawbacks and a lot of remounting to get things straight...
I am not really convinced.

Regards,
Stephan


