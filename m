Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263682AbTJZXzM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 18:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263685AbTJZXzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 18:55:11 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:34056 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S263682AbTJZXzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 18:55:06 -0500
From: Matt Gibson <gothick@gothick.org.uk>
Organization: The Wardrobe Happy Cow Emporium
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 compile error in iptable_filter.c (include/net/sock.h)
Date: Sun, 26 Oct 2003 08:37:04 +0000
User-Agent: KMail/1.5.4
References: <200310260004.57746.gothick@gothick.org.uk>
In-Reply-To: <200310260004.57746.gothick@gothick.org.uk>
X-Pointless-MIME-Header: yes
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310260837.04195.gothick@gothick.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 Oct 2003 00:04, I wrote:
>   CC [M]  net/ipv4/netfilter/iptable_filter.o
> In file included from include/linux/ip.h:84,
>                  from include/linux/netfilter_ipv4/ip_tables.h:22,
>                  from net/ipv4/netfilter/iptable_filter.c:7:
> include/net/sock.h:589: parse error before `size'
> include/net/sock.h:591: warning: function declaration isn't a prototype
> make[3]: *** [net/ipv4/netfilter/iptable_filter.o] Error 1
> make[2]: *** [net/ipv4/netfilter] Error 2
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
>
> I've not seen this one before; had no compile problems with any of the
> 2.6.0 series, in fact.  Config is unchanged from test8, and I did a "make
> clean" before building, just for luck...  I've had a very quick look and
> can't see anything obvious, but it's late and I'm tired.  

Well, that was weird.  I still couldn't see anything wrong this morning, so I 
commented out the line (declaration of sock_alloc_send_skb()), to see 
whether the compile error disappeared or moved on to the next line.  Built a 
little, and the include file didn't give any problems.  Stared at the header 
some more, and nothing seemed to make sense, as there are earlier 
declarations which start exactly the same.  So I used "undo" in Emacs to get 
the file back _exactly_ how it was in the first place, and saved it.

Then I did a "make clean" and "make" again, and it worked fine.  This was the 
point I started doubting my own sanity.  Especially after I'd checked the 
diff and saw that nothing in the area had been changed by the move from 8 to 
9.

I guess we can forget about that one.  Cosmic ray?

M

-- 
"It's the small gaps between the rain that count,
 and learning how to live amongst them."
	      -- Jeff Noon
