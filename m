Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263380AbTCNPya>; Fri, 14 Mar 2003 10:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263381AbTCNPya>; Fri, 14 Mar 2003 10:54:30 -0500
Received: from 237.oncolt.com ([213.86.99.237]:49092 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263380AbTCNPy2>; Fri, 14 Mar 2003 10:54:28 -0500
Subject: Re: [PATCH] Fix stack usage for amd_flash.c
From: David Woodhouse <dwmw2@infradead.org>
To: Joern Engel <joern@wohnheim.fh-wedel.de>
Cc: Jonas Holmberg <jonas.holmberg@axis.com>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030314154642.GC27154@wohnheim.fh-wedel.de>
References: <20030314154642.GC27154@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1047657910.14792.153.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4.dwmw2) 
Date: 14 Mar 2003 16:05:10 +0000
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-14 at 15:46, Joern Engel wrote:
> Hi!
> 
> This patch reduces the stack usage of amd_flash_probe by a couple of
> kByte.

Urgh. That should never have been on the stack in the first place. Make
it static. The comment about being deallocated when the probe is done is
bogus -- where do we think we get the contents of the table from when
_entering_ the probe function anyway? It's elsewhere in the kernel
image.

>  The target of freeing the memory after probe should be reached
> with __initdata as well. Untested, though.
> 
> Is it ok to apply?

No. You can't make that __initdata because the functions which _call_ it
aren't __init. You can load map drivers (e.g. pcmcia) as modules which
try to probe for all kinds of chips.  

Also note that all but the CFI-based drivers are deprecated. We have
old-style probes which allow us to use the CFI back-end drivers with
non-CFI chips anyway.

> J?rn

Btw you're sending out 8-bit mail with charset 'unknown-8bit'. What
should be a ö isn't.

-- 
dwmw2

