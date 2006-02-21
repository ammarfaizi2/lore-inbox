Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161273AbWBUCAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161273AbWBUCAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161278AbWBUCAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:00:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45070 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161277AbWBUCAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:00:13 -0500
Date: Tue, 21 Feb 2006 03:00:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: 2.6.16-rc4-mm1
Message-ID: <20060221020012.GU4661@stusta.de>
References: <20060220042615.5af1bddc.akpm@osdl.org> <43F9BDDA.1060508@reub.net> <43F9CE18.10709@trash.net> <20060220204456.GG4661@stusta.de> <43FA6A2C.8000905@trash.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FA6A2C.8000905@trash.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:17:32AM +0100, Patrick McHardy wrote:
> 
> Arnaldo apparently wants to fix it differently, but maybe you could help
> us with conntrack :) CONFIG_IP_NF_CONNTRACK and CONFIG_NF_CONNTRACK
> should be mutually exclusive. Specifying
> 
> CONFIG_IP_NF_CONNTRACK
> 	depends on CONFIG_NF_CONNTRACK=n
> 
> CONFIG_NF_CONNTRACK
> 	depends on CONFIG_IP_NF_CONNTRACK=n
> 
> will avoid asking for NF_CONNTRACK when IP_NF_CONNTRACK is set, but not
> the other way around.


Even worse, kconfig will complain about a circular dependency.


CONFIG_IP_NF_CONNTRACK

CONFIG_NF_CONNTRACK
	depends on CONFIG_IP_NF_CONNTRACK=n


CONFIG_IP_NF_CONNTRACK will be visible if CONFIG_NF_CONNTRACK is set, 
but as soon as CONFIG_IP_NF_CONNTRACK is set, CONFIG_NF_CONNTRACK is 
automatically set to n.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

