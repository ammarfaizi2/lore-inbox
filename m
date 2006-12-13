Return-Path: <linux-kernel-owner+w=401wt.eu-S1751720AbWLMXSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbWLMXSa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 18:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbWLMXS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 18:18:29 -0500
Received: from postel.suug.ch ([194.88.212.233]:60783 "EHLO postel.suug.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbWLMXS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 18:18:29 -0500
Date: Thu, 14 Dec 2006 00:18:48 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, Al Viro <viro@ftp.linux.org.uk>,
       David Miller <davem@davemloft.net>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213231848.GY8693@postel.suug.ch>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net> <20061213201213.GK4587@ftp.linux.org.uk> <20061213204933.GW8693@postel.suug.ch> <20061213150143.2672e0b1@dxpl.pdx.osdl.net> <20061213231217.GB3629@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213231217.GB3629@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> 2006-12-14 00:12
> On Wed, Dec 13, 2006 at 03:01:43PM -0800, Stephen Hemminger wrote:
> > Loopback should be there before protocols are started. It makes sense
> > to have a standard startup order.
> 
> This actually becomes easier after my patch:
> 
> Now that it's untangled from net_olddevs_init(), you can simply change 
> the module_init(loopback_init) to a different initcall level.

Not really, the device management inits as subsys, the ip layer hooks
into fs_initcall() which comes right after. The loopback was actually
registered after the protocol so far. I think Adrian's patch is fine
if the module_init() is changed to device_initcall().
