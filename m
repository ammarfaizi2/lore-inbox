Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422954AbWBAVl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422954AbWBAVl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 16:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422958AbWBAVl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 16:41:58 -0500
Received: from fmr22.intel.com ([143.183.121.14]:45696 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1422954AbWBAVl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 16:41:57 -0500
Message-Id: <200602012141.k11LfCg32497@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Grant Grundler'" <iod00d@hp.com>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "'Akinobu Mita'" <mita@miraclelinux.com>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [PATCH 1/12] generic *_bit()
Date: Wed, 1 Feb 2006 13:41:03 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYnZ0XAmPteRbXTSret71gtJ6uFfAAAAjMw
In-Reply-To: <20060201193933.GA16471@esmail.cup.hp.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote on Wednesday, February 01, 2006 11:40 AM
> On Wed, Feb 01, 2006 at 10:07:28AM -0800, Chen, Kenneth W wrote:
> > I think these should be defined to operate on arrays of unsigned int.
> > Bit is a bit, no matter how many byte you load (8/16/32/64), you can
> > only operate on just one bit.
> 
> Well, if it doesn't matter, why is unsigned int better?


I was coming from the angle of having bitop operate on unsigned
int *, so people don't have to type cast or change bit flag variable
to unsigned long for various structures.  With unsigned int type for
bit flag, some of them are not even close to fully utilized. for example:

thread_info->flags uses 18 bits
thread_struct->flags uses 7 bits

It's a waste of memory to define a variable that kernel will *never*
touch the 4 MSB in that field.


> unsigned long is typically the native register size, right?
> I'd expect that to be more efficient on most arches.


The only difference that I can think of on Itanium processor is the
memory operation, you either load/store 4 or 8 bytes. Once the data
is in the CPU register, it doesn't make any difference whether it is
operating on 32bit or entire 64 bit. I don't know about others RISC
arch though whether it is more efficient with native register size.

- Ken

