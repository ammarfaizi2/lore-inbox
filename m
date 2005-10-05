Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVJEQyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVJEQyG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVJEQyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:54:06 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:20876 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030245AbVJEQyE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:54:04 -0400
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:53:55 -0700
Message-Id: <1128531235.26009.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> +static struct page *
> +fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
> {
...
> +       /*
> +        * Here, the alloc type lists has been depleted as well as the global
> +        * pool, so fallback. When falling back, the largest possible block
> +        * will be taken to keep the fallbacks clustered if possible
> +        */
> +       while ((alloctype = *(++fallback_list)) != -1) {

That's a bit obtuse.  Is there no way to simplify it?  Just keeping an
index instead of a fallback_list pointer should make it quite a bit
easier to grok.

-- Dave

