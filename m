Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317504AbSG2DDl>; Sun, 28 Jul 2002 23:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317542AbSG2DDl>; Sun, 28 Jul 2002 23:03:41 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:8844 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S317504AbSG2DDk>;
	Sun, 28 Jul 2002 23:03:40 -0400
Date: Mon, 29 Jul 2002 13:05:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, arjanv@redhat.com
Subject: Re: [patch] APM fixes, 2.5.29
Message-Id: <20020729130556.48e6d27d.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0207281326150.21244-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0207281152430.12794-100000@localhost.localdomain>
	<Pine.LNX.4.44.0207281326150.21244-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Sun, 28 Jul 2002 13:28:34 +0200 (CEST) Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> the attached patch fixes two things:
> 
>  - a TLS related bug noticed by Arjan van de Ven: apm_init() should set up 
>    all CPU's gdt entries - just in case some code happens to call in the
>    APM BIOS on the wrong CPU. This should also handle the case when some 
>    APM code gets triggered (by suspend or power button or something).

Except, if you read the comment, we never do APM BIOS calls on anything
but CPU 0.  On SMP the only APM BIOS operation we allow is power off
and we have code to ensure we are on CPU 0 before we do that ...

>  - compilation problem

I would prefer a patch (see the post by Muli Ben-Yehuda
<mulix@actcom.co.il>) that defines num_possible_cpus() or equivalent, the
current code (using num_online_cpus()) is broken in places.

I need to revisit all this code in light of CPU hotplug ...
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
