Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265636AbTABEq3>; Wed, 1 Jan 2003 23:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbTABEq3>; Wed, 1 Jan 2003 23:46:29 -0500
Received: from are.twiddle.net ([64.81.246.98]:2691 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265636AbTABEq1>;
	Wed, 1 Jan 2003 23:46:27 -0500
Date: Wed, 1 Jan 2003 20:54:04 -0800
From: Richard Henderson <rth@twiddle.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
       davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
Message-ID: <20030101205404.B30272@twiddle.net>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, ak@suse.de,
	davem@redhat.com, paulus@samba.org, rmk@arm.linux.org.uk
References: <20030102030044.D066C2C05E@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030102030044.D066C2C05E@lists.samba.org>; from rusty@rustcorp.com.au on Thu, Jan 02, 2003 at 02:00:27PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 02:00:27PM +1100, Rusty Russell wrote:
> +	/* Find .plt and .pltinit sections */

Typo.

> +/* Make empty sections for module_frob_arch_sections to expand. */
> +#ifdef MODULE
> +asm(".section .plt,\"aws\",@nobits; .align 3; .previous");
> +asm(".section .plt.init,\"aws\",@nobits; .align 3; .previous");

Should use "ax", do make the plt sections executable,
since the plt section contains code that branches.
Additionally, this will place the .plt section next
to .text, which improves icache usage, and minimizes
the branch distance.

Incidentally, why do we do strstr(name, ".init") instead
of strncmp(name, ".init", 5)?  Is there any particular
need for the .init to come at the end?


r~
