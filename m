Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbTHVPXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 11:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264797AbTHVPXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 11:23:49 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:24753 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264780AbTHVPXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 11:23:46 -0400
Message-ID: <3F46356A.804@nortelnetworks.com>
Date: Fri, 22 Aug 2003 11:23:22 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: help???  trying to trace code path of outgoing udp packet
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to figure out the code path taken by an outgoing udp packet, 
and I'm having a bit of trouble figuring out which functions are called 
by which function pointers.  The path that I have so far is this:

udp_sendmsg          udp.c
ip_build_xmit        ip_output.c
output_maybe_reroute ip_output.c   skb->dst->output
ip_output            ip_output.c
ip_finish_output     ip_output.c
ip_finish_output2    ip_output.c   dst->neighbour->output

Is this correct?  Where does it go from here and how does it eventually 
end up in the driver?

In the case in question, the network device is the tulip chip and 
traffic shaping is not enabled, but we do have advanced routing turned on.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

