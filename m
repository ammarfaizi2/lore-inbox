Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULWVDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULWVDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbULWVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:03:05 -0500
Received: from cdc868fe.powerlandcomputers.com ([205.200.104.254]:15437 "EHLO
	pl6w2kex.lan.powerlandcomputers.com") by vger.kernel.org with ESMTP
	id S261300AbULWVCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:02:51 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: My vision of usbmon
Date: Thu, 23 Dec 2004 15:02:49 -0600
Message-ID: <18DFD6B776308241A200853F3F83D5072851@pl6w2kex.lan.powerlandcomputers.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: My vision of usbmon
Thread-Index: AcTn5VmIXX9fNID5QXqN2Jy/XHIuNgAkMNHg
From: "Chad Kitching" <CKitching@powerlandcomputers.com>
To: "Greg KH" <greg@kroah.com>, "Pete Zaitcev" <zaitcev@redhat.com>
Cc: <linux-usb-devel@lists.sourcefoge.net.kroah.org>,
       <linux-kernel@vger.kernel.org>, <laforge@gnumonks.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH [mailto:greg@kroah.com]
> Sent: December 21, 2004 11:11 PM
> Subject: Re: My vision of usbmon
> 
> -/* exported only within usbcore */
> -struct usb_bus *usb_bus_get (struct usb_bus *bus)
> +struct usb_bus *usb_bus_get(struct usb_bus *bus)
>  {
> -	struct class_device *tmp;
> -
> -	if (!bus)
> -		return NULL;
> -
> -	tmp = class_device_get(&bus->class_dev);
> -	if (tmp)        
> -		return to_usb_bus(tmp);
> -	else
> -		return NULL;
> +	if (bus)
> +		class_device_get(&bus->class_dev);
> +	return bus; 
>  }
> +EXPORT_SYMBOL_GPL(usb_bus_get);
  
I'm not familiar with this code, but if the replacement code is 
equivalent, is there any point to the return usb_bus pointer?  With 
the replacement, you should always get the same pointer you put 
into it.  If that is the case, why not remove the return value, and 
change drivers/usb/core/usb.c to match?

Chad Kitching
