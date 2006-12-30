Return-Path: <linux-kernel-owner+w=401wt.eu-S1030363AbWL3Wpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWL3Wpy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWL3Wpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:45:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:46129 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030363AbWL3Wpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:45:54 -0500
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
From: Arjan van de Ven <arjan@infradead.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
	 <200612302149.35752.vda.linux@googlemail.com>
	 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Sat, 30 Dec 2006 23:45:48 +0100
Message-Id: <1167518748.20929.578.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> i don't see how that can be true, given that most of the definitions
> of the clear_page() macro are simply invocations of memset().  see for
> yourself:

*MOST*. Not all.
For example an SSE version will at least assume 16 byte alignment, etc
etc.

clear_page() is supposed to be for full real pages only... for example
it allows the architecture to optimize for alignment, cache aliasing etc
etc. (and if there are cpus that get a "clear an entire page"
instruction.... there has been hardware like that in the past, even on
x86, just it's no longer sold afaik)

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

