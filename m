Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWAVVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWAVVGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAVVGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:06:00 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:23046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751363AbWAVVF7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:05:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RKaTq81ftHIHY7eJAdYPMK1w+tUHYGnUPt+1Tp+7vpDzluzpJM+v7ZURO1RPmeWozlJ/HXFqrvv5TF6AQvr3khejrEZfPneV9GllE4nEZVK2k1nOXs1kZV8nSeKbYKVU7z0QrJhSchpenZ+rprvBfDGYDeAqVAVW+qfh2htvyxE=
Message-ID: <12c511ca0601221259i25f26410l5c94871b7495283f@mail.gmail.com>
Date: Sun, 22 Jan 2006 12:59:02 -0800
From: Tony Luck <tony.luck@intel.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] disable per cpu intr in /proc/stat
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
In-Reply-To: <20060122123150.3a289ac3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060122202204.GA26295@suse.de>
	 <20060122123150.3a289ac3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Andrew Morton <akpm@osdl.org> wrote:
> Olaf Hering <olh@suse.de> wrote:
> > Don't compute and display the per-irq sums on ia64 either, too much
> > overhead for mostly useless figures.
>
> We'd need a big ack from the ia64 team for this, please.

This was found early in December.  I proposed:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113398553428807&w=2
dropping it for all architectures, but got no response.

The problem is the horribly cache unfriendly scan of all percpu
structures ... not too much of a problem for low cpu count, but
really bad when the count gets high (just configured high is
enough to cause the problem in a CONFIG_HOTPLUG_CPU
kernel ... even if the cpu isn't present we still scan).

An alternative if someone really is using these values would be
to compute the sums earlier in the function ... but that would
require a memory allocation to save the per-irq sums.

Unless someone comes up soon with the name of an existing
application that depends on these per-irq sums, consider this

Acked-by: Tony Luck <tony.luck@intel.com>

-Tony
