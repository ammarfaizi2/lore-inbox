Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbTFPUsZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbTFPUsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:48:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43227 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264256AbTFPUsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:48:18 -0400
Message-ID: <3EEE2F9F.60706@us.ibm.com>
Date: Mon, 16 Jun 2003 15:59:11 -0500
From: Janice M Girouard <janiceg@us.ibm.com>
Organization: IBM Linux Technology Center - Network Device Drivers
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Daniel Stekloff <stekloff@us.ibm.com>,
       Janice Girouard <girouard@us.ibm.com>,
       Larry Kessler <lkessler@us.ibm.com>, kenistonj@us.ibm.com,
       jgarzik@pobox.com
Subject: Re: patch for common networking error messages
References: <3EEE28DE.6040808@us.ibm.com> <20030616.133841.35533284.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that it's not desirable to introduce a bunch of messages that we 
aren't already logging.  I didn't show the netif_msg prefix because I 
was trying to focus the patch on the common messages, but you would 
normally proceed a message with:

if netif_msg_link()
   printk("some text to indicate the link is up/down")

The netif_msg_link test would normally filter out what messages should 
be logged.

Or, just leave out the message call.  I added one or two messages to the 
tg3 and e1000 drivers  to demonstrate where you might use these common 
messages... just to show that various drivers could use the text. 
 Actually using the specific message would be completely up to the 
developer.

Jaince



David S. Miller wrote:

>   From: Janice M Girouard <janiceg@us.ibm.com>
>   Date: Mon, 16 Jun 2003 15:30:22 -0500
>
>   EMSG_NET_LINK_UP     "%s: state change: link up, %d Mbps, %s-duplex\n"
>
>Should indicate flow control state too.
>
>   EMSG_NET_START_QUEUE "%s: performance event: (re)starting netdev queue\n"
>   EMSG_NET_STOP_QUEUE  "%s: performance event: stopping netdev queue\n"
>
>Oh _ABSOLUTELY NOT_, you're not printing a message
>for normal events like this.  Especially those that are
>going to occur on highly loaded systems.
>
>  
>


