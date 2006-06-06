Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWFFWoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWFFWoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFFWoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 18:44:13 -0400
Received: from khc.piap.pl ([195.187.100.11]:59912 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751269AbWFFWoL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 18:44:11 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: paulkf@microgate.com, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<1149622813.11929.3.camel@amdx2.microgate.com>
	<m3u06yc9mr.fsf@defiant.localdomain>
	<20060606134816.363cbeca.rdunlap@xenotime.net>
	<20060606140822.c6f4ef37.rdunlap@xenotime.net>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 07 Jun 2006 00:44:09 +0200
In-Reply-To: <20060606140822.c6f4ef37.rdunlap@xenotime.net> (Randy Dunlap's message of "Tue, 6 Jun 2006 14:08:22 -0700")
Message-ID: <m3zmgpc3ba.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> OK, it's still not working.  As Dave Jones reported:
>
>> WARNING: /lib/modules/2.6.17-rc5-mm3/kernel/drivers/char/pcmcia/
>>   synclink_cs.ko needs unknown symbol alloc_hdlcdev

Looks like the only patch in mm3 touching it is:
fix-kbuild-dependencies-for-synclink-drivers.

BTW: selecting CONFIG_HDLC without selecting at least one protocol
does nothing good (except that the thing actually builds). As I said,
I'd rather let the user decide what it's needed.

Hmm, with 2.6.17-rc5-mm3 it builds fine here (~ up-to-date FC5, i386):

$ egrep '^C.*(SYNCLINK|HDLC)' .config
CONFIG_HDLC=m
CONFIG_SYNCLINK=m
CONFIG_SYNCLINK_HDLC=y
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINKMP_HDLC=y
CONFIG_SYNCLINK_GT=m
CONFIG_SYNCLINK_GT_HDLC=y
CONFIG_SYNCLINK_CS=m
CONFIG_SYNCLINK_CS_HDLC=y

Are you sure it's not a corrupted build tree or something like that?
Can I have a look at the complete .config? Or some other bugzilla #?


There is exactly zero magic in generic HDLC, things are just build
and exported as any other symbol in the tree.
-- 
Krzysztof Halasa
