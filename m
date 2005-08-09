Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVHIJxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVHIJxg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 05:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbVHIJxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 05:53:35 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:3267 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932494AbVHIJxf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 05:53:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p2jt/yY0Pwux2ujbJdROZRALw16rylihZoE6Sbm35n8f6J6PoxQh1JGBi3zyExSK6lKjLc3SAv7MyT9qC+suGgF6q2ohMPtXNvM0ZzcM9wgYPIUrHNh1EVv0QxOwdboJoFxQhvjUaFHn4CGPyT4eBJj0nTG6HZcdRlj4veXeiLk=
Message-ID: <4af2d03a05080902533bc80b92@mail.gmail.com>
Date: Tue, 9 Aug 2005 11:53:34 +0200
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] removes pci_find_device from i6300esb.c
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20050808233429.36e6ebd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F73523.80205@gmail.com>
	 <200508082355.j78NtGNS029681@wscnet.wsc.cz>
	 <20050808233429.36e6ebd5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[lkml sorry for reposting, but my nat was on cbl blacklist again, grrr.]

On 8/9/05, Andrew Morton <akpm@osdl.org> wrote:
> Jiri Slaby <jirislaby@gmail.com> wrote:
> >
> > --- a/drivers/char/watchdog/i6300esb.c
> >  +++ b/drivers/char/watchdog/i6300esb.c
> >  @@ -368,12 +368,11 @@ static unsigned char __init esb_getdevic
> >            *      Find the PCI device
> >            */
> >
> >  -        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
> >  +        for_each_pci_dev(dev)
> >                   if (pci_match_id(esb_pci_tbl, dev)) {
> >                           esb_pci = dev;
> >                           break;
> >                   }
> >  -        }
> >
> >           if (esb_pci) {
> >               if (pci_enable_device(esb_pci)) {
> >  @@ -430,6 +429,7 @@ err_release:
> >               pci_release_region(esb_pci, 0);
> >   err_disable:
> >               pci_disable_device(esb_pci);
> >  +            pci_dev_put(esb_pci);
> 
> That doesn't look right.  Each iteration of for_each_pci_dev() needs a
> pci_dev_put(), not just the final one.
> 
But pci_get_device do it for us in pci_get_subsys, line 249 in
pci/search.c, doesn't it?
