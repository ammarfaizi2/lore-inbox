Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262392AbUKKVdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUKKVdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 16:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262387AbUKKVdQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 16:33:16 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:63140 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262388AbUKKVdK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 16:33:10 -0500
Date: Thu, 11 Nov 2004 22:31:30 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH] MII bus API for PHY devices
Message-ID: <20041111213130.GA13327@electric-eye.fr.zoreil.com>
References: <20041111194526.GA17735@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041111194526.GA17735@jmcmullan.timesys>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason McMullan <jason.mcmullan@timesys.com> :
> First patch for consolidation of PHY handling into one location.

A little pass of polish could make it more cool imho:
- macro abuse;
- unchecked malloc;
- use plain old style multi-lines C comments (/* ...\n * ... \n * ... \n */) ?
- whitespace/tabulation damage (search for series of 2 or more spaces);
- hidden return: please put them on a separate line;
- no need to BUG_ON when there is an immediate dereference;
- mixed case variables/names (pLEAse DO not dO tHAT);
- unneeded checks ? How could VALID_BUS() in mii_bus_write() fail ?
- use goto when locking primitives are used (btw the last check in
  mii_bus_register is not needed and you can s/mii_bus[bus_id]/bus/ 
  a few times in this function) ?
- add a break in mii_bus_unregister() ?
- I'd probably favor ternary operators here and there (your choice, really)
- u32 and uint16_t in the same file: choose one style ?

--
Ueimor
