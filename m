Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWETALg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWETALg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWETALf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:11:35 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:50875 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751444AbWETALf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:11:35 -0400
In-Reply-To: <1148034391.3875.109.camel@pmac.infradead.org>
References: <20060518160940.GS7570@earth.li> <20060518165728.GA26113@wohnheim.fh-wedel.de> <20060519090142.GB7570@earth.li> <20060519100303.GB17270@wohnheim.fh-wedel.de> <1148034391.3875.109.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1C9E7AB3-2DD3-40EA-B0F1-E0713A58E490@kernel.crashing.org>
Cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Jonathan McDowell <noodles@earth.li>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Add Amstrad Delta NAND support.
Date: Sat, 20 May 2006 02:10:57 +0200
To: David Woodhouse <dwmw2@infradead.org>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> And please create a structure containing both struct mtd_info and
>>>> struct nand_chip.  Then use sizeof(that structure)...

> It's fine as-is. The claim that it's nicer to introduce an extra
> datatype just for the allocation is subjective, at best.

Not just for the allocation, but also for getting the address of
the second struct, after that allocation.

If the second struct has bigger alignment required than the first,
the current code gets the second struct misaligned.  Putting both
into one bigger struct would add the required padding.

(Say: sizes 4 and 8, alignment requirements 4 and 8 resp.)


Segher

