Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbUKQV1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUKQV1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbUKQVZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:25:36 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29676 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262622AbUKQVTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:19:11 -0500
Message-ID: <419BC04E.7050004@mvista.com>
Date: Wed, 17 Nov 2004 15:19:10 -0600
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH} Network interface for IPMI
References: <419BB646.3070805@mvista.com> <20041117125114.0c8fdf62.akpm@osdl.org>
In-Reply-To: <20041117125114.0c8fdf62.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Corey Minyard <cminyard@mvista.com> wrote:
>  
>
>>IPMI is a manage standard that allows intelligent management controllers 
>>to monitor things about the system (temperature, fan speed, etc.).  The 
>>management controllers sit on a bus, and have addresses, and such.  
>>After seeing the ugliness required for the 32-bit ioctl compatability 
>>layers for 64-bit kernels, I have decided that the network interface for 
>>IPMI is a good thing, as the IPMI device ioctls have pointers and 
>>require ugly hacks.  None should be needed for the network interface.
>>
>>This patch adds that layer.
>>
>>-#define NPROTO		32		/* should be enough for now..	*/
>>+#define NPROTO		64		/* should be enough for now..	*/
>>    
>>
>
>Boy, that was a big bump.  Was this intentional?
>  
>
It's the next power of 2 :).  Any value larger than 32 should work, I'll 
just set it to 33.

>  
>
>>+static struct ipmi_sock *ipmi_socket_create1(struct socket *sock)
>>+{
>>+	struct ipmi_sock *i;
>>+
>>+	if (atomic_read(&ipmi_nr_socks) >= 2*files_stat.max_files)
>>+		return NULL;
>>    
>>
>
>Why this test?
>  
>
It snuck in from the original patch writer and I missed it.  Not necessary.

>  
>
>>+config IPMI_SOCKET
>>+	tristate "IPMI sockets"
>>+	depends on IPMI_HANDLER
>>+	---help---
>>+	  If you say Y here, you will include support for IPMI sockets;
>>+	  This way you don't have to use devices to access IPMI.  You
>>+	  must also enable the IPMI message handler and a low-level
>>+	  driver in the Character Drivers if you enable this.
>>+	  
>>+	  If unsure, say N.
>>    
>>
>
>Is this new kernel interface documented somewhere?
>  
>
I thought I had done it, but it doesn't appear to be there.  I'll add 
some and repost a patch.

Thanks,

-Corey
