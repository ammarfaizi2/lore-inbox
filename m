Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbTI3Xug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbTI3Xug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:50:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:64743 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261798AbTI3Xuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:50:32 -0400
Date: Tue, 30 Sep 2003 16:36:02 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5] USB speedtouch: reduce memory usage
Message-ID: <20030930233602.GC21422@kroah.com>
References: <200309292337.08915.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309292337.08915.baldrick@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 11:37:08PM +0200, Duncan Sands wrote:
> Currently, incoming packets are reassembled in a sk_buff which is then
> sent to the upper layers.  The sk_buff needs to be big enough to hold the
> worst case packet since the size cannot be known in advance.  This would
> not be so bad if the ATM layer paid attention to the mtu (usually 1500 bytes),
> but for some reason it blithely ignores it and typically passes 9188 bytes
> as the maximum size.  This means that at best 5/6 of the space in every
> sk_buff is wasted.  So instead let's just allocate an assembly buffer (sarb)
> which gets reused for every packet, and copy each assembled packet into
> a minimally sized sk_buff before sending.
>  
> 
>  speedtch.c |  106 +++++++++++++++++++++++++++++++------------------------------
>  1 files changed, 55 insertions(+), 51 deletions(-)


Applied, thanks.

greg k-h

