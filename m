Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754065AbWKLGfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754065AbWKLGfz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 01:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbWKLGfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 01:35:55 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:38801 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1754065AbWKLGfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 01:35:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=kxgp/OTFXXrEa4de6j6ScWeUPj+cN6Cb0oFRp4ASrwXmmyewxC16LFIwl88Dj+plROPr1VFXMM8twzTSMeGCCcBpt0+4o4zgA+aVN58tKVr2r+PKuRD45ysdEMme2KlaXaHaHdwklqFBQZyWP3OCtbhLi8jvE+O9v6tkGfAOXrE=  ;
X-YMail-OSG: q.r_MJYVM1lCeb_t0AXjI2MrcK7vTB6wVaNHZg0H0Wks7Vu217vl.4qBulF25s8gNmKR5TGlhTBqXyngW_kXcTyB7WYlm7ydqhJNGiDirv47LxL4B0Tbjw--
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] drivers/usb/gadget/ether.c: NULL dereference
Date: Sat, 11 Nov 2006 22:35:48 -0800
User-Agent: KMail/1.7.1
Cc: Adrian Bunk <bunk@stusta.de>, greg@kroah.com, linux-kernel@vger.kernel.org
References: <20061111160643.GA8809@stusta.de>
In-Reply-To: <20061111160643.GA8809@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611112235.49931.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 November 2006 8:06 am, Adrian Bunk wrote:
> The Coverity checker spotted the following NULL dereference of "skb" in 
> drivers/usb/gadget/ether.c:

I don't see such a dereference.  As usual, free(NULL) is legit.

Is this another case of bogus reports from Coverity?  I still need to
revert a bug in the EHCI debug code caused by someone "fixing" it
because Coverity doesn't understand unions...


> <--  snip  -->
> 
> ...
> static int
> rx_submit (struct eth_dev *dev, struct usb_request *req, gfp_t gfp_flags)
> {
>         struct sk_buff          *skb;
>         int                     retval = -ENOMEM;
> ...
>         if ((skb = alloc_skb (size + NET_IP_ALIGN, gfp_flags)) == 0) {
>                 DEBUG (dev, "no rx skb\n");
>                 goto enomem;
>         }
> ...
> enomem:
>                 defer_kevent (dev, WORK_RX_MEMORY);
>         if (retval) {
>                 DEBUG (dev, "rx submit --> %d\n", retval);
>                 dev_kfree_skb_any (skb);
> ...
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
