Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbTHYPIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbTHYPIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:08:55 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:21733 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261878AbTHYPIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:08:54 -0400
Message-ID: <3F4A267B.1000405@nortelnetworks.com>
Date: Mon, 25 Aug 2003 11:08:43 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: why are error messages suppressed if IP_RECVERR is not set?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm tracking down an issue where we are sending udp packets and they are 
being dropped (I suspect) in the device queue.

In ip_build_xmit() we get the error code back saying that the packet was 
dropped, but unless IP_RECVERR is set, it seems that this error is 
hidden from userspace.

I notice that the man page says that sendto will never give an errno of 
ENOBUFS, but if you turn on IP_RECVERR this is exactly what will happen.

I guess I have two questions then: 1) why do we hide the fact that we've 
dropped the packet, and 2) why doesn't the man page talk about the 
IP_RECVERR option?

I'm using 2.4.18, if it matters.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

