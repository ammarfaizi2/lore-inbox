Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTJAS1d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 14:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbTJAS1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 14:27:33 -0400
Received: from fmr09.intel.com ([192.52.57.35]:54987 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S262094AbTJAS0l convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 14:26:41 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: Updated MSI Patches
Date: Wed, 1 Oct 2003 11:26:37 -0700
Message-ID: <C7AB9DA4D0B1F344BF2489FA165E5024015417FC@orsmsx404.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Updated MSI Patches
Thread-Index: AcOIPuBNtvC0eQlJRuaZj2PRNwlMxwACk+mw
From: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>, <linux-kernel@vger.kernel.org>,
       <linux-pci@vger.kernel.org>, "Nguyen, Tom L" <tom.l.nguyen@intel.com>
X-OriginalArrivalTime: 01 Oct 2003 18:26:37.0811 (UTC) FILETIME=[8D1EEC30:01C38849]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, October 01, 2003, Jeff Garzik wrote:
>> +Q2. Will it work on all the Pentium processors (P3, P4, Xeon,
>> +AMD processors)? In P3 IPI's are transmitted on the APIC local
>> +bus and in P4 and Xeon they are transmitted on the system
>> +bus. Are there any implications with this?
>> +
>> +A2. MSI support enables a PCI device sending an inbound
>> +memory write (0xfeexxxxx as target address) on its PCI bus
>> +directly to the FSB. Since the message address has a
>> +redirection hint bit cleared, it should work.
>> +
>> +Q3. The target address 0xfeexxxxx will be translated by the
>> +Host Bridge into an interrupt message. Are there any
>> +limitations on the chipsets such as Intel 8xx, Intel e7xxx,
>> +or VIA?
>> +
>> +A3. If these chipsets support an inbound memory write with
>> +target address set as 0xfeexxxxx, as conformed to PCI 
>> +specification 2.3 or latest, then it should work.

>I would prefer a section in the documentation that spells out, in plain 
>English, exactly what hardware support is needed for MSI to work.  i.e.

>"APIC required and must be enabled"
>"Northbridge must support MSI transactions"
>etc.

>Using that information, users and developers may know _exactly_ whether 
>they can use MSI or not.  From "Q2/A2" and "Q3/A3" above, it is not 
>clear to me.
Agree. Thanks!

>> +static struct hw_interrupt_type msix_irq_type = {
>> +	"PCI MSI-X",
>> +	startup_msi_irq_w_maskbit,
>> +	shutdown_msi_irq_w_maskbit,
>> +	enable_msi_irq_w_maskbit,
>> +	disable_msi_irq_w_maskbit,
>> +	act_msi_irq_w_maskbit,		
>> +	end_msi_irq_w_maskbit,	
>> +	set_msi_irq_affinity
>> +};
>> +
>> +/*
>> + * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
>> + * which implement the MSI Capability Structure with 
>> + * Mask-and-Pending Bits. 
>> + */
>> +static struct hw_interrupt_type msi_irq_w_maskbit_type = {
>> +	"PCI MSI",
>> +	startup_msi_irq_w_maskbit,
>> +	shutdown_msi_irq_w_maskbit,
>> +	enable_msi_irq_w_maskbit,
>> +	disable_msi_irq_w_maskbit,
>> +	act_msi_irq_w_maskbit,		
>> +	end_msi_irq_w_maskbit,	
>> +	set_msi_irq_affinity
>> +};
>> +
>> +/*
>> + * Interrupt Type for MSI PCI/PCI-X/PCI-Express Devices,
>> + * which implement the MSI Capability Structure without 
>> + * Mask-and-Pending Bits. 
>> + */
>> +static struct hw_interrupt_type msi_irq_wo_maskbit_type = {
>> +	"PCI MSI",
>> +	startup_msi_irq_wo_maskbit,
>> +	shutdown_msi_irq_wo_maskbit,
>> +	enable_msi_irq_wo_maskbit,
>> +	disable_msi_irq_wo_maskbit,
>> +	act_msi_irq_wo_maskbit,		
>> +	end_msi_irq_wo_maskbit,	
>> +	set_msi_irq_affinity
>> +};

>Suggest converting these structure initializers to C99 style:
>
>	.member_name		= value,

Agree. Thanks!

>> +/**
>> + * msix_capability_init: configure device's MSI-X capability structure
>> + * argument: dev of struct pci_dev type
>> + * 
>> + * description: called to configure the device's MSI-X capability structure 
>> + * with a single MSI. To request for additional MSI vectors, the device drivers
>> + * are required to utilize the following supported APIs:
>> + * 1) msi_alloc_vectors(...) for requesting one or more MSI
>> + * 2) msi_free_vectors(...) for releasing one or more MSI back to PCI subsystem
>> + *

>When added header comments, please use the official kernel style, so 
>that it may be picked up automatically by the kernel documentation 
>processing system (Documentation/DocBook/*).  Specifically,
>
>	/**
>
>begins a header (you did this),
>
>	*	my_function - description
>
>begins a function header (you need to use " - "),
>
>	*	@arg1: description...
>	*	@arg2: description...
>
>describes the arguments.

>The rest is fine.  Note that lines ending with a colon ("blah blah:\n") 
>are bolded, and considered paragraph leaders.

Agree. Thanks for this input!

>> @@ -564,6 +565,9 @@
>>  		/* Fix up broken headers */
>>  		pci_fixup_device(PCI_FIXUP_HEADER, dev);
>>  
>> +		/* Fix up broken MSI hardware */
>> +		pci_fixup_device(PCI_FIXUP_MSI, dev);
>> +
>>  		/*
>>  		 * Add the device to our list of discovered devices
>>  		 * and the bus list for fixup functions, etc.

>Why does MSI need a separate list of fixups?
You are right. Sorry, I forgot to remove these lines after testing 
first alternative "quirk" solution. Will remove these lines.

>> +struct msg_data {	
>> +	__u32	vector	:  8,		
>> +	delivery_mode	:  3,	/*	000b: FIXED
>> +			 		001b: lowest priority
>> +			 	 	111b: ExtINT */	
>> +	reserved_1	:  3,
>> +	level		:  1,	/* 0: deassert, 1: assert */	
>> +	trigger		:  1,	/* 0: edge, 1: level */	
>> +	reserved_2	: 16;
>> +} __attribute__ ((packed));
>> +
>> +struct msg_address {
>> +	union {
>> +		struct { __u32
>> +			reserved_1		:  2,		
>> +			dest_mode		:  1,	/* 0: physical, 
>> +							   1: logical */	
>> +			redirection_hint        :  1,  	/* 0: dedicated CPU 
>> +							   1: lowest priority */
>> +			reserved_2		:  8,   	
>> + 			dest_id			:  8,	/* Destination ID */	
>> +			header			: 12;	/* FEEH */
>> +      	}u;
>> +       	__u32  value;
>> +	}lo_address;
>> +	__u32 	hi_address;
>> +} __attribute__ ((packed));
>> +
>> +struct msi_desc {
>> +	struct {
>> +		__u32	type	: 5, /* {0: unused, 5h:MSI, 11h:MSI-X} 	  */
>> +			maskbit	: 1, /* mask-pending bit supported ?      */
>> +			reserved: 2, /* reserved			  */
>> +			entry_nr: 8, /* specific enabled entry 		  */
>> +			default_vector: 8, /* default pre-assigned vector */ 
>> +			current_cpu: 8; /* current destination cpu	  */
>> +	}msi_attrib;
>> +
>> +	struct {
>> +		__u32	head	: 16, 
>> +			tail	: 16; 
>> +	}link;
>> +
>> +	unsigned long mask_base;
>> +	struct pci_dev *dev;
>> +};

>These bitfields should be defined in big-endian and little-endian forms, 
>shouldn't they?  grep for __LITTLE_ENDIAN_BITFIELD and 
>__BIG_ENDIAN_BITFIELD in include/*/*.h.

Thanks for your input. We'll make change appropriately.

Thanks,
Long
