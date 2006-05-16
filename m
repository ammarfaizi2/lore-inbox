Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWEPQvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWEPQvG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751873AbWEPQvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:51:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:39567 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751875AbWEPQu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:50:58 -0400
Date: Tue, 16 May 2006 09:49:01 -0700
From: Greg KH <gregkh@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060516164901.GA16395@suse.de>
References: <20060515115302.5abe7e7e.akpm@osdl.org> <6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com> <20060515122613.32661c02.akpm@osdl.org> <6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com> <20060516103930.0c0d5d33.khali@linux-fr.org> <20060516145517.2c2d4fe4.khali@linux-fr.org> <20060516164846.4d42ed11.khali@linux-fr.org> <20060516172346.b729da01.khali@linux-fr.org> <20060516160842.GA13497@suse.de> <20060516092702.59bf2a71@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060516092702.59bf2a71@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 09:27:02AM -0700, Stephen Hemminger wrote:
> On Tue, 16 May 2006 09:08:42 -0700
> Greg KH <gregkh@suse.de> wrote:
> 
> > On Tue, May 16, 2006 at 05:23:46PM +0200, Jean Delvare wrote:
> > > Quoting myself:
> > > > And the winner is...
> > > > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > > > 
> > > > Stephen, Greg?
> > > 
> > > Indeed this patch breaks class_device_add in the success case...
> > > 
> > > Andrew, maybe you want to put this in the hot-fixes directory for
> > > 2.6.17-rc1-mm4, as the problem hits all drivers which register with a
> > > class.
> > > 
> > > Fix class_device_add success case after
> > > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > > broke it. class_dev was no more put and class_name was no more freed
> > > before leaving. The former caused locks on driver removal (class_dev
> > > usage count could never be 0.)
> > > 
> > > This fix should be folded into
> > > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > > 
> > > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > > ---
> > >  drivers/base/class.c |    2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > --- linux-2.6.17-rc4-mm1.orig/drivers/base/class.c	2006-05-16 16:38:02.000000000 +0200
> > > +++ linux-2.6.17-rc4-mm1/drivers/base/class.c	2006-05-16 17:00:24.000000000 +0200
> > > @@ -620,7 +620,7 @@
> > >  	}
> > >  	up(&parent_class->sem);
> > >  
> > > -	return 0;
> > > +	goto out1;
> > >  
> > 
> > Thanks for catching this.  I've merged this with Stephen's original
> > patch.
> > 
> > thanks again,
> > 
> > greg k-h
> 
> ditto, hmm, one more need for a test suite for basic driver stuff

If you know of some way to create one, I would be glad to have it...

thanks,

greg k-h
