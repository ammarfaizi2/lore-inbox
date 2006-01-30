Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWA3R5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWA3R5J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 12:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWA3R5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 12:57:08 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:10696 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964847AbWA3R5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 12:57:06 -0500
Subject: Re: [Xen-devel] Re: [PATCH 2.6.12.6-xen] sysfs attributes for xen
From: Dave Hansen <haveblue@us.ibm.com>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Greg KH <greg@kroah.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, "Mike D. Day" <ncmike@us.ibm.com>
In-Reply-To: <26c21a6abef89d4629a0da08bc0ba9bf@cl.cam.ac.uk>
References: <43DAD4DB.4090708@us.ibm.com>
	 <1138637931.19801.101.camel@localhost.localdomain>
	 <43DE45A4.6010808@us.ibm.com>
	 <1138640666.19801.106.camel@localhost.localdomain>
	 <43DE4A1D.4050501@us.ibm.com>
	 <1138642737.22903.14.camel@localhost.localdomain>
	 <26c21a6abef89d4629a0da08bc0ba9bf@cl.cam.ac.uk>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 09:56:53 -0800
Message-Id: <1138643813.22903.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 17:53 +0000, Keir Fraser wrote:
> On 30 Jan 2006, at 17:38, Dave Hansen wrote:
> 
> > Yes, they are.  Buuuuuuut, you _can_ make the code around them a little
> > less evil.  If you _must_ use a typedef, you could do something like
> > this:
> >
> > #define XEN_CAP_INFO_LEN_BYTES 1024
> > typedef char [XEN_CAP_INFO_LEN_BYTES] xen_capabilities_info_t;
> 
> Is that really better than just referencing the typedef? I've always 
> considered them okay for simple scalar and array types, even if they 
> are to be avoided for structure types.

One reason they're "evil" is that they hide what is going on.  It is
worse for structures, but doing it for arrays still hides what is there,
and a hapless programmer can easily jump off the end of the stack
without realizing it.  I think the kernel style is to be as explicit as
possible, especially when it isn't too verbose.

In this case, I expect a programmer declaring a 'char foo[XEN_FOO]'
array on the stack to be much more likely to go look up how big XEN_FOO
is than one who sees a 'xen_capabilities_info_t foo'.

> Is it the size aspect that is 
> the problem (e.g., a typedef'ed type should be okay to allocate on the 
> stack)?

The size is the issue.  A typedef just makes it a little bit harder to
track down.  That's why typedefs are evil. ;)

-- Dave

