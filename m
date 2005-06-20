Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVFUCHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVFUCHk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 22:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbVFTW7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 18:59:11 -0400
Received: from opersys.com ([64.40.108.71]:9745 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261344AbVFTWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:36:55 -0400
Message-ID: <42B74781.8000109@opersys.com>
Date: Mon, 20 Jun 2005 18:47:29 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Philippe Gerum <rpm@xenomai.org>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] I-pipe: Core implementation
References: <42B35B07.7080703@xenomai.org> <20050618170139.GA477@openzaurus.ucw.cz> <42B7272F.2040503@xenomai.org>
In-Reply-To: <42B7272F.2040503@xenomai.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Philippe Gerum wrote:
> There's a fourth one (ipipe/x86.c) added by the arch-dependent patch, 
> but yes, I agree that this could sound rather overkill to have this 
> support in its own dir, especially a top-level one. The files under 
> ipipe/ can be built as a loadable module, hence the current layout.
> Would you see this belonging to, e.g., the driver tree instead?

How about this instead:

Arch-indepedent parts:
----------------------
include/linux/ipipe.h

kernel/ipipe/Kconfig      (formerly ipipe/Kconfig)
kernel/ipipe/Makefile     (formerly ipipe/Makefile)
kernel/ipipe/core.c       (formerly kernel/ipipe.c)
kernel/ipipe/generic.c    (formerly ipipe/generi.c)

Arch-dependent parts:
---------------------
include/asm-i386/ipipe.h

arch/i386/kernel/ipipe-core.c  (formerly arch/i386/kernel/ipipe.c)
arch/i386/kernel/ipipe-root.c  (formerly ipipe/x86.c)

Seems to me that the above makes more sense. Albeit you would have
parts of the module in kernel/ipipe/* and the rest in
arch/*/kernel/ipipe*.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
