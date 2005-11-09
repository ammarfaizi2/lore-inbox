Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965150AbVKIBgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965150AbVKIBgk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 20:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKIBgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 20:36:40 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:9896 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932431AbVKIBgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 20:36:39 -0500
Message-ID: <43715266.5080900@jp.fujitsu.com>
Date: Wed, 09 Nov 2005 10:35:34 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: akpm@osdl.org, Mike Kravetz <kravetz@us.ibm.com>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       torvalds@osdl.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andi Kleen <ak@suse.de>, Magnus Damm <magnus.damm@gmail.com>,
       Paul Jackson <pj@sgi.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 5/8] Direct Migration V2: upgrade MPOL_MF_MOVE and sys_migrate_pages()
References: <20051108210246.31330.61756.sendpatchset@schroedinger.engr.sgi.com> <20051108210402.31330.19167.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051108210402.31330.19167.sendpatchset@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> +	err = migrate_pages(pagelist, &newlist, &moved, &failed);
> +
> +	putback_lru_pages(&moved);	/* Call release pages instead ?? */
> +
> +	if (err >= 0 && list_empty(&newlist) && !list_empty(pagelist))
> +		goto redo;


Here, list_empty(&newlist) is needed ?
For checking permanent failure case, list_empty(&failed) looks better.

-- Kame


