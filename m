Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277038AbRJDA3u>; Wed, 3 Oct 2001 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277039AbRJDA3a>; Wed, 3 Oct 2001 20:29:30 -0400
Received: from palrel10.hp.com ([156.153.255.245]:41229 "HELO palrel10.hp.com")
	by vger.kernel.org with SMTP id <S277038AbRJDA3Z>;
	Wed, 3 Oct 2001 20:29:25 -0400
Date: Wed, 3 Oct 2001 17:29:49 -0700
Message-Id: <200110040029.f940Tn103671@wailua.hpl.hp.com>
From: David Mosberger <davidm@hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: ioremap() vs. ioremap_nocache()
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Reply-To: davidm@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen was kind enough to point out a longstanding
mis-conception that I had about ioremap(): I thought that ioremap()
was being deprecated in favor of ioremap_nocache() because the former
does not clearly define what kind of memory attribute will be used to
access the mapped memory (cached, write-through cached,
write-coalescing, etc).  But I seem to have been wrong about that.
Now, as far as I know, on x86, ioremap() will give write-through
cached mappings (in the absence of mtrr games).  If this is true, how
can this work?  There are many drivers out there that use ioremap() on
memory mapped I/O regions that do NOT have the "Prefetchable" bit set
in the PCI BAR.  For example, the eepro100 driver does this and it has
a routine called wait_for_cmd_done(), which spins on an ioremapped
read.  On an x86, what prevents these reads from being cached?

Thanks,

	--david
