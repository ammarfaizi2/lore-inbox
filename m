Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269972AbUICXMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269972AbUICXMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 19:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUICXMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 19:12:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:57833 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269938AbUICXMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 19:12:42 -0400
Message-ID: <4138FA69.3040308@sgi.com>
Date: Fri, 03 Sep 2004 18:12:41 -0500
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org
CC: linux-kernel@vger.kernel.org, hch@infradead.org
Subject: Latest Altix I/O code rewrite
References: <200408042014.i74KE8fD141211@fsgi900.americas.sgi.com> <20040806141836.A9854@infradead.org> <411AAABB.8070707@sgi.com> <412F4EC9.7050003@sgi.com> <412F4FCF.6010507@sgi.com> <20040827162127.A32090@infradead.org> <412F54D4.2020905@sgi.com> <20040827164409.A32340@infradead.org>
In-Reply-To: <20040827164409.A32340@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have redone the I/O layer in the Altix code.

We are posting this code for review before submitting for inclusion in
the 2.6 tree.

I've broken the patch set down to 2 patches. One to remove the files,
the other to add in the new code. Most of the changes from the last
posting are in response to review comments.


The patches are :
ftp://oss.sgi.com/projects/sn2/sn2-update/001-kill-files
ftp://oss.sgi.com/projects/sn2/sn2-update/002-add-files

They are based off http://lia64.bkbits.net/linux-ia64-test-2.6.8.1

The general differences between the new code and the old code are:

I/O discovery and initialization was moved to prom to enable us to move
towards EFI 1.10 and ACPI compliance.  EFI 1.10 and ACPI compliance
will be the next 2 phases in our development.  Since prom is now
performing all I/O discovery and initialization, we had to re-architect
the Altix platform specific code in Linux - basically deleting all code
related to discovery and initialization and leaving DMA mapping which
was rewritten.

Until we can implement ACPI in our prom, we will use platform specific
SAL calls to retrieve any PCI configuration that is needed during the
PCI fixup phase.
