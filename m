Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVCVQdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVCVQdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 11:33:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVCVQdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 11:33:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbVCVQdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 11:33:41 -0500
Date: Tue, 22 Mar 2005 17:33:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jkmaline@cc.hut.fi, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, hostap@shmoo.com, linux-net@vger.kernel.org
Subject: 2.6.12-rc1-mm1: hostap stack usage
Message-ID: <20050322163340.GD1948@stusta.de>
References: <20050321025159.1cabd62e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321025159.1cabd62e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 02:51:59AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.11-mm4:
>...
>  bk-netdev.patch
>...
>  Latest versions of various bk trees
>...


The stack usage in some files under drivers/net/wireless/hostap/ is
too high.


drivers/net/wireless/hostap/hostap_ioctl.c:

prism2_ioctl_giwaplist:
        struct sockaddr addr[IW_MAX_AP];
        struct iw_quality qual[IW_MAX_AP];

64 * (16 + 4) Bytes = 1280 Bytes

prism2_ioctl_ethtool:
        struct ethtool_drvinfo info = { ETHTOOL_GDRVINFO };

196 Bytes

__prism2_translate_scan:
        char buf[MAX_WPA_IE_LEN * 2 + 30];

(64 * 2) + 30 Bytes = 158 Bytes


drivers/net/wireless/hostap/hostap_cs.c:

prism2_config:
        cisparse_t parse;
        u_char buf[64];
        config_info_t conf;

The main offender seems to be "parse" (but I'm too lame counting how 
many bytes it's exactly) resulting in nearly 1 kB stack usage.


drivers/net/wireless/hostap/hostap_plx.c:

prism2_plx_check_cis:
#define CIS_MAX_LEN 256
        u8 cis[CIS_MAX_LEN];

256 Bytes



cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

