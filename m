Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267487AbUHSWpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267487AbUHSWpr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267489AbUHSWpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:45:47 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:38302 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267487AbUHSWpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:45:46 -0400
From: jmerkey@comcast.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: 2.6.8 kmem_cache_alloc barfs
Date: Thu, 19 Aug 2004 22:45:45 +0000
Message-Id: <081920042245.28325.41252D98000E459100006EA52200734840970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

regparm=3 in an external modules build creates this problem if you reference internal 
linux includes and makefile commands from an externally built module.  I notice stack 
passing is on where it needs to be in exported symbols **IF** they are defined properly.
There are some holes with this for folks creating external modules that call into a kernel
with objects that are mismatched from the compile.

This was the source of the bug.

Jeff


> On Thu, Aug 19, 2004 at 06:18:20PM +0000, jmerkey@comcast.net wrote:
> > 
> > in 2.6.8 with all features and config options (at least those that will build) 
> with 4GB memory option selected, kmem_cache_alloc crashes when called with 
> requests for 64KB chunks of memory which exceed the kernel address space of 1GB 
> in size rather than returning an out of memory error.  
> 
> testcase please.
> 
