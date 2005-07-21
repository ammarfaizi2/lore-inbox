Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261722AbVGUJjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbVGUJjw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 05:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVGUJjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 05:39:52 -0400
Received: from ns.firmix.at ([62.141.48.66]:34464 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S261722AbVGUJju (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 05:39:50 -0400
Subject: Re: a 15 GB file on tmpfs
From: Bernd Petrovitsch <bernd@firmix.at>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Bastiaan Naber <naber@inl.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <42DF671B.8020809@stesmi.com>
References: <200507201416.36155.naber@inl.nl>
	 <1121935332.21421.10.camel@tara.firmix.at>  <42DF671B.8020809@stesmi.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Thu, 21 Jul 2005 11:39:44 +0200
Message-Id: <1121938784.21421.18.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-21 at 11:12 +0200, Stefan Smietanowski wrote:
[...]
> On a 64bit machine:
> $ gcc test.c -o test64 ; ./test64; file ./test64
> sizeof(void *): 8
> sizeof(size_t): 8
> test64: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for
> GNU/Linux 2.4.0, dynamically linked (uses shared libs), not stripped
> 
> On a 32bit machine (or in this case, 32bit userland on a 64bit machine):
> $ gcc -m32 test.c -o test32 ; ./test32; file ./test32
> sizeof(void *): 4
> sizeof(size_t): 4
> test32: ELF 32-bit LSB executable, Intel 80386, version 1 (SYSV), for
> GNU/Linux 2.2.5, dynamically linked (uses shared libs), not stripped
> 
> Meaning both the pointer and the size argument are only 32bit (4byte)
> on 32-bit arches and 64bit (8 byte) on 64bit arches.

Which means that pure addressing of the 15GB on 32bit archs needs
explicit handling (yes, you can manage the offset in a "long long" but
you cannot index anything with it not addressable with a 32bit offset).

Well, 64bit is apparently the way to go ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

