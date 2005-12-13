Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVLMOc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVLMOc5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964950AbVLMOc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:32:57 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:62757 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964948AbVLMOc4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:32:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QjsZlyxsJtTWEWZm/VEMAFdpYYryqxuA+x2igvBk5jjrVhXIvDAgXYINRep6teioUc8ms1KdCv6g1IN0iKEmYZKpOdaSyJiGhqOSMmBs7AdekFdmjBUGs5sCnVG2R5yo9yfwSkknrvit6rbf+DRDyNTXFIozmZ9ioeELSOtwwkE=
Message-ID: <81083a450512130632x59e86d35ka91ca5e37fecd7d7@mail.gmail.com>
Date: Tue, 13 Dec 2005 20:02:55 +0530
From: Ashutosh Naik <ashutosh.naik@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] Prevent overriding of Symbols in the Kernel, avoiding Undefined behaviour
Cc: Andrew Morton <akpm@osdl.org>, anandhkrishnan@yahoo.co.in,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, rth@redhat.com,
       greg@kroah.com, Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1134427712.10304.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <81083a450512120439h69ccf938m12301985458ea69f@mail.gmail.com>
	 <20051212111322.40be4cfe.akpm@osdl.org>
	 <1134427712.10304.6.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Its almost the 0% solution. The kernel as shipped doesn't seem to have
> any clashing symbols like this. The two sets of cases people report are
>
> 1. Out of tree modules
> 2. Reconfiguring, rebuilding something from kernel to module and not
> cleaning up
>
> A dep time solution might fix one of those but robustness here would be
> good, especially as once the installation is incorrect end users can
> often trigger hotplug loads that cause problems.

I agree with this.

I also would like to add that, the exported symbol may not always be
in the same module. Imagine if Module A is loaded and Module B would
export one symbol with the same symbol name as a symbol in Module A,
then the symbol exported by Module B would still go through. Now
Imagine if that symbol does something like a kmem_cache_create of an
existing cache!!

I feel this is a security loophole and preventing duplicate *exported*
symbols in the kernel, might just solve it.

Regards
Ashutosh
