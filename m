Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVHLUFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVHLUFF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVHLUFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:05:05 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:18923 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750716AbVHLUFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:05:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=kh3U1wlWVZWKYL0achf7CDvjpGKAfGU5hFtcVT6VBWZsXcZuPuZd0EctKFtq1/WgjI04VJZVINEu3wa6MifiWolz2oeVawBPjNJfarjItPMsHGOc6oaJAVKTa/ClIwNepbyWQl4qVcrSMAD7URrw0TEtLziwG2DlK48GKmk4cUI=
Date: Sat, 13 Aug 2005 00:13:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-kernel@vger.kernel.org, James Morris <jmorris@namei.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch][-mm] selinux:  Reduce memory use by avtab
Message-ID: <20050812201329.GA13689@mipter.zuzino.mipt.ru>
References: <1123788744.7810.115.camel@moss-spartans.epoch.ncsc.mil> <20050811203455.GA16409@mipter.zuzino.mipt.ru> <1123850840.23483.12.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123850840.23483.12.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 08:47:20AM -0400, Stephen Smalley wrote:
> Should -Wbitwise be included in CHECKFLAGS in the kernel Makefile by
> default?

It should but not right now ;-).

$ grep -c "warning: " W_sparse_*
W_sparse_i386:14887
W_sparse_ppc:16214
W_sparse_ppc64:15765
W_sparse_sparc:8906
W_sparse_sparc64:14446
W_sparse_x86_64:14366

(allmodconfig)

Most of them exist because of things like "ntohl(u32 struct->field)"
where "field" is really __be32 but nobody bothered to annotate it. I'm
slowly digging through logs.

