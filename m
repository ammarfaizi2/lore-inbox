Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265905AbUEUOxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265905AbUEUOxD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 10:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265907AbUEUOxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 10:53:03 -0400
Received: from [141.156.69.115] ([141.156.69.115]:27046 "EHLO
	mail.infosciences.com") by vger.kernel.org with ESMTP
	id S265905AbUEUOw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 10:52:58 -0400
Message-ID: <40AE17C9.9010600@infosciences.com>
Date: Fri, 21 May 2004 10:52:57 -0400
From: nardelli <jnardelli@infosciences.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] visor: Fix Oops on disconnect
References: <40AD3A88.2000002@infosciences.com>	<20040521043032.GA31113@kroah.com> <20040520220317.2f6f1f2a.zaitcev@redhat.com>
In-Reply-To: <20040520220317.2f6f1f2a.zaitcev@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> On Thu, 20 May 2004 21:30:32 -0700
> Greg KH <greg@kroah.com> wrote:
> 
> 
>>>-	if (!port->read_urb) {
>>>+	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
>>>+	{
> 
> 
>>Your patch says that we might not have a read_urb for the given port?
>>How could that be true?  The check here in open() will catch any devices
>>that this might not be correct for.  So that portion of this patch is
>>not needed, right?
> 
> 
> I know nothing about Palms, but also that part contradicted a comment.
> 
> -	if (!port->read_urb) {
> +	if ((serial->dev->descriptor.idVendor != SONY_VENDOR_ID && !port->read_urb))
> +	{
>  		/* this is needed for some brain dead Sony devices */
> 
> So.... the patch makes the body of the if to be used when it's NOT Sony,
> but the comment says that it's intended for Sony. I think it's fishy.

Oops - that does look a little fishy.  I'll revisit.

> 
> -- Pete
> 


-- 
Joe Nardelli
jnardelli@infosciences.com
