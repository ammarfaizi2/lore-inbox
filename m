Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265507AbTFMTuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTFMTuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:50:08 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:23197 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265507AbTFMTtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:49:00 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Greg KH <greg@kroah.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Date: Fri, 13 Jun 2003 22:01:47 +0200
User-Agent: KMail/1.5.1
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
References: <3EE8D038.7090600@mvista.com> <1055459762.662.336.camel@localhost> <20030612232523.GA1917@kroah.com>
In-Reply-To: <20030612232523.GA1917@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306132201.47346.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +	spin_lock(&sequence_lock);
> +	envp [i++] = scratch;
> +	scratch += sprintf(scratch, "SEQNUM=%ld", sequence_num) + 1;
> +	++sequence_num;
> +	spin_unlock(&sequence_lock);
>
>  	kobj_path_length = get_kobj_path_length (kset, kobj);
>  	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);

If this kmalloc fails, you'll have a hole in the numbers and
user space will be very confused. You need to report dropped
events if you do this.

	Regards
		Oliver

