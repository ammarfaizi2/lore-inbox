Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTKZEX1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 23:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTKZEX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 23:23:27 -0500
Received: from holomorphy.com ([199.26.172.102]:49852 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261891AbTKZEXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 23:23:25 -0500
Date: Tue, 25 Nov 2003 20:23:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: riel@redhat.com, steiner@sgi.com, anton@samba.org, jes@trained-monkey.org,
       viro@math.psu.edu, linux-kernel@vger.kernel.org, jbarnes@sgi.com
Subject: Re: hash table sizes
Message-ID: <20031126042309.GG8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, riel@redhat.com, steiner@sgi.com,
	anton@samba.org, jes@trained-monkey.org, viro@math.psu.edu,
	linux-kernel@vger.kernel.org, jbarnes@sgi.com
References: <20031125231108.GA5675@sgi.com> <Pine.LNX.4.44.0311252238140.22777-100000@chimarrao.boston.redhat.com> <20031126035953.GF8039@holomorphy.com> <20031125202545.7a4ca5d3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125202545.7a4ca5d3.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> -#define pfn_valid(pfn)          ((pfn) < num_physpages)
>> +#define pfn_valid(pfn)						\
>> +({									\
>> +	unsigned long __pfn__ = pfn;					\
>> +	u8 __nid__ = pfn_to_nid(__pfn__);				\
>> +	pg_data_t *__pgdat__;						\
>> +	__pgdat__ = __nid__ < MAX_NUMNODES ? NODE_DATA(__nid__) : NULL;	\
>> +	__pgdat__ &&							\
>> +		__pfn__ >= __pgdat__->node_start_pfn &&			\
>> +		__pfn__ - __pgdat__->node_start_pfn			\
>> +				< __pgdat__->node_spanned_pages;	\
>> +})

On Tue, Nov 25, 2003 at 08:25:45PM -0800, Andrew Morton wrote:
> Boggle.
> Does this evaulate to the same thing on non-discontigmem? (surely no)
> Can we please arrange for it to?

The non-discontigmem case is unaltered, as it's handled in
include/asm-i386/page.h under a #ifdef. The semantics agree.

-- wli
