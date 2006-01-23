Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWAWSmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWAWSmB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964881AbWAWSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:42:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:36261 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964887AbWAWSl7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:41:59 -0500
Date: Mon, 23 Jan 2006 12:41:57 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
Message-ID: <20060123184157.GA11148@sergelap.austin.ibm.com>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (akpm@osdl.org):
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/

I have a problem on powerpc from
zone_reclaim-reclaim-on-memory-only-node-support.patch:

mm/vmscan.c: In function `zone_reclaim':
mm/vmscan.c:1845: error: invalid lvalue in unary `&'

The preprocessed output is:

if (!(gfp_mask & (( gfp_t)0x10u)) ||
(!__cpus_empty(&(node_to_cpumask(zone->zone_pgdat->node_id)), 128) &&
...

I don't understand why this wouldn't die on every architecture,
since node_to_cpumask is an inline function.

(Using gcc version 3.4.4 20050721 (Red Hat 3.4.4-2))

thanks,
-serge
