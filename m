Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSKTKJw>; Wed, 20 Nov 2002 05:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264983AbSKTKJw>; Wed, 20 Nov 2002 05:09:52 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:44811 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264908AbSKTKJv>; Wed, 20 Nov 2002 05:09:51 -0500
Date: Wed, 20 Nov 2002 13:16:29 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcibios removal changes for 2.5.48
Message-ID: <20021120131629.A21139@jurassic.park.msu.ru>
References: <20021120051702.GB21953@kroah.com> <20021120051751.GC21953@kroah.com> <20021120051820.GD21953@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021120051820.GD21953@kroah.com>; from greg@kroah.com on Tue, Nov 19, 2002 at 09:18:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 09:18:20PM -0800, Greg KH wrote:
>  #ifdef CONFIG_CARDBUS
>      if (s->state & SOCKET_CARDBUS) {
>  	u_int ptr;
> -	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
> +	struct pci_dev *dev = pci_find_slot (s->cap.cb_dev->subordinate->number, 0);
> +	if (!dev)
> +	    return CS_BAD_HANDLE;
> +	pci_read_config_dword(dev, 0x28, &ptr);
>  	tuple->CISOffset = ptr & ~7;
>  	SPACE(tuple->Flags) = (ptr & 7);
>      } else

pci_find_slot seems to be an overkill. Why not just
-	pcibios_read_config_dword(s->cap.cb_dev->subordinate->number, 0, 0x28, &ptr);
+	pci_bus_read_config_dword(s->cap.cb_dev->subordinate, 0, 0x28, &ptr);

?

Ivan.
