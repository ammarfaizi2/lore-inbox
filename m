Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWDFAoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWDFAoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 20:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWDFAoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 20:44:04 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:28574 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932132AbWDFAoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 20:44:03 -0400
Date: Thu, 6 Apr 2006 09:45:33 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Hideo AOKI <haoki@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/3] mm: An enhancement of OVERCOMMIT_GUESS
Message-Id: <20060406094533.b340f633.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <4434570F.9030507@redhat.com>
References: <4434570F.9030507@redhat.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, AOKI-san

On Wed, 05 Apr 2006 19:47:27 -0400
Hideo AOKI <haoki@redhat.com> wrote:

> Hello Andrew,
> 
> Could you apply my patches to your tree?
> 
> These patches are an enhancement of OVERCOMMIT_GUESS algorithm in
> __vm_enough_memory(). The detailed description is in attached patch.
> 

I think adding a function like this is more simple way.
(call this istead of nr_free_pages().)
==
int nr_available_memory() 
{
	unsigned long sum = 0;
	for_each_zone(zone) {
		if (zone->free_pages > zone->pages_high)
			sum += zone->free_pages - zone->pages_high;
	}
	return sum;
}
==

BTW, vm_enough_memory() doesn't eat cpuset information ?

-Kame

