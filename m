Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbTILR4N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 13:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTILR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 13:56:12 -0400
Received: from ns.suse.de ([195.135.220.2]:5870 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261772AbTILR4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 13:56:09 -0400
Date: Fri, 12 Sep 2003 19:56:06 +0200
From: Andi Kleen <ak@suse.de>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: jgarzik@pobox.com, akpm@osdl.org, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030912195606.24e73086.ak@suse.de>
In-Reply-To: <m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
	<20030910184414.7850be57.akpm@osdl.org>
	<20030911014716.GG3134@wotan.suse.de>
	<3F60837D.7000209@pobox.com>
	<20030911162634.64438c7d.ak@suse.de>
	<3F6087FC.7090508@pobox.com>
	<m1vfrxlxol.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Sep 2003 11:32:42 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:


> There may be better places to attack.  But new code is what is up for
> examination and is easiest to fix.

With is_prefetch:

   text    data     bss     dec     hex filename
   2782       4       0    2786     ae2 arch/i386/mm/fault.o

Without is_prefetch:

 text    data     bss     dec     hex filename
   2446       4       0    2450     992 arch/i386/mm/fault.o

Difference 332 bytes

If you start your attack on 332 bytes then IMHO you have your priorities wrong ;-)

The main reason I'm really against this is that currently the P4 kernels work
fine on Athlon. Just when is_prefetch is not integrated in them there will 
be an mysterious oops once every three months in the kernel in prefetch
on Athlon.
 
That would be bad. The alternative would be to prevent the P4 kernel
from booting on the Athlon at all, but doing that for 332 bytes
would seem a bit silly.

-Andi

P.S.: If you really want to shrink 2.6 I would start with making sysfs optional.
That would likely help much more than micro optimizing non bloated parts.
