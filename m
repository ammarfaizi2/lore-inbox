Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUCEOg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 09:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbUCEOg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 09:36:56 -0500
Received: from ozlabs.org ([203.10.76.45]:18613 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262612AbUCEOeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 09:34:50 -0500
Subject: Re: [RFC] add kobject to struct module
From: Rusty Russell <rusty@rustcorp.com.au>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040224232940.GA3140@kroah.com>
References: <Pine.LNX.4.33.0309100807430.1012-100000@localhost.localdomain>
	 <20030911011644.DA21C2C335@lists.samba.org>
	 <20040224232940.GA3140@kroah.com>
Content-Type: multipart/mixed; boundary="=-pcZhvMtZ2Xx9NiLLySld"
Message-Id: <1078497241.2492.908.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 01:34:02 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pcZhvMtZ2Xx9NiLLySld
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-02-25 at 10:29, Greg KH wrote:
> So, here's a patch on top of your patch (full patch against 2.6.3 is
> below), that simply makes the module reference file be owned by the
> module that it is assigned to.  Yes, this means that when you actually
> read the file value, the reference is 1 greater than when it is closed,
> but that's the breaks.  It does solve the "grab the file and then try to
> unload the module" problem, as it simply prevents this from happening.
> 
> Comments?

I've rewritten your rewrite again 8)

This patch actually implements module_param in sysfs for modules.  You
can see my tests in crypto_null().

What's missing is inbuilt modules.  I think /sys/modules/ne2k/debug
should exist whether ne2k is built-in or modular, for example.  Since
the only thing we have is a kparam with "ne2k.debug" as its name, there
will have to be some kludgery here, but we can end up with something OK.

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

--=-pcZhvMtZ2Xx9NiLLySld
Content-Disposition: attachment; filename=module_kobject.patch.gz
Content-Type: application/x-gzip; name=module_kobject.patch.gz
Content-Transfer-Encoding: base64

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
RigAAA==

--=-pcZhvMtZ2Xx9NiLLySld--

