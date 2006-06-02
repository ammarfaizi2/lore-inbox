Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbWFBKLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbWFBKLs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 06:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWFBKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 06:11:48 -0400
Received: from aa001msg.fastwebnet.it ([213.140.2.68]:64227 "EHLO
	aa001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751366AbWFBKLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 06:11:47 -0400
Date: Fri, 2 Jun 2006 12:09:52 +0200
From: Paolo Ornati <ornati@fastwebnet.it>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc5-mm2
Message-ID: <20060602120952.615cea39@localhost>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.3.0-rc3 (GTK+ 2.8.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_7ZhMk77KYmH7=yWafqQ9Np0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_7ZhMk77KYmH7=yWafqQ9Np0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 1 Jun 2006 01:48:06 -0700
Andrew Morton <akpm@osdl.org> wrote:

> - Various lock-validator and genirq fixes have been added.  Should be
>   slightly less oopsy than 2.6.17-rc5-mm1.

Is it supposed to work on x86_64?

I've tried enabling something minimal (full config attached):

CONFIG_PROVE_SPIN_LOCKING=y
# CONFIG_PROVE_RW_LOCKING is not set
# CONFIG_PROVE_MUTEX_LOCKING is not set
# CONFIG_PROVE_RWSEM_LOCKING is not set
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_TRACE_IRQFLAGS=y
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_FRAME_POINTER=y
# CONFIG_UNWIND_INFO is not set
CONFIG_FORCED_INLINING=y

---

and I get unexpected failures in the validator self test, and then a
kernel panic. Something like this:

[test output]
--------------------------------------------------------------
BUG: 21 unexpected failures (out of 210) - debugging disabled!
--------------------------------------------------------------
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 252144 bytes)
Checking apeture...
CPU 0: aperture @ [...] size 64 MB
Memory: [....]
kmem_cache_create: couldn't create cache size-512.
kernel panic - not syncing: kmem_cache_create(): failed to create slab 'size-512'


Bad quality snapshots:
http://img92.imageshack.us/img92/446/02060610499mx.jpg
http://img137.imageshack.us/img137/29/02060610501qr.jpg

-- 
	Paolo Ornati
	Linux 2.6.16-ck11 on x86_64

--MP_7ZhMk77KYmH7=yWafqQ9Np0
Content-Type: application/x-gzip; name=config.gz
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config.gz

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
bFMyyGdSaP3tNff/sEmNiWMYAAA=

--MP_7ZhMk77KYmH7=yWafqQ9Np0--
