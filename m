Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSL3WJW>; Mon, 30 Dec 2002 17:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbSL3WJW>; Mon, 30 Dec 2002 17:09:22 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:935 "EHLO lmail.actcom.co.il")
	by vger.kernel.org with ESMTP id <S267013AbSL3WJU>;
	Mon, 30 Dec 2002 17:09:20 -0500
Date: Tue, 31 Dec 2002 00:26:52 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on context of kfree_skb()
Message-ID: <20021230222652.GY28399@alhambra>
References: <200212301932.15175.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212301932.15175.oliver@neukum.name>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2002 at 07:32:15PM +0100, Oliver Neukum wrote:
> Hi,
> 
> I am getting reports about kfree_skb being called in hard IRQ.
> Which context should it be called in?

kfree_skb() should be called when you are not in hard irq context 
(i.e. in_irq() returns false). Same thing for dev_kfree_skb(), which
is a #define for kfree_skb(). Not in hard irq context means you are
either in softirq context (bottom half) or process context. 

dev_kfree_skb_irq() should be called when you are in interrupt
context.

dev_kfree_skb_any() should be called when you could be either
executing in interrupt context or not. 
-- 
Muli Ben-Yehuda

"The speed of light really is too slow nowdays." -- Alan Cox 
