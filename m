Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTJ0USJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 15:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTJ0USJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 15:18:09 -0500
Received: from [62.38.226.53] ([62.38.226.53]:13245 "EHLO pfn1.pefnos")
	by vger.kernel.org with ESMTP id S263584AbTJ0USG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 15:18:06 -0500
From: "P. Christeas" <p_christ@hol.gr>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.0-test9, aic7xxx [passed]
Date: Mon, 27 Oct 2003 23:18:53 +0300
User-Agent: KMail/1.5.3
Cc: gibbs@scsiguy.com, linux-kernel@vger.kernel.org
References: <200310262051.32801.p_christ@hol.gr> <20031026191641.497132ec.akpm@osdl.org>
In-Reply-To: <20031026191641.497132ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310272218.53181.p_christ@hol.gr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> "P. Christeas" <p_christ@hol.gr> wrote:
> > One more, (as reported a few weeks ago):
> > rmmod aic7xxx
> > will fail, as this module uses some wrong locks. This will also block
> > sleeping (tested w. ACPI) if the module is there.
> > IMHO this module is crucial to many systems.
>
> The rmmod works OK for me, in the sense that the module is removed, the
> kernel doesn't crash and the module can be reloaded.
>
> But yes, there are several locking problems in there:
>
> - ahc_free() now sleeps, deep down in the kobject layer somewhere (it
>   calls /sbin/hotplug).
>
>   This is a likely fix for that:
>

You 're right. I just tested -test9 and it can fully rmmod the module. I 
recall that in -test5, 7 the module wouldn't be cleaned, but now it's OK. The 
warnings (enabled by the .config option) still appear (several of them). I am 
on a UP, however and don't know if a SMP system would happen to have trouble.
I'll also give your patch a try. 

Thanks.

