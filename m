Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758731AbWK1Sar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758731AbWK1Sar (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 13:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758730AbWK1Sar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 13:30:47 -0500
Received: from khc.piap.pl ([195.187.100.11]:11475 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1758728AbWK1Saq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 13:30:46 -0500
To: Patrick McHardy <kaber@trash.net>
Cc: David Miller <davem@davemloft.net>, lkml <linux-kernel@vger.kernel.org>,
       <netdev@vger.kernel.org>
Subject: Broken commit: [NETFILTER]: ipt_REJECT: remove largely duplicate route_reverse function
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 28 Nov 2006 19:30:43 +0100
Message-ID: <m3fyc3e84s.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following commit breaks ipt_REJECT on my machine. Tested with latest
2.6.19rc*, found with git-bisect. i386, gcc-4.1.1, the usual stuff.
All details available on request, of course.

commit 9d02002d2dc2c7423e5891b97727fde4d667adf1
Author: Patrick McHardy <kaber@trash.net>
Date:   Mon Oct 2 16:12:20 2006 -0700

    [NETFILTER]: ipt_REJECT: remove largely duplicate route_reverse function
    
    Use ip_route_me_harder instead, which now allows to specify how we wish
    the packet to be routed.
    
    Based on patch by Simon Horman <horms@verge.net.au>.
    
    Signed-off-by: Patrick McHardy <kaber@trash.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

The results are:

Last user: [<c015f82b>](alloc_pipe_info+0x1b/0x50)
000: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
010: ad 4e ad de ff ff ff ff ff ff ff ff dc c4 45 c0
Next obj: start=c476fb58, len=512
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02b5998>](kfree_skbmem+0x8/0x80)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=c476fd64, len=512
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02b5998>](kfree_skbmem+0x8/0x80)
040: 6b 6b 6b 6b f5 1b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Prev obj: start=c476fb58, len=512
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c01f76c7>](acpi_ps_parse_aml+0x1b7/0x1f2)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Slab corruption: start=c476fd64, len=512
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<c02b5998>](kfree_skbmem+0x8/0x80)

and so on.
-- 
Krzysztof Halasa
