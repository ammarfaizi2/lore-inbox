Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030360AbWARPv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030360AbWARPv1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 10:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030358AbWARPv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 10:51:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:38541 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030360AbWARPv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 10:51:26 -0500
Date: Wed, 18 Jan 2006 07:51:07 -0800
From: Greg KH <greg@kroah.com>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: clarity on kref needed.
Message-ID: <20060118155107.GA11895@kroah.com>
References: <3AEC1E10243A314391FE9C01CD65429B28BE86@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B28BE86@mail.esn.co.in>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 12:27:45PM +0530, Mukund JB. wrote:
> 
> Dear All,
> 
> I have gone through kref and am planning to implement then in my usb driver.

What kind of usb driver?

> please terminate my misconceptions if any by correcting the statements below.
> 
> In the call below:
> kref_init(&dev->kref);
> 	sets the refcount in the kref to 1.

Yes.

> kref_put(&dev->kref);
> 	increment the refcount.

Hm, don't you mean "kref_get()" here?  If so, yes, that is correct.

> kref_put(&dev->kref, mem_release );
> What I understand is when the refcount falls back to '1', only then
> the mem_release() function will be called.

No, when it falls to 0 it will be called.

> Is it correct? I mean, when is the mem_release () called i.e. when the
> refcount is '0' or '1'.

0.  There's an OLS paper from a few years ago that describes kref in
detail, as well as the in-kernel documentation of it (see the file
Documentation/kref.txt).  Did you read that?

thanks,

greg k-h
