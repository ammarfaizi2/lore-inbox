Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265126AbSLVRfk>; Sun, 22 Dec 2002 12:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265130AbSLVRfk>; Sun, 22 Dec 2002 12:35:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:39354 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265126AbSLVRfj>; Sun, 22 Dec 2002 12:35:39 -0500
Date: Sun, 22 Dec 2002 09:43:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Subject: Re: [PATCH][2.4]  generic support for systems with more than 8 CPUs
 (2/2)
Message-ID: <34630000.1040579013@titus>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E1B3@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_X86_CLUSTERED_APIC
> +	/*
> +	 * Switch to Physical destination mode in case of generic
> +	 * more than 8 CPU system, which has xAPIC support
> +	 */
> +#define FLAT_APIC_CPU_MAX	8
> +	if ((clustered_apic_mode == CLUSTERED_APIC_NONE) &&
> +	    (xapic_support) &&
> +	    (num_processors > FLAT_APIC_CPU_MAX)) {
> +		clustered_apic_mode = CLUSTERED_APIC_XAPIC;
> +		apic_broadcast_id = APIC_BROADCAST_ID_XAPIC;
> +		int_dest_addr_mode = APIC_DEST_PHYSICAL;
> +		int_delivery_mode = dest_Fixed;
> +		esr_disable = 1;
> +	}
> +#endif

If you could stick the #define up in a header file somewhere, would
be more standard / neater. Otherwise that looks good to me ...

Thanks for cleaning all this stuff up - the new set is much less
invasive, and easier to read than the last set ;-)

M.

