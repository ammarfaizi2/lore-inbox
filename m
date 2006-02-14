Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422856AbWBNXaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422856AbWBNXaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 18:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422883AbWBNXay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 18:30:54 -0500
Received: from smtp-out.google.com ([216.239.45.12]:45069 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1422856AbWBNXax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 18:30:53 -0500
Message-ID: <43F2680E.7060306@google.com>
Date: Tue, 14 Feb 2006 15:30:22 -0800
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: christoph <hch@lst.de>, akpm@osdl.org, mcao@us.ibm.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] map multiple blocks at a time in mpage_readpages()
References: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
In-Reply-To: <1139939347.4762.18.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> +		for (i = 0; ; i++) {
> +			if (i == nblocks) {
> +				*map_valid = 0;
> +				break;
> +			} else if (page_block == blocks_per_page)
> +				break;
> +			blocks[page_block] = map_bh->b_blocknr + i;
> +			page_block++;
> +			block_in_file++;
> +		}

Hi Badari, a tiny nit:

		for (i = 0; ; i++) {
			if (i == nblocks) {
				*map_valid = 0;
				break;
			}
			if (page_block == blocks_per_page)
				break;
			blocks[page_block] = map_bh->b_blocknr + i;
			page_block++;
			block_in_file++;
		}

Regards,

Daniel
