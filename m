Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWA3JXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWA3JXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932160AbWA3JXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:23:07 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41666
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932159AbWA3JXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:23:04 -0500
Date: Mon, 30 Jan 2006 01:22:59 -0800 (PST)
Message-Id: <20060130.012259.78361400.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: bcrl@kvack.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Questions about alloc_large_system_hash() and TLB entries
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <43DDD66C.4060201@cosmosbay.com>
References: <20060129200504.GD28400@kvack.org>
	<43DD2C15.1090800@cosmosbay.com>
	<43DDD66C.4060201@cosmosbay.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Mon, 30 Jan 2006 10:03:40 +0100

> What would be the needed changes in the code to get both :
> 
>    - Allocate ram equally from all the nodes of the machine
> 
>    - Use large pages (2MB) to lower TLB stress

These two desires are mutually exclusive, I think.

If you want an 8MB hash table, for example, with 2MB mappings
you could use memory from a maximum of 4 nodes since the
2MB chunks have to be physically 2MB aligned and 2MB contiguous.
