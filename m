Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423784AbWKFKcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423784AbWKFKcS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423789AbWKFKcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:32:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:2522 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423784AbWKFKcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:32:17 -0500
Subject: Re: [PATCH 1/14] KVM: userspace interface
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <454F0E4A.7030001@qumranet.com>
References: <454E4941.7000108@qumranet.com>
	 <20061105202934.B5F842500A7@cleopatra.q>
	 <1162807420.3160.186.camel@laptopd505.fenrus.org>
	 <454F0E4A.7030001@qumranet.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 11:32:08 +0100
Message-Id: <1162809128.3160.201.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> \> as a general rule, it's a lot better to sort structures big-to-small, to
> > make sure alignments inside the struct are minimized and don't suck too
> > much. This is especially important to get right for 32/64 bit
> > compatibility. This comment is true for most structures in this header
> > file; please consider this at least
> >   
> 
> Doesn't that cause an unnatural field order? 

Does it matter?

> for example, in some 
> structures I separated in and out variables.  Sorting by size is a bit 
> like sorting alphabetically.
> 
> Anyway I observed 32/64 bit compatibility religiously.

but you did take the alignment rules of 64 bit variables into account,
eg 32 bit has it 4 byte aligned, while 64 bit has it 8 byte aligned..
you are 100% sure even your 32 bit structures have all 64 bit values 8
byte aligned?
(you get this automatic if you sort by size)
Also you made sure that if you have such implicit padding that you zero
out the memory between the fields to avoid information leaks?

Sorting by size at least makes this all go away.....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

