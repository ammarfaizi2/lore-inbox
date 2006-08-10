Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161047AbWHJOWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbWHJOWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 10:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbWHJOWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 10:22:03 -0400
Received: from mga05.intel.com ([192.55.52.89]:11815 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161047AbWHJOWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 10:22:01 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,111,1154934000"; 
   d="scan'208"; a="114570768:sNHT15938020"
Date: Thu, 10 Aug 2006 07:10:29 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Christoph Hellwig <hch@infradead.org>, David Smith <dsmith@redhat.com>,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org, shemminger@osdl.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060810071028.A18344@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060807115537.GA15253@in.ibm.com> <20060808162421.GA28647@infradead.org> <1155139305.8345.20.camel@dhcp-2.hsv.redhat.com> <20060809161039.GA30856@infradead.org> <20060809161854.GA13622@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060809161854.GA13622@infradead.org>; from hch@infradead.org on Wed, Aug 09, 2006 at 05:18:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2006 at 05:18:54PM +0100, Christoph Hellwig wrote:
> +	 */
> +	if (p->symbol_name) {
> +		if (p->addr)
> +			return -EINVAL;
> +		p->addr = kprobe_lookup_name(p->symbol_name);
> +	}
> +
> +	if (!p->addr)
> +		return -EINVAL;
> +	p->addr += p->offset;
This should be p->addr = (kprobe_opcode_t *)(((char *)p->addr) + p->offset), since p->addr is of type
pointer to kprobe_opcode_t and the size of kprobe_opcode_t is different for different
architecture. At least for ia64 this p->addr type is not a pointer to char.

-Anil Keshavamurthy
