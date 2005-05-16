Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVEPP1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVEPP1R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVEPP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:27:09 -0400
Received: from holomorphy.com ([66.93.40.71]:31368 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261687AbVEPPXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:23:14 -0400
Date: Mon, 16 May 2005 08:22:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Roberto Fichera <kernel@tekno-soft.it>, linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
Message-ID: <20050516152257.GL9304@holomorphy.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it> <428898CF.5060908@cosmosbay.com> <6.2.1.2.2.20050516151659.077cceb0@mail.tekno-soft.it> <4288AB6A.3060106@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4288AB6A.3060106@cosmosbay.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Fichera a ?crit :
>> Why I need 4GB/4GB split? What are the beneficts?

On Mon, May 16, 2005 at 04:17:14PM +0200, Eric Dumazet wrote:
> Well... 4GB for your process is better than 3GB, that's 33% more space...
> If your process is cpu bounded (and not issuing too many system calls),
> then 4GB/4GB split let it address more ram, reducing the need to shift 
> windows in mmaped files for example.

Most of the benefit of this can be recovered by organizing the user
address space for compactness without incurring the context switch
overhead of TLB reloads or TLB footprint of a separate kernel address
space (or other issues of a third-party patch). Linking with low
starting text addresses, stack below text, and manual placement of
mmap()'s all help to conserve user virtualspace. It's also useful
in tandem with such in order to extract the maximum benefit from
the additional virtualspace (as the costs above warrant recovery).


-- wli
