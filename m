Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751093AbWD3K5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbWD3K5n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 06:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWD3K5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 06:57:43 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:40205 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751093AbWD3K5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 06:57:43 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Dave Jones <davej@redhat.com>, devzero@web.de,
       linux-kernel@vger.kernel.org
Subject: Re: another kconfig target for building monolithic kernel (for security) ?
References: <1093777985@web.de> <20060429164331.GA26122@redhat.com>
	<1146345747.3125.14.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: Our Lady of Perpetual Garbage Collection
Date: Sun, 30 Apr 2006 11:57:27 +0100
In-Reply-To: <1146345747.3125.14.camel@laptopd505.fenrus.org> (Arjan van de Ven's message of "29 Apr 2006 22:24:03 +0100")
Message-ID: <87y7xn72lk.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Apr 2006, Arjan van de Ven prattled cheerily:
> On Sat, 2006-04-29 at 12:43 -0400, Dave Jones wrote:
>> On Sat, Apr 29, 2006 at 03:03:55PM +0200, devzero@web.de wrote:
>> 
>>  > i want to harden a linux system (dedicated root server on the internet) by recompiling the kernel without support for lkm (to prevent installation of lkm based rootkits etc)
>> 
>> Loading modules via /dev/kmem is trivial thanks to a bunch of tutorials and
>> examples on the web, so this alone doesn't make life that much more difficult for attackers.
> 
> /dev/kmem should be a config option too though

Yeah, but in practice this should work (somewhat old patch, should still
apply):

diff -durN 2.6.14-seal-orig/include/linux/capability.h 2.6.14-seal/include/linux/capability.h
--- 2.6.14-seal-orig/include/linux/capability.h	2005-10-29 15:15:00.000000000 +0100
+++ 2.6.14-seal/include/linux/capability.h	2005-10-29 15:25:48.000000000 +0100
@@ -311,7 +311,7 @@
 
 #define CAP_EMPTY_SET       to_cap_t(0)
 #define CAP_FULL_SET        to_cap_t(~0)
-#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
+#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP) & ~CAP_TO_MASK(CAP_SYS_RAWIO))
 #define CAP_INIT_INH_SET    to_cap_t(0)
 
 #define CAP_TO_MASK(x) (1 << (x))

> (and /dev/mem should get the filter patch that fedora has ;-) 

Agreed.

-- 
`On a scale of 1-10, X's "brokenness rating" is 1.1, but that's only
 because bringing Windows into the picture rescaled "brokenness" by
 a factor of 10.' --- Peter da Silva
