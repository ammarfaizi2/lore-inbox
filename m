Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751496AbWENRmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbWENRmv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 13:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWENRmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 13:42:51 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:27365 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751496AbWENRmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 13:42:50 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.17-rc4 6/6] Remove some of the kmemleak false positives
Date: Sun, 14 May 2006 19:39:50 +0200
User-Agent: KMail/1.9.1
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org
References: <20060513155757.8848.11980.stgit@localhost.localdomain> <84144f020605140755w4c64dc14o8beda9f5bbb68b9c@mail.gmail.com> <44674F17.2050606@gmail.com>
In-Reply-To: <44674F17.2050606@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605141939.51288.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Sunday, 14. May 2006 17:39, Catalin Marinas wrote:
> Yet another false positive can be caused by allocation of a size that
> differs from the structure's size (kmalloc(sizeof(struct...) + ...)) and
> kmemleak cannot properly determine the container_of aliases. One example
> is the platform_device_alloc function and a false positive is in
> add_pcspkr in arch/i386/kernel/setup.c.
> 
> I'll do more testing and post a new version next week (which will
> include the suggestions I received so far).

While we are at it: How do you handle the encoding of
info into the lower bits of a pointer? For Boehm GC, 
this was a major problem, AFAIR. At least the RT-Mutex code
does this. There are others, but I'm to lazy to grep now...

Regards

Ingo Oeser
