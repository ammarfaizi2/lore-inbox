Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSAUOPW>; Mon, 21 Jan 2002 09:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSAUOPM>; Mon, 21 Jan 2002 09:15:12 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56324 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286687AbSAUOO5>; Mon, 21 Jan 2002 09:14:57 -0500
Date: Mon, 21 Jan 2002 14:14:36 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: davej@suse.de, martin.macok@underground.cz, linux-kernel@vger.kernel.org,
        ak@muc.de
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
Message-ID: <20020121141436.A11489@flint.arm.linux.org.uk>
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz> <20020120.175204.18636524.davem@redhat.com> <20020121031211.B29830@suse.de> <20020120.184318.13746427.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020120.184318.13746427.davem@redhat.com>; from davem@redhat.com on Sun, Jan 20, 2002 at 06:43:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 06:43:18PM -0800, David S. Miller wrote:
>    From: Dave Jones <davej@suse.de>
>    Date: Mon, 21 Jan 2002 03:12:11 +0100
> 
>    On Sun, Jan 20, 2002 at 05:52:04PM -0800, David S. Miller wrote:
>     > -	icmp_param.offset=skb_in->nh.raw - skb_in->data;
>     > +	icmp_param.offset=skb_in->data - skb_in->nh.raw;
>    
>     With this fix, I'm seeing lots of really strange things happen.
>     When eth0 comes up, the box slows down to a crawl.
>     5 minutes later when it gets to starting NIS, the
>     broadcast address is bombed with portmap connections.
> 
> Andi?

I've also seen:

127.0.0.1 sent an invalid ICMP error to a broadcast.

from the ipv4 stack after fixing these as per the Andi's patch.  I'm not
certain what's causing it; it only happens while the box is coming up.

In addition, there was another case in the icmp6 code that Andi confirmed
last night:

--- ref/net/ipv6/icmp.c	Fri Oct  5 17:53:04 2001
+++ linux/net/ipv6/icmp.c	Sun Jan 20 23:05:01 2002
@@ -258,7 +258,7 @@
 {
 	u8 optval;
 
-	offset += skb->nh.raw - skb->data;
+	offset += skb->data - skb->nh.raw;
 	if (skb_copy_bits(skb, offset, &optval, 1))
 		return 1;
 	return (optval&0xC0) == 0x80;

(another mail will be following this one with another patch...)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

