Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUIAVqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUIAVqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267625AbUIAVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:44:38 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2546 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268075AbUIAVHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:07:15 -0400
Date: Wed, 1 Sep 2004 23:07:07 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Rick Lindsley <ricklind@us.ibm.com>, Harald Welte <laforge@netfilter.org>,
       Nivedita Singhvi <niv@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org
Subject: 2.6.9-rc1-mm2: IP_NF_COMPAT_IPCHAINS compilation broken
Message-ID: <20040901210707.GC3466@fs.tum.de>
References: <20040830235426.441f5b51.akpm@osdl.org> <200408312213.i7VMDjF02854@owlet.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408312213.i7VMDjF02854@owlet.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 03:13:45PM -0700, Rick Lindsley wrote:
> Getting an error of:
> 
> net/built-in.o(.text+0x64047): In function `tcp_in_window':
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:683: undefined reference to `ip_ct_log_invalid'
> net/built-in.o(.text+0x6431f): In function `tcp_error':
> net/ipv4/netfilter/ip_conntrack_proto_tcp.c:792: undefined reference to `ip_ct_log_invalid'
> net/built-in.o(.text+0x64421):net/ipv4/netfilter/ip_conntrack_proto_tcp.c:817: undefined reference to `ip_ct_log_invalid'
> net/built-in.o(.text+0x64450):net/ipv4/netfilter/ip_conntrack_proto_tcp.c:808: undefined reference to `ip_ct_log_invalid'
> net/built-in.o(.text+0x64487):net/ipv4/netfilter/ip_conntrack_proto_tcp.c:784: undefined reference to `ip_ct_log_invalid'
> net/built-in.o(.text+0x6478a):net/ipv4/netfilter/ip_conntrack_proto_tcp.c:877: more undefined references to `ip_ct_log_invalid' follow
> 
> The error is for all references of the LOG_INVALID macro in
> ip_conntrack_proto_tcp.c.
>...

Harald, the LOG_INVALID macro from your

  [NETFILTER]: Move error tracking into conntrack protocol helper

patch in Linus' tree breaks compilation with 
CONFIG_IP_NF_COMPAT_IPCHAINS=y, since ip_ct_log_invalid isn't available 
in this case due to CONFIG_IP_NF_CONNTRACK=n.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

