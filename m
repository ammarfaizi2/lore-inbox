Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWDEWDE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWDEWDE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWDEWDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:03:04 -0400
Received: from smtp-out.google.com ([216.239.45.12]:26411 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932093AbWDEWDC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:03:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=jgnGiGTDue/iowVINWX8xq75IcKvOXvPxFqeWWStxaRAGfbpc5SMY8TwcHfPul83c
	vJrrduk6gtQ8lpFzwlilg==
Message-ID: <44343E86.30301@google.com>
Date: Wed, 05 Apr 2006 15:02:46 -0700
From: Daniel Phillips <phillips@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/16] UML - Memory hotplug
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org> <20060325010524.GA8117@ccure.user-mode-linux.org>
In-Reply-To: <20060325010524.GA8117@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> This is the big question with this patch.  How incestuous do I want to
> get with the VM system in order to get it to free up pages?  For now,
> I decided to be fairly hands-off, allocate as many pages as I can get,
> and return the total number to the host.  The host, if it wasn't happy
> with the results, can wait a bit while the UML notices that it is
> really low on memory and frees some up, and then hit up the UML for
> the remainder.

And also wrote:
> page = alloc_page(GFP_ATOMIC);

A slightly different objection than Andrew's: this will rapidly eat up
all the pages available for, e.g., receiving network packets, probably
not what you want.  How about flags=0?  This will dip a little way into
reserves but not as far as interrupts or realtime tasks, and will not
attempt any reclaim.  (Maybe we should have a GFP define for that.)

> INIT_LIST_HEAD(&unplugged->list);
> list_add(&unplugged->list, &unplugged_pages);

You don't need to initialize the list element you are adding.

Regards,

Daniel
