Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWE3XGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWE3XGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWE3XGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:06:30 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:21713 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S964808AbWE3XG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:06:28 -0400
Message-ID: <447CCFF2.30207@vc.cvut.cz>
Date: Wed, 31 May 2006 01:06:26 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@xensource.com>
CC: konradr@us.ibm.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@linux.intel.com, linux-acpi@vger.kernel.org
Subject: Re: ThinkPad X60: PCI: BIOS Bug: MCFG area is not E820-reserved	(MCFG
 is in ACPI NVS)
References: <447C9F19.5000105@goop.org>	 <20060530204112.GA22031@andromeda.dapyr.net> <1149025621.25497.9.camel@jeremy.eng.hq.xensource.com>
In-Reply-To: <1149025621.25497.9.camel@jeremy.eng.hq.xensource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> On Tue, 2006-05-30 at 16:41 -0400, konradr@us.ibm.com wrote:
> 
>>On Tue, May 30, 2006 at 12:38:01PM -0700, Jeremy Fitzhardinge wrote:
>>
>>>[snip]
>>>
>>>So the MCFG entry is in the ACPI NVS region of the E820 table.  Is this 
>>>bad? 
>>
>>Not at all. The ACPI v3.0 specs mentions that:
>>
>>"ACPI NVS Memory. This range of addresses is in use or reserve by
>>the system and must not be used by the operating system. This
>>range is required to be saved and restored across an NVS sleep."
> 
> 
> I actually misread the tables.  It appears that MCFG (at 0x7f6e2e36) is
> in ACPI Data (7f6d0000 - 7f6e3000).  include/asm-i386/e820.h says that
> memory marked as "E820_ACPI" can be reused as normal memory once the
> ACPI tables have been read.
> 
> Doesn't this mean that the MCFG memory could end up being used as
> general system memory?  That seems bad if MCFG memory is some kind of
> MMIO space.  Or is the comment simply wrong?

Address where MCFG table lives is not important.  What is important (and 
checked) is address of MMCONFIG reported by MCFG table...  Unfortunately code 
does not bother with printing that address :-(

Another problem is that code has hardcoded that MMCONFIG area is 256MB large. 
Unfortunately for the code PCI specification allows any power of two between 2MB 
and 256MB if vendor knows that such amount of busses (from 2 to 128) will be 
sufficient for system.  With notebook it is quite possible that not full 8 bits 
are implemented for MMCONFIG bus number.
								Petr

