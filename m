Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUDPSHo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 14:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUDPSHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 14:07:44 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:34533 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263567AbUDPSH3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 14:07:29 -0400
To: linux-kernel@vger.kernel.org, dev@able.be, netdev@oss.sgi.com
Subject: Re: Kernel panic using frame relay protocol and IPSec
References: <407E93F9.3010105@able.be>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 16 Apr 2004 18:10:23 +0200
In-Reply-To: <407E93F9.3010105@able.be> (Wim Ceulemans's message of "Thu, 15
 Apr 2004 15:54:01 +0200")
Message-ID: <m3ad1b3nv4.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Ceulemans <wim.ceulemans@able.be> writes:

> We are using kernel 2.4.24 and super-freeswan 1.99.8.
> When using the frame relay protocol when a psk tunnel is established,
> we are seeing a kernel panic when we ping through the tunnel.

Short version of my email to Wim:

It looks like a known bug - IPSEC code seems to ignore
dev->hard_header_len = 10 requirement for PVC devices and passes skbs
which have less than 10 bytes of header space. Not sure how does it
work with Ethernet which requires 14 bytes, though. It might be a good
idea to investigate.


I wonder if the FR behavior is correct - i.e. is it OK to set
dev->hard_header_len = 10 and expect that all skbs passed to
dev->hard_start_xmit() will have at least 10 bytes of space before
the data?

Does the situation depend on dev->hard_header being non-NULL?
-- 
Krzysztof Halasa, B*FH
