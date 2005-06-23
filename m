Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVFWB7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVFWB7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVFWB5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:57:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39078 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262014AbVFWBzP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:55:15 -0400
Date: Wed, 22 Jun 2005 21:55:03 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: lorenzo@gnu.org
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>, <sds@tycho.nsa.gov>
Subject: Re: [patch 1/1] selinux: minor cleanup in the hooks.c:file_map_prot_check()
 code
In-Reply-To: <20050622221541.CE72F56C741@estila.tuxedo-es.org>
Message-ID: <Xine.LNX.4.44.0506222150590.10175-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jun 2005 lorenzo@gnu.org wrote:

> Minor cleanup of the SELinux hooks code (hooks.c) around
> some definitions of return values.

>  static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
>  {
> +	int rc;
> +
>  #ifndef CONFIG_PPC32
>  	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
>  		/*
> @@ -2426,7 +2428,7 @@ static int file_map_prot_check(struct fi
>  		 * private file mapping that will also be writable.
>  		 * This has an additional check.
>  		 */
> -		int rc = task_has_perm(current, current, PROCESS__EXECMEM);
> +		rc = task_has_perm(current, current, PROCESS__EXECMEM);
>  		if (rc)
>  			return rc;
>  	}

What is the point of this?  You're needlessly increasing the scope of rc 
and you'll also get a compiler warning on ppc32.

> @@ -2485,7 +2487,7 @@ static int selinux_file_mprotect(struct 
>  		 * check ability to execute the possibly modified content.
>  		 * This typically should only occur for text relocations.
>  		 */
> -		int rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
> +		rc = file_has_perm(current, vma->vm_file, FILE__EXECMOD);
>  		if (rc)
>  			return rc;
>  	}
> _

No, causes ppc32 warning.

Please send SELinux kernel patches via the maintainers.


- James
-- 
James Morris
<jmorris@redhat.com>


