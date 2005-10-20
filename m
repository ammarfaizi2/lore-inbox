Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVJTXH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVJTXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964793AbVJTXH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:07:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964779AbVJTXHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:07:25 -0400
Date: Thu, 20 Oct 2005 16:06:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: kravetz@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       clameter@sgi.com, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 0/4] Swap migration V3: Overview
Message-Id: <20051020160638.58b4d08d.akpm@osdl.org>
In-Reply-To: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> Page migration is also useful for other purposes:
> 
>  1. Memory hotplug. Migrating processes off a memory node that is going
>     to be disconnected.
> 
>  2. Remapping of bad pages. These could be detected through soft ECC errors
>     and other mechanisms.

It's only useful for these things if it works with close-to-100% reliability.

And there are are all sorts of things which will prevent that - mlock,
ongoing direct-io, hugepages, whatever.

So before we can commit ourselves to the initial parts of this path we'd
need some reassurance that the overall scheme addresses these things and
that the end result has a high probability of supporting hot unplug and
remapping sufficiently well.
