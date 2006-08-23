Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWHWNxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWHWNxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 09:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWHWNxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 09:53:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:40076 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932262AbWHWNxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 09:53:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=rnD26IrAShSWzbE+InD+6qpQ2tG7Q+9zg8JWE6uH55A1pTtdG3Rkc0djUtibSah0oz/4p77IA+TB7U4R2zDRYD7E6UgJ20u6ctf5PWYr+z9edSmpKi/MfVf3HFzwgZNVn0bzWrwTFz9RXunN4DpmUT1C2qkmKZxUPplDm6qQsVU=
Date: Wed, 23 Aug 2006 17:53:11 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, Greg KH <greg@kroah.com>,
       Oleg Nesterov <oleg@tv-sign.ru>, Matt Helsley <matthltc@us.ibm.com>,
       Rohit Seth <rohitseth@google.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
Subject: Re: [PATCH 2/6] BC: beancounters core (API)
Message-ID: <20060823135311.GD10449@martell.zuzino.mipt.ru>
References: <44EC31FB.2050002@sw.ru> <44EC35EB.1030000@sw.ru> <20060823133055.GB10449@martell.zuzino.mipt.ru> <44EC5CDB.5000505@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EC5CDB.5000505@sw.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+void __put_beancounter(struct beancounter *bc)
> >>+{
> >>+	unsigned long flags;
> >>+
> >>+	/* equivalent to atomic_dec_and_lock_irqsave() */
> >>+	local_irq_save(flags);
> >>+	if (likely(!atomic_dec_and_lock(&bc->bc_refcount, &bc_hash_lock))) {
> >>+		local_irq_restore(flags);
> >>+		if (unlikely(atomic_read(&bc->bc_refcount) < 0))
> >>+			printk(KERN_ERR "BC: Bad refcount: bc=%p, "
> >>+					"luid=%d, ref=%d\n",
> >>+					bc, bc->bc_id,
> >>+					atomic_read(&bc->bc_refcount));
> >
> >
> >Should this BUG_ON() ?
> BUG_ON doesn't print much information :)
> ok, will replace

but printk + BUG does ;-)

