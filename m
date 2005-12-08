Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVLHQ3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVLHQ3I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbVLHQ3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:29:07 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:34256 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S932198AbVLHQ3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:29:06 -0500
Subject: Re: [PATCH] Fix listxattr() for generic security attributes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel Drake <dsd@gentoo.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jmorris@namei.org
In-Reply-To: <43985B9D.60506@gentoo.org>
References: <43985B9D.60506@gentoo.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 08 Dec 2005 11:35:21 -0500
Message-Id: <1134059721.2366.250.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 16:13 +0000, Daniel Drake wrote:
> Commit f549d6c18c0e8e6cf1bf0e7a47acc1daf7e2cec1 introduced a generic fallback 
> for security xattrs, but appears to include a subtle bug.
> 
> Gentoo users with kernels with selinux compiled in, and coreutils compiled 
> with acl support, noticed that they could not copy files on tmpfs using 'cp'.
> 
> cp (compiled with acl support) copies the file, lists the extended attributes 
> on the old file, copies them all to the new file, and then exits. However the 
> listxattr() calls were failing with this odd behaviour:
> 
> llistxattr("a.out", (nil), 0)           = 17
> llistxattr("a.out", 0x7fffff8c6cb0, 17) = -1 ERANGE (Numerical result out of 
> range)
> 
> I believe this is a simple problem in the logic used to check the buffer 
> sizes; if the user sends a buffer the exact size of the data, then its ok :)
> 
> This patch solves the problem. Please apply for 2.6.15.
> More info can be found at http://bugs.gentoo.org/113138
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley
National Security Agency

