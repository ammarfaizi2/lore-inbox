Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161411AbWI2AFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161411AbWI2AFZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161412AbWI2AFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:05:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:36007 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161411AbWI2AFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:05:25 -0400
Date: Thu, 28 Sep 2006 17:05:24 -0700
From: Greg KH <gregkh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] More USB patches for 2.6.18
Message-ID: <20060929000524.GA1625@suse.de>
References: <20060928224250.GA23841@kroah.com> <Pine.LNX.4.64.0609281639040.3952@g5.osdl.org> <20060928165951.2c5bd4c7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928165951.2c5bd4c7.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:59:51PM -0700, Andrew Morton wrote:
> On Thu, 28 Sep 2006 16:40:23 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > 
> > On Thu, 28 Sep 2006, Greg KH wrote:
> > >
> > > Here are some more USB bugfixes and device ids 2.6.18.  They should all
> > > fix the reported problems in your current tree (if not, please let me
> > > know.)
> > > 
> > > All of these changes have been in the -mm tree for a while.
> > 
> > Maybe I shouldn't have hurried you.
> > 
> > 	In file included from drivers/usb/host/ohci-hcd.c:140:
> > 	drivers/usb/host/ohci-hub.c: In function 'ohci_rh_resume':
> > 	drivers/usb/host/ohci-hub.c:184: error: invalid storage class for function 'ohci_restart'
> > 	drivers/usb/host/ohci-hub.c:188: warning: implicit declaration of function 'ohci_restart'
> > 	drivers/usb/host/ohci-hcd.c: At top level:
> > 	drivers/usb/host/ohci-hcd.c:815: error: static declaration of 'ohci_restart' follows non-static declaration
> > 	drivers/usb/host/ohci-hub.c:188: error: previous implicit declaration of 'ohci_restart' was here
> > 	make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> > 	make[2]: *** [drivers/usb/host] Error 2
> > 	make[1]: *** [drivers/usb] Error 2
> > 	make: *** [drivers] Error 2
> > 
> 
> That's the "some gccs dont like static function decls in that scope" thing.
> 
> I fixed it (unpleasantly) like this:
> 
> 
> diff -puN drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack drivers/usb/host/ohci-hub.c
> --- a/drivers/usb/host/ohci-hub.c~ohci-add-auto-stop-support-hack-hack
> +++ a/drivers/usb/host/ohci-hub.c
> @@ -132,6 +132,10 @@ static inline struct ed *find_head (stru
>  	return ed;
>  }
>  
> +#ifdef CONFIG_PM
> +static int ohci_restart(struct ohci_hcd *ohci);
> +#endif

That #ifdef shouldn't be even needed.

I'll add a patch to the git tree to fix this up, give me a few
minutes...

thanks,

greg k-h
