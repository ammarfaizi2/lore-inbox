Return-Path: <linux-kernel-owner+w=401wt.eu-S932632AbWLMJRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWLMJRr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 04:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWLMJRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 04:17:47 -0500
Received: from elvis.mu.org ([192.203.228.196]:50883 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932629AbWLMJRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 04:17:46 -0500
X-Greylist: delayed 1875 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 04:17:46 EST
Message-ID: <457FBDBE.10102@FreeBSD.org>
Date: Wed, 13 Dec 2006 00:45:50 -0800
From: Suleiman Souhlal <ssouhlal@FreeBSD.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, balbir@in.ibm.com, csturtiv@sgi.com,
       daw@sgi.com, guillaume.thouvenin@bull.net, jlan@sgi.com,
       nagar@watson.ibm.com, tee@sgi.com
Subject: Re: [patch 03/13] io-accounting: write accounting
References: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
In-Reply-To: <200612081152.kB8BqQvb019756@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org wrote:
> From: Andrew Morton <akpm@osdl.org>
> 
> Accounting writes is fairly simple: whenever a process flips a page from clean
> to dirty, we accuse it of having caused a write to underlying storage of
> PAGE_CACHE_SIZE bytes.

On architectures where dirtying a page doesn't cause a page fault (like i386), couldn't you end up billing the wrong process (in fact, I think that even on other archituctures set_page_dirty() doesn't get called immediately in the page fault handler)? 

AFAICS, set_page_dirty() is mostly called when trying to unmap a page when trying to shrink LRU lists, and there is no guarantee that this happens under the process that dirtied it (in fact, the set_page_dirty() is often done by kswapd).

-- Suleiman
