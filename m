Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271933AbTHDQyd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 12:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271936AbTHDQyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 12:54:33 -0400
Received: from www.13thfloor.at ([212.16.59.250]:25737 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S271933AbTHDQy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 12:54:28 -0400
Date: Mon, 4 Aug 2003 18:54:35 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: FS: hardlinks on directories
Message-ID: <20030804165435.GB9409@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Stephan von Krawczynski <skraw@ithnet.com>,
	beepy@netapp.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
References: <20030804134415.GA4454@win.tue.nl> <200308041542.h74Fg9k26251@orbit-fe.eng.netapp.com> <20030804175609.7301d075.skraw@ithnet.com> <20030804161657.GA6292@www.13thfloor.at> <20030804183545.01b7a126.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804183545.01b7a126.skraw@ithnet.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 06:35:45PM +0200, Stephan von Krawczynski wrote:
> On Mon, 4 Aug 2003 18:16:57 +0200
> Herbert Pötzl <herbert@13thfloor.at> wrote:
> 
> > on the other hand, if you want somebody to implement
> > this stuff for you, you'll have to provide convincing
> > arguments for it, I for example, would be glad if
> > hardlinks where removed from unix altogether ...
> 
> Huh, hard stuff!
> 
> Explain your solution for a very common problem:
> 
> You have a _big_ fileserver, say some SAN or the like with Gigs.
> Your data on it is organized according to your basic user 
> structure, because it is very handy to have all data from one 
> user altogether in one directory.

I already do something like this, although not for thousands
of users, but I guess this would scale well ...

consider a storage device (maybe a partition) for each 
category of data you want to store/provide/serve

/mnt/webspace, /mnt/database, /mnt/email, /mnt/wossname ...

now each data space gets subdirectories for logical
groupings (optional) and a second level for the actual
users ... there could be other layers like domains for 
example too ...

/mnt/webspace/customer/charlie
/mnt/webspace/customer/jack
/mnt/webspace/customer/wossname

and, if required, the same structure for database, email, ...

so you end up with totally separate storage trees, which
can be easily mounted/exported/shared with the apropriate
servers, now for the conceptional grouping, where the 
customer wants to have all the data in one place ...

on the access server (where the customer maintains the data)
you'll end up mounting all the storage categories, required
for access and you do an additional restructuring for each
customer (which of course is automated)

/home/customer/charlie is populated with symlinks to
/mnt/*/customer/charlie named by category

/home/customer/charlie/webspace -> /mnt/webspace/customer/charlie
/home/customer/charlie/email -> /mnt/email/customer/charlie
...

this also has the advantage that any kind of service change
(for example changing the webspace) can be simply done by 
modifying the symlinks ...


> if you managed to link all web-data together in one directory and
> exported that to your webservers and they are hacked, you just 
> blew up all your web-data but nothing more. 
> This is a remarkable risk reduction.
> And now? Name your idea to export only the data needed to 
> the servers that need it. And keep in mind, we are talking of 
> Gigs and tenthousands of users. 

this is covered by the suggested approach.

> You definitely don't want one mount per user per service.

no, I don't ...

> Can you think of a more elegant way to solve such a problem 
> than hardlinking all web in one single webtree, all sql in one 
> single sql tree ... and then export this single tree (with its 
> artificial structure) to the corresponding server?
> I am curiously listening...

best,
Herbert

> Regards,
> Stephan
> 
