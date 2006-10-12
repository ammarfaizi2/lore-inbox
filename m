Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWJLPpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWJLPpI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWJLPpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:45:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:22302 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932637AbWJLPpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:45:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=F5kEardhS8wwdR4AT9Cr6XvAWZNOQdJzL4m4MBgJsBYWssTjEl1LQHWZr+ndSKDJa4epbl9ARLpMatAL9lATXx/AHkqpYWUoq1UmAm0fS7akNBYXq7nM4VmMH8nC0SpjNkJdABeEJVGZA4APwFmKNFSjheYny/vGnqG7vT1ucQ0=
Date: Thu, 12 Oct 2006 17:45:05 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.19-rc1] radeonfb: check return value of sysfs_create_bin_file
Message-ID: <20061012154505.GA6014@dreamland.darkstar.lan>
References: <20061011235328.GA13264@dreamland.darkstar.lan> <1160611646.4792.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160611646.4792.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Oct 12, 2006 at 10:07:26AM +1000, Benjamin Herrenschmidt ha scritto: 
> On Thu, 2006-10-12 at 01:53 +0200, Luca Tettamanti wrote:
> > sysfs_create_bin_file() is marked as warn_unused_result but we don't
> > actually check the return value.
> > Error is not fatal, the driver can operate fine without the files so
> > just print a notice on failure.
> 
> I find this whole business of must check return value for sysfs files to
> be gratuitous bloat. There are many cases (like this one) where we don't
> really care and a printk will just increase the kernel size for no good
> reason.
> 
> Maybe we can have a macro we can use to silence the warning when we
> don't care about the result ? Can gcc do that ?

Ugly macro:

#define UNCHECKED(func) do { if (func) {} } while(0)

maybe it's better to have something like this:

int __sysfs_create_bin_file(...);
inline int sysfs_create_bin_file(...) __attribute__((warn_unused_result));

inline int sysfs_create_bin_file(...) {
        return __sysfs_create_bin_file(...);
}

i.e. both checked and uncheck version of the same function.

Luca
-- 
Un apostolo vedendo Gesu` camminare sulle acque:
- Cazzo se e` buono 'sto fumo!!!
