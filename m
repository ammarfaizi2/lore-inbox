Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVHXWiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVHXWiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 18:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVHXWiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 18:38:10 -0400
Received: from mf00.sitadelle.com ([212.94.174.67]:24644 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S932336AbVHXWiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 18:38:09 -0400
Message-ID: <430CF6CA.8040302@cosmosbay.com>
Date: Thu, 25 Aug 2005 00:38:02 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: Re: [patch] Additions to .data.read_mostly section
References: <20050824214610.GA3675@localhost.localdomain>
In-Reply-To: <20050824214610.GA3675@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai a écrit :
> Following patch moves a few static 'read mostly' variables to the 
> .data.read_mostly section.  Typically these are vector - irq tables,
> boot_cpu_data, node_maps etc., which are initialized once and read from 
> often and rarely written to.  Please include.
> 

Good candidates for read_mostly are all the 'kmem_cache_t *xxx_cache'

slab was carefuly designed to eliminate cache line ping pongs on SMP, but if 
the initial pointer to slab sits in a heavily modified cache line, we loose.

Eric
