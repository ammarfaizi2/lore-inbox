Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277620AbRJHXmM>; Mon, 8 Oct 2001 19:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277621AbRJHXmC>; Mon, 8 Oct 2001 19:42:02 -0400
Received: from t2.redhat.com ([199.183.24.243]:7665 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S277620AbRJHXlu>; Mon, 8 Oct 2001 19:41:50 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011008.160854.08322122.davem@redhat.com> 
In-Reply-To: <20011008.160854.08322122.davem@redhat.com>  <15294.24873.866942.423260@cargo.ozlabs.ibm.com> <13962.1002580586@redhat.com> <14658.1002582388@redhat.com> 
To: "David S. Miller" <davem@redhat.com>
Cc: frival@zk3.dec.com, paulus@samba.org, Martin.Bligh@us.ibm.com,
        alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, jay.estabrook@compaq.com,
        rth@twiddle.net
Subject: Re: [PATCH] change name of rep_nop 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Oct 2001 00:42:04 +0100
Message-ID: <15384.1002584524@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davem@redhat.com said:
>  Example of this on ix86?

AGP and ACPI are the cases which already use it. Of course if it was
x86-only code it wouldn't matter if we kept on calling it wbinvd().

The case which originally drew my attention was something which hasn't been
implemented yet - flash drivers where you need a cached mapping in order to
do burst reads from the chip, but obviously you still need to be able to
flush the cache on demand. 

In fact, this is something we probably won't do on x86 - only on other
architectures. You need both cached and uncached mappings of the chip to
make this work (although often you have physical aliases so even on x86 you
can map one address cached and another uncached), and also you don't have
fine-grained flushes of selected ranges on x86 so it's likely to have a very
noticeable effect on performance - so much so that it's probably worth just
doing it all uncached in the first place.

But x86 isn't particularly interesting - it'd be useful to have a 
flush_dcache_range() which actually works across other architectures anyway.

> Regardless, the purpose of the cachetlb.txt interfaces is for the
> generic VM subsystem of the kernel.  Nothing more. 

So they should probably have less misleading names, perchance including the
letter 'v' and the letter 'm' somewhere? And they should _certainly_ have
less misleading documentation. :)

--
dwmw2


