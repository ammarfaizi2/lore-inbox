Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVAXKko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVAXKko (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 05:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVAXKko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 05:40:44 -0500
Received: from dialpool3-194.dial.tijd.com ([62.112.12.194]:38278 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261406AbVAXKkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 05:40:36 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ARP routing issue - semi-solved
Date: Mon, 24 Jan 2005 11:40:30 +0100
User-Agent: KMail/1.7.2
Cc: linux-net@vger.kernel.org
References: <B8561865DB141248943E2376D0E85215846787@DHOST001-17.DEX001.intermedia.net> <200501151331.04879.lkml@kcore.org> <1105829477.16028.0.camel@localhost.localdomain>
In-Reply-To: <1105829477.16028.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241140.31464.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lists,

Just for the archive records: we solved it this way (with the good help of IBM):

# ip route add 10.0.24.0/24 dev eth1 proto kernel scope link src 10.0.24.xxx table 1
# ip route add default via 10.0.24.1 dev eth1 table 1 
# ip rule add from 10.0.24.xxx/32 table 1 priority 500
# ip route flush cache

Which is now run at bootup on the affected servers, giving us the solve we need.

Thanks everyone who replied.

Jan
-- 
Auribus teneo lupum.
 [I hold a wolf by the ears.]
 [Boy, it *sounds* good.  But what does it *mean*?]
