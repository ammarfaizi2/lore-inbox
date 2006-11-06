Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753020AbWKFOuL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbWKFOuL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 09:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753023AbWKFOuL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 09:50:11 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:49914 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753020AbWKFOuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 09:50:09 -0500
Date: Mon, 6 Nov 2006 15:48:57 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: vgoyal@in.ibm.com
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 7/11] i386: Kallsyms generate relocatable symbols
Message-ID: <20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
In-Reply-To: <20061023193748.GH13263@in.ibm.com>
References: <20061023192456.GA13263@in.ibm.com>
	<20061023193748.GH13263@in.ibm.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 15:37:48 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> Add the _text symbol definitions to the architectures which don't
> define it otherwise linker will fail.

I get lots of this when building latest -mm for avr32:

.tmp_kallsyms2.S:643: Warning: right operand is a bignum; integer 0
assumed

Reverting this patch makes the warnings go away. I think it's
because on avr32, .init is the first section, not .text, so many of the
offsets become negative and kallsyms doesn't seem to handle this very
well. Here's a few lines from .tmp_kallsyms2.S:

kallsyms_addresses:
        PTR     _text + 0xffffffffffff4000
        PTR     _text + 0xffffffffffff4000

Any idea how to fix this? Could we introduce a new symbol that always
marks the start of the image perhaps?

Haavard
