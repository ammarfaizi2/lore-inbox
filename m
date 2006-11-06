Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753397AbWKFQgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbWKFQgf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753399AbWKFQgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:36:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:227 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753397AbWKFQge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:36:34 -0500
Message-ID: <454F6431.1010108@zytor.com>
Date: Mon, 06 Nov 2006 08:34:57 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
CC: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 7/11] i386: Kallsyms generate relocatable symbols
References: <20061023192456.GA13263@in.ibm.com>	<20061023193748.GH13263@in.ibm.com> <20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
In-Reply-To: <20061106154857.003dc9d9@cad-250-152.norway.atmel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haavard Skinnemoen wrote:
> On Mon, 23 Oct 2006 15:37:48 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
>> Add the _text symbol definitions to the architectures which don't
>> define it otherwise linker will fail.
> 
> I get lots of this when building latest -mm for avr32:
> 
> .tmp_kallsyms2.S:643: Warning: right operand is a bignum; integer 0
> assumed
> 
> Reverting this patch makes the warnings go away. I think it's
> because on avr32, .init is the first section, not .text, so many of the
> offsets become negative and kallsyms doesn't seem to handle this very
> well. Here's a few lines from .tmp_kallsyms2.S:
> 
> kallsyms_addresses:
>         PTR     _text + 0xffffffffffff4000
>         PTR     _text + 0xffffffffffff4000
> 
> Any idea how to fix this? Could we introduce a new symbol that always
> marks the start of the image perhaps?
> 

Maybe we should generate it as a signed value (-0x8000) instead of an 
unsigned value.

	-hpa
