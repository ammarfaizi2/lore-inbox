Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSKZASa>; Mon, 25 Nov 2002 19:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbSKZASa>; Mon, 25 Nov 2002 19:18:30 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40975 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266122AbSKZAS3>;
	Mon, 25 Nov 2002 19:18:29 -0500
Date: Mon, 25 Nov 2002 16:18:04 -0800
From: Greg KH <greg@kroah.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021126001804.GH25269@kroah.com>
References: <20021120051702.GB21953@kroah.com> <20021120051751.GC21953@kroah.com> <20021120051820.GD21953@kroah.com> <20021120131629.A21139@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021120131629.A21139@jurassic.park.msu.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2002 at 01:16:29PM +0300, Ivan Kokshaysky wrote:
> On Tue, Nov 19, 2002 at 09:18:20PM -0800, Greg KH wrote:
> >  #ifdef CONFIG_CARDBUS
> >      if (s->state & SOCKET_CARDBUS) {
> >  	u_int ptr;
> > -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> > +	struct pci_dev *dev = pci_find_slot (s->cap.cb_dev->subordinate->number, 0);
> > +	if (!dev)
> > +	    return CS_BAD_HANDLE;
> > +	pci_read_config_dword(dev, 0x28, &ptr);
> >  	tuple->CISOffset = ptr & ~7;
> >  	SPACE(tuple->Flags) = (ptr & 7);
> >      } else
> 
> pci_find_slot seems to be an overkill. Why not just
> -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> +	pci_bus_read_config_dword(s->cap.cb_dev->subordinate, 0, 0x28, &ptr);

Heh, didn't think of that one, I guess it would work too :)

thanks,

greg k-h
