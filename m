Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVCRPk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVCRPk6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 10:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVCRPi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 10:38:58 -0500
Received: from stark.xeocode.com ([216.58.44.227]:7895 "EHLO stark.xeocode.com")
	by vger.kernel.org with ESMTP id S261651AbVCRPdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 10:33:42 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.6.11 breaks modules gratuitously
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 18 Mar 2005 10:33:29 -0500
Message-ID: <87fyythsty.fsf@stark.xeocode.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When you guys go on these "make needlessly global code static" kicks you
should maybe consider that even functions that aren't currently used by any
other area of the tree might be useful for module writers.

Instead of just checking which functions are currently used by other parts of
the kernel perhaps you should think about what makes a logical API and stick
to that, even if not all of the functions are currently used.

In the case of net/core/datagram.c, why make skb_copy_datagram private but
leave skb_copy_datagram_iovec global? If the latter is a useful public
function why not the former?

In particular vmware used skb_copy_datagram. So 2.6.11 broke vmware for no
good reason.



<bunk@stusta.de>
	[NET]: misc cleanups
	
	The patch below contains the following cleanups:
	- make needlessly global code static
	- remove the following unused global functions:
	  - datagram.c: skb_copy_datagram
	  - iovec.c: memcpy_tokerneliovec
	- remove the following unneeded EXPORT_SYMBOL's:
	  - datagram.c: skb_copy_datagram
	  - dev.c: ing_filter
	  - iovec.c: memcpy_tokerneliovec
	  - netpoll.c: netpoll_send_skb
	  - rtnetlink.c: rtnetlink_dump_ifinfo
	  - sock.c: sock_alloc_send_pskb
	
	Signed-off-by: Adrian Bunk <bunk@stusta.de>
	Signed-off-by: David S. Miller <davem@davemloft.net>


-- 
greg

