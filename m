Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWG0N4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWG0N4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWG0N4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:56:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59762 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750859AbWG0N4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:56:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=torgbX4TYBVCv0LdFptuxWC/nGYjgHCr6dlT5/InppzwYb+eofUviv7jFr3GOCPf6rYFYTqgTv8he0FijR1idQIf0ufZUfQytheo1sCSYxfZkywtr4KmWWZbYmT2e/xmAw2pyk+1rSqyYqVJmgBlQTnwZl6xRMJ58JZhcxVQSMk=
Message-ID: <d120d5000607270656l60e7353cob6a2605347f1577e@mail.gmail.com>
Date: Thu, 27 Jul 2006 09:56:50 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "gmu 2k6" <gmu2006@gmail.com>
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually find a device
Cc: "Jeff Garzik" <jeff@garzik.org>, "Arjan van de Ven" <arjan@infradead.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Bjorn Helgaas" <bjorn.helgaas@hp.com>, "Andrew Morton" <akpm@osdl.org>,
       "Mike Miller" <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <f96157c40607270628u7456bbf4w80bcd166d741b7f0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607251636.42765.bjorn.helgaas@hp.com>
	 <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com>
	 <1153867675.8932.68.camel@laptopd505.fenrus.org>
	 <44C6F26C.2080203@garzik.org>
	 <d120d5000607270601n74227ccdrb37b965c247c375e@mail.gmail.com>
	 <f96157c40607270628u7456bbf4w80bcd166d741b7f0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> On 7/27/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 7/26/06, Jeff Garzik <jeff@garzik.org> wrote:
> > > Arjan van de Ven wrote:
> > > > On Wed, 2006-07-26 at 00:43 +0200, Jesper Juhl wrote:
> > > >> On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > >>> If we don't find any devices, we shouldn't print anything.
> > > >>>
> > > >> I disagree.
> > > >> I find it quite nice to be able to see that the driver loaded even if
> > > >> it finds nothing. At least then when there's a problem, I can quickly
> > > >> see that at least it is not because I didn't forget to load the
> > > >> driver, it's something else. Saves time since I can start looking for
> > > >> reasons why the driver didn't find anything without first spending
> > > >> additional time checking if I failed to cause it to load for some
> > > >> reason.
> > > >
> > > > I'll add a second reason: it is a REALLY nice property to be able to see
> > > > which driver is started last in case of a crash/hang, so that the guilty
> > > > party is more obvious..
> > >
> > > OTOH, it is not a property that scales well at all.
> > >
> > > When you build extra drivers into the kernel, or distros load drivers
> > > you don't need (_every_ distro does this), you wind up with a bunch of
> > > version strings for drivers for hardware you don't have.
> > >
> >
> > Given that boot tracing is best done with initcall_debug and
> > drivers that care about their version string can report it through
> > /sys/modules/<driver>/version why should version string be printed at
> > load time at all?
>
> not every driver provides that file (btw, I guess you mean
> /sys/module, don't you?) there anyway so it's still inconsistent.

Yes, you are right, we drop version string when !MODULE. We need to
keep it if we want to have consistent sysfs data.

> what if you can see up until loading of the driver and it halts there
> without /sys being mounted yet. I don't think you can rely on sysfs
> being mounted or modules being loaded.

Right, so you boot with debug_initcall to see what was the last thing
that we tried to initialize. Hmm, we might need to add debug_modcall
to print names of modules being loaded as well.

-- 
Dmitry
