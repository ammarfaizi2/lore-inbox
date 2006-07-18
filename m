Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWGRRFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWGRRFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 13:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWGRRFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 13:05:03 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:20863 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932305AbWGRRFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 13:05:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gU/SMNx94kY6XXQMKIx1MmTXqmreekBFkFoqvoEET53wiGC6unJRlDS9vXekICuxmm3tSLIpJdo6NWxic+TsdnyXwmwln1/Mt4QqB4S4LoMeuKI1e6ic+cU2aop0e+JNsOcFj2titfQophxQmipeK7cki+AE5DrYXxtmispsbyQ=
From: Benjamin Cherian <benjamin.cherian.kernel@gmail.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Bug with USB proc_bulk in 2.4 kernel
Date: Tue, 18 Jul 2006 10:04:54 -0700
User-Agent: KMail/1.8.1
References: <mailman.1152332281.24203.linux-kernel2news@redhat.com> <200607171435.22128.benjamin.cherian.kernel@gmail.com> <20060717151940.5cd79087.zaitcev@redhat.com>
In-Reply-To: <20060717151940.5cd79087.zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devl@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607181004.55191.benjamin.cherian.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

> It's the same kind of question as, "who even uses 2.4 anymore".
We asked to same question to the user who told us about this bug :-). It 
happened after the user built his own kernel (2.4.32) for Fedora Core 1, 
which uses a much older version.
> By the way, did you consider an in-kernel driver? For me, it seems much
> safer to reimplement the whole thing that way than to monkey with devio
> again and risk more regressions.
We're currently using libusb. We don't have to time to patch and maintain a 
driver that's actually in the tree. And our customers are definitely not 
going to patch and build their own kernel either.

> Another option would be to change USBDEVFS_BULK to USBDEVFS_SUBMITURB.
> Did you look at doing that?
We did that as well. But when you try to reap an URB there is no timeout. So 
if something goes wrong you're stuck waiting for the operation to finish or 
for the user to physically unplug the device.

>Of course it's very tempting for me to off-load both
>the work and the responsibility on you.

All right then. I'll send you a patch that backports the string caching 
mechanism from 2.6 in a few days. Would you be able to test it with the 
210PU?

Thanks,

Ben
