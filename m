Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUCDIKo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 03:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbUCDIKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 03:10:44 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:12690
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S261541AbUCDIKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 03:10:12 -0500
Message-ID: <4046E455.4010605@redhat.com>
Date: Thu, 04 Mar 2004 00:09:57 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040303
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.4-pre1_vsyscall-gtod_B3-part3 (3/3)
References: <1078359081.10076.191.camel@cog.beaverton.ibm.com>	 <1078359137.10076.193.camel@cog.beaverton.ibm.com>	 <1078359191.10076.195.camel@cog.beaverton.ibm.com>	 <1078359248.10076.197.camel@cog.beaverton.ibm.com>	 <20040304005542.GZ4922@dualathlon.random>  <40469194.5080506@redhat.com> <1078368197.10076.252.camel@cog.beaverton.ibm.com>
In-Reply-To: <1078368197.10076.252.camel@cog.beaverton.ibm.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

john stultz wrote:

> Before we start up this larger debate again, might there be some short
> term solution for my patch that would satisfy both of you?

I suggest the following:

~ define a symbol __kernel_gettimeofday_offset in the vdso's symbol
table.  This should be an absolute symbol containing the offset of the
gettimeofday implementation from the beginning of the vdso (the address
passed up in the auxiliary vector)

~ glibc can then use the equivalent of
dlsym("__kernel_gettimeofday_offset").  If the symbol is not defined,
it's not used (doh).  If it is defined, the final function address is
computed by adding the offset to the vdso address.


This ensures a direct jump and it still keeps the vdso relocatable
without modifying the symbol table.

- -- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD4DBQFARuRa2ijCOnn/RHQRAnITAKCeS30ShpbeadFA5n/TlaTOXYNzygCVG3tg
2HCPVqo5DRtQfUoKwLY6vQ==
=ST37
-----END PGP SIGNATURE-----
