Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281621AbRKUGWd>; Wed, 21 Nov 2001 01:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281623AbRKUGWX>; Wed, 21 Nov 2001 01:22:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56975 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281621AbRKUGWM>;
	Wed, 21 Nov 2001 01:22:12 -0500
Date: Tue, 20 Nov 2001 22:22:03 -0800 (PST)
Message-Id: <20011120.222203.58448986.davem@redhat.com>
To: jmerkey@vger.timpanogas.org
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
 opcode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011121001639.A813@vger.timpanogas.org>
In-Reply-To: <20011121001639.A813@vger.timpanogas.org>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Your code is violating one of the assertions in
kmem_cache_create(), check the BUG(); calls in
mm/slab.c:kmem_cache_create() to try and figure out
which one you are firing off.

Probably either you are trying to send it debug flags
but CONFIG_SLAB_DEBUG is not defined _OR_ you are trying
to create the same SLAB cache twice (forgetting to destroy
it on module unload perhaps)?

Slab if fine, it's your code which is busted :)
