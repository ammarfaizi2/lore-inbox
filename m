Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289010AbSAUCMg>; Sun, 20 Jan 2002 21:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289011AbSAUCM1>; Sun, 20 Jan 2002 21:12:27 -0500
Received: from ns.suse.de ([213.95.15.193]:46607 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289010AbSAUCMR>;
	Sun, 20 Jan 2002 21:12:17 -0500
Date: Mon, 21 Jan 2002 03:12:11 +0100
From: Dave Jones <davej@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: martin.macok@underground.cz, linux-kernel@vger.kernel.org
Subject: Re: [andrewg@tasmail.com: remote memory reading through tcp/icmp]
Message-ID: <20020121031211.B29830@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"David S. Miller" <davem@redhat.com>, martin.macok@underground.cz,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020121015209.A26413@sarah.kolej.mff.cuni.cz> <20020120.175204.18636524.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020120.175204.18636524.davem@redhat.com>; from davem@redhat.com on Sun, Jan 20, 2002 at 05:52:04PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2002 at 05:52:04PM -0800, David S. Miller wrote:
 > Pretty simple to fix, from Andi Kleen:
 > 
 > --- linux-work/net/ipv4/icmp.c-o	Tue Jan 15 11:05:17 2002
 > +++ linux-work/net/ipv4/icmp.c	Sun Jan 20 23:31:29 2002
 > @@ -495,7 +495,7 @@
 >  	icmp_param.data.icmph.checksum=0;
 >  	icmp_param.csum=0;
 >  	icmp_param.skb=skb_in;
 > -	icmp_param.offset=skb_in->nh.raw - skb_in->data;
 > +	icmp_param.offset=skb_in->data - skb_in->nh.raw;

 With this fix, I'm seeing lots of really strange things happen.
 When eth0 comes up, the box slows down to a crawl.
 5 minutes later when it gets to starting NIS, the
 broadcast address is bombed with portmap connections.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
