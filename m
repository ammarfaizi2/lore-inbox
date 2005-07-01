Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVGAWwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVGAWwP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVGAWwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:52:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13032 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261617AbVGAWwJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:52:09 -0400
Date: Fri, 1 Jul 2005 18:51:58 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: shemminger@osdl.org, jgarzik@pobox.com
Subject: Re: [PATCH] skge: remove unused declarations
Message-ID: <20050701225158.GA6762@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	shemminger@osdl.org, jgarzik@pobox.com
References: <200506281916.j5SJGi5m012509@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506281916.j5SJGi5m012509@hera.kernel.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2005 at 12:16:44PM -0700, Linux Kernel wrote:
 > tree 6154380f95d261126525fc95eb149ddc8478eeea
 > parent 4707953454677f985289b4e4bcbea41f0cc651c2
 > author Stephen Hemminger <shemminger@osdl.org> Tue, 28 Jun 2005 01:33:08 -0700
 > committer Jeff Garzik <jgarzik@pobox.com> Tue, 28 Jun 2005 02:05:06 -0400
 > 
 > [PATCH] skge: remove unused declarations
 > 
 > Get rid of definitions for chip versions and PHY chips that
 > this driver does not support.
 > 
 > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
 > ...
 > -	PCI_EN_DUMMY_RD = 1<<3, /* Enable Dummy Read */
 > -	PCI_REV_DESC    = 1<<2, /* Reverse Desc. Bytes */
 > -	PCI_USEDATA64   = 1<<0, /* Use 64Bit Data bus ext */
 > -};

This bit breaks PPC builds, due to ..

   3145 #ifdef __BIG_ENDIAN
   3146     /* byte swap decriptors in hardware */
   3147     {
   3148         u32 reg;
   3149
   3150         pci_read_config_dword(pdev, PCI_DEV_REG2, &reg);
   3151         reg |= 1 << 2;  /* PCI_REV_DESC */
   3152         pci_write_config_dword(pdev, PCI_DEV_REG2, reg);
   3153     }
   3154 #endif

For my builds, I've just hardcoded it, I don't know if you prefer
to put the enum back or not..

		Dave
