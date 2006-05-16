Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbWEPQ1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbWEPQ1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWEPQ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:27:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751630AbWEPQ1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:27:20 -0400
Date: Tue, 16 May 2006 09:27:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: Jean Delvare <khali@linux-fr.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm1
Message-ID: <20060516092702.59bf2a71@localhost.localdomain>
In-Reply-To: <20060516160842.GA13497@suse.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	<20060515122613.32661c02.akpm@osdl.org>
	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
	<20060516103930.0c0d5d33.khali@linux-fr.org>
	<20060516145517.2c2d4fe4.khali@linux-fr.org>
	<20060516164846.4d42ed11.khali@linux-fr.org>
	<20060516172346.b729da01.khali@linux-fr.org>
	<20060516160842.GA13497@suse.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2006 09:08:42 -0700
Greg KH <gregkh@suse.de> wrote:

> On Tue, May 16, 2006 at 05:23:46PM +0200, Jean Delvare wrote:
> > Quoting myself:
> > > And the winner is...
> > > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > > 
> > > Stephen, Greg?
> > 
> > Indeed this patch breaks class_device_add in the success case...
> > 
> > Andrew, maybe you want to put this in the hot-fixes directory for
> > 2.6.17-rc1-mm4, as the problem hits all drivers which register with a
> > class.
> > 
> > Fix class_device_add success case after
> > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > broke it. class_dev was no more put and class_name was no more freed
> > before leaving. The former caused locks on driver removal (class_dev
> > usage count could never be 0.)
> > 
> > This fix should be folded into
> > gregkh-driver-driver-core-class_device_add-needs-error-checks.patch
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > ---
> >  drivers/base/class.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- linux-2.6.17-rc4-mm1.orig/drivers/base/class.c	2006-05-16 16:38:02.000000000 +0200
> > +++ linux-2.6.17-rc4-mm1/drivers/base/class.c	2006-05-16 17:00:24.000000000 +0200
> > @@ -620,7 +620,7 @@
> >  	}
> >  	up(&parent_class->sem);
> >  
> > -	return 0;
> > +	goto out1;
> >  
> 
> Thanks for catching this.  I've merged this with Stephen's original
> patch.
> 
> thanks again,
> 
> greg k-h

ditto, hmm, one more need for a test suite for basic driver stuff
