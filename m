Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbVLHQ3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbVLHQ3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbVLHQ3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:29:48 -0500
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:48026 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932202AbVLHQ3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:29:47 -0500
Date: Thu, 8 Dec 2005 11:29:44 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Daniel Drake <dsd@gentoo.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sds@tycho.nsa.gov
Subject: Re: [PATCH] Fix listxattr() for generic security attributes
In-Reply-To: <43985B9D.60506@gentoo.org>
Message-ID: <Pine.LNX.4.63.0512081129300.24323@excalibur.intercode>
References: <43985B9D.60506@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005, Daniel Drake wrote:

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

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>
