Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWA3REh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWA3REh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:04:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWA3REh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:04:37 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:59788 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964783AbWA3REg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:04:36 -0500
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
From: Dave Hansen <haveblue@us.ibm.com>
To: "Mike D. Day" <ncmike@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <43DE45A4.6010808@us.ibm.com>
References: <43DAD4DB.4090708@us.ibm.com>
	 <1138637931.19801.101.camel@localhost.localdomain>
	 <43DE45A4.6010808@us.ibm.com>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:04:25 -0800
Message-Id: <1138640666.19801.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 11:58 -0500, Mike D. Day wrote:
> Dave Hansen wrote:
> > Where does that 1024 come from?  Is it a guarantee from Xen that it will
> > never fill more than 1k?  I know it is a long shot, but what if the page
> > size is less than 1k?  Would this function have strange results?
> 
> Per the xen headers, this particular hcall option returns a typedef
> char[1024] thingy_t (which is simply a char [1024] in the patch). Yes,
> if the page size is < 1024 there is a problem. So a check against
> PAGE_SIZE may be prudent. 

I was just looking, and noticed that there is a check in the sysfs
->show() code that checks for return values greater than PAGE_SIZE and
BUG()s, so you at least won't get silent corruption.  That is probably
good enough to not worry about it.

In the final version, there will be available Xen headers, and the patch
won't need the open-coded 1024?

-- Dave

