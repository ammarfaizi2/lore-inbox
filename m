Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132974AbRDEU5S>; Thu, 5 Apr 2001 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDEU5I>; Thu, 5 Apr 2001 16:57:08 -0400
Received: from Xenon.Stanford.EDU ([171.64.66.201]:47563 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132974AbRDEU4y>; Thu, 5 Apr 2001 16:56:54 -0400
Date: Thu, 5 Apr 2001 13:56:08 -0700
From: Andy Chou <acc@CS.Stanford.EDU>
To: Andy Chou <acc@CS.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU
Subject: Re: [CHECKER] 15 potential pointer dereference errors in 2.4.3
Message-ID: <20010405135608.A748@Xenon.Stanford.EDU>
Reply-To: acc@CS.Stanford.EDU
In-Reply-To: <20010405015251.A20904@Xenon.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.1.1i
In-Reply-To: <20010405015251.A20904@Xenon.Stanford.EDU>; from acc@CS.Stanford.EDU on Thu, Apr 05, 2001 at 01:52:51AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's one more potential bug for 2.4.3.

-Andy

[BUG]
/u2/acc/oses/linux/2.4.3/drivers/isdn/hysdn/hysdn_net.c:309:hysdn_net_create: ERROR:NULL:302:309: Using
NULL ptr "dev" illegally! set by 'kmalloc_Rsmp_93d4cfe6':302

Start --->
	if ((dev = kmalloc(sizeof(struct net_local), GFP_KERNEL)) ==
NULL) {
		printk(KERN_WARNING "HYSDN: unable to allocate mem\n");
		if (card->debug_flags & LOG_NET_INIT)
			return (-ENOMEM);
	}
	memset(dev, 0, sizeof(struct net_local));	/* clean the structure
*/

Error --->
	spin_lock_init(&((struct net_local *) dev)->lock);

