Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932555AbWASGTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932555AbWASGTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWASGTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:19:49 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:52089 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932555AbWASGTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:19:48 -0500
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Transfer-Encoding: 7bit
Message-Id: <5E8B8E4E-5572-4075-8FE7-A31F918B5F61@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: LKML List <linux-kernel@vger.kernel.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: proper way to deal with a sparse warning
Date: Thu, 19 Jan 2006 00:19:47 -0600
X-Mailer: Apple Mail (2.746.2)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following sparse warning:

drivers/net/gianfar_mii.c:165:16: warning: incorrect type in  
assignment (different address spaces)
drivers/net/gianfar_mii.c:165:16:    expected void *priv
drivers/net/gianfar_mii.c:165:16:    got struct gfar_mii [noderef] * 
[assigned] regs<asn:2>

This is line 165 of gianfar_mii.c:

         new_bus->priv = regs;

new_bus->priv is of type void *.  regs is of type struct gfar_mii  
__iomem *.

Is it acceptable to do the following:

	new_bus->priv = (void __force *)regs;

- kumar

