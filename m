Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932452AbWDMTEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbWDMTEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWDMTEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 15:04:15 -0400
Received: from smtp106.plus.mail.re2.yahoo.com ([206.190.53.31]:24762 "HELO
	smtp106.plus.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932452AbWDMTEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 15:04:15 -0400
Date: Thu, 13 Apr 2006 21:04:12 +0200
From: <tyler@agat.net>
To: linux-kernel@vger.kernel.org
Cc: gregkh@suse.de
Subject: Re: [PATCH] Kmod optimization
Message-ID: <20060413190412.GA30541@Starbuck>
Mail-Followup-To: tyler@agat.net, linux-kernel@vger.kernel.org,
	gregkh@suse.de
References: <20060413180345.GA10910@Starbuck> <20060413182401.GA26885@suse.de> <20060413183617.GB10910@Starbuck> <20060413185014.GA27130@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413185014.GA27130@suse.de>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 11:50:14AM -0700, Greg KH wrote:
> On Thu, Apr 13, 2006 at 08:36:17PM +0200, tyler@agat.net wrote:
> > On Thu, Apr 13, 2006 at 11:24:01AM -0700, Greg KH wrote:
> > > On Thu, Apr 13, 2006 at 08:03:45PM +0200, tyler@agat.net wrote:
> > > > Hi,
> > > > 
> > > > the request_mod functions try to load automatically a module by running
> > > > a user mode process helper (modprobe).
> > > > 
> > > > The user process is launched even if the module is already loaded. I
> > > > think it would be better to test if the module is already loaded.
> > > 
> > > Does this cause a problem somehow?  request_mod is called _very_
> > > infrequently from a normal kernel these days, so I really don't think
> > > this is necessary.
> > 
> > Yes I agree it _should_ be very infrequently called but it _will_ be very
> > infrequently called just if the user space configuration is done properly.
> 
> What do you mean by this?  Almost all 2.6 distros use udev today, which
> prevents this code from ever getting called.  So odds are, you are
> optimising something that no one will ever use :)
Well perhaps I don't understand the mechanism :) But let's take an
example.
On all kernels (even recent), if the module smbfs is loaded, it's not
handled by udev and request_module could be called.

Let"s take another example to see to illustrate why I think
it depends on the user configuration :
module A depends on module B

if we have a script which do "insmod moduleA.ko ; insmod moduleB.ko",
there will be a call to request_module.

if the script is "insmod moduleB.ko ; insmod moduleA.ko", request_mode
is not called.

I know the first script is really idiot :)

This is what I was thinking about in my previous mail.

-- 
tyler
tyler@agat.net


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
