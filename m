Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTLJHpN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262940AbTLJHpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:45:12 -0500
Received: from ns.suse.de ([195.135.220.2]:62168 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262794AbTLJHpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:45:09 -0500
Date: Wed, 10 Dec 2003 08:45:06 +0100
From: Andi Kleen <ak@suse.de>
To: Paul Menage <menage@google.com>
Cc: agrover@groveronline.com, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
Message-Id: <20031210084506.1908358a.ak@suse.de>
In-Reply-To: <3FD59441.2000202@google.com>
References: <3FD59441.2000202@google.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Dec 2003 01:22:09 -0800
Paul Menage <menage@google.com> wrote:

> Hi Andy,
> 
> The ACPI_ACQUIRE_GLOBAL_LOCK() macro in include/asm-i386/acpi.h looks a 
> little odd:

[...]

Thanks. I fixed the x86-64 version. RELEASE also needed similar treatment.


> Given the comments above the definition, I'm guessing that the "dummy" 
> parameter was added later for some reason (to tell gcc that ecx would 
> get clobbered? - but it doesn't seem to be clobbered), and the parameter 
> substitutions in the asm weren't updated. Unless I'm missing something 
> fundamental, shouldn't the definition be something more like this:

Numeric asm parameters are always evil and cause such bugs all the time. 
gcc 3.2+ has named asm parameters which makes this much cleaner and less error prone. 
Unfortunately they cannot be used in i386 because there are still people who insist 
on using ancient compilers :-(

-Andi

