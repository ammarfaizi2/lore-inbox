Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992604AbWJTMUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992604AbWJTMUe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 08:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992611AbWJTMUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 08:20:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:4168 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992604AbWJTMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 08:20:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ptf/NJConIyrwYkrJXozhQXLSkqDotXIK9nQIRV2iHdgsWEtVTmXvhJbU4UkyIe5I1WcG1+SxSjHSUW+L27Noa+8YuoAuNzEHj2YIMa/bCQIyl6wGEfXs6ELagB4gfsFNdsEAb4hvAaknap0T7ND4HFB//pApKok1hjVokK3x1s=
Message-ID: <9a8748490610200520j6d708a52p2f90effd4b8893d9@mail.gmail.com>
Date: Fri, 20 Oct 2006 14:20:31 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Marcus Meissner" <meissner@suse.de>
Subject: Re: [PATCH] binfmt_elf: randomize PIE binaries (2nd try)
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, arjan@linux.intel.com
In-Reply-To: <20061020115527.GB14448@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061020115527.GB14448@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/06, Marcus Meissner <meissner@suse.de> wrote:
> Randomizes -pie compiled binaries from PAGE_SIZE up to
> ELF_ET_DYN_BASE.
>
> 0 -> PAGE_SIZE is excluded to allow NULL ptr accesses
> to fail.
>
> Signed-off-by: Marcus Meissner <meissner@suse.de>
>
> ----
>  binfmt_elf.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> --- linux-2.6.18/fs/binfmt_elf.c.xx     2006-10-20 10:42:03.000000000 +0200
> +++ linux-2.6.18/fs/binfmt_elf.c        2006-10-20 10:51:27.000000000 +0200
> @@ -856,7 +856,13 @@
>                          * default mmap base, as well as whatever program they
>                          * might try to exec.  This is because the brk will
>                          * follow the loader, and is not movable.  */
> -                       load_bias = ELF_PAGESTART(ELF_ET_DYN_BASE - vaddr);
> +                       if (current->flags & PF_RANDOMIZE)
> +                               load_bias = randomize_range(PAGE_SIZE,
> +                                                           ELF_ET_DYN_BASE,
> +                                                           0);

How about putting the two lines above on one line?  ^^^^^

> +                                                           ELF_ET_DYN_BASE, 0);


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
