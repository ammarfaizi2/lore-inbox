Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVLKNTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVLKNTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 08:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVLKNTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 08:19:21 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:10903 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751360AbVLKNTU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 08:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YEqapjBn5QugBpixrInqyBYq6NfOYBs4PImzOCRmAiMkX7ziPUcCIc1kSl3ZSE+8GL9DHyiqMaNAvDQrO5Zzv3UkcWy+QTl6tLV+p3tAvS/d88CXGQOvEHXIakgHfP3PNj1CkUIleMbh4GtnLZlm8zR1kjSqRfwGo68YqKX64So=
Message-ID: <9a8748490512110519r418560eek952cb976ab84a776@mail.gmail.com>
Date: Sun, 11 Dec 2005 14:19:19 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Gregor Jasny <gjasny@web.de>
Subject: Re: [PATCH] Reduce nr of ptr derefs in drivers/pci/hotplug/pciehp_core.c
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <439C24DB.3050307@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512110641.42992.jesper.juhl@gmail.com>
	 <439C24DB.3050307@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/05, Gregor Jasny <gjasny@web.de> wrote:
> Jesper Juhl schrieb:
> > --- linux-2.6.15-rc5-git1-orig/drivers/pci/hotplug/pciehp_core.c      2005-12-04 18:48:04.000000000 +0100
> > +++ linux-2.6.15-rc5-git1/drivers/pci/hotplug/pciehp_core.c   2005-12-11 05:46:58.000000000 +0100
> @@ -114,59 +117,66 @@ static int init_slots(struct controller
>         slot_number = ctrl->first_slot;
>
>         while (number_of_slots) {
> -               new_slot = kmalloc(sizeof(*new_slot), GFP_KERNEL);
> -               if (!new_slot)
> +               slot = kmalloc(sizeof(*slot), GFP_KERNEL);
> +               if (!slot)
>                         goto error;
>
> -               memset(new_slot, 0, sizeof(struct slot));
> -               new_slot->hotplug_slot =
> -                       kmalloc(sizeof(*(new_slot->hotplug_slot)),
> +               memset(slot, 0, sizeof(struct slot));
> +               slot->hotplug_slot =
> +                               kmalloc(sizeof(*(slot->hotplug_slot)),
>
> Just one suggestion:
>
> In your patches I've seen a lot of kmalloc + memset calls. Perhaps you
> can convert them to kzalloc? This would improve readability even more.
>

Good idea, but I think I'll do that as a seperate round of patches at
a later date. Added to my todo list. Thanks.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
