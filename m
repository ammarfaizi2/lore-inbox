Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIHJZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIHJZa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWIHJZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:25:30 -0400
Received: from koto.vergenet.net ([210.128.90.7]:2720 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1750736AbWIHJZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:25:28 -0400
From: Horms <horms@verge.net.au>
To: vgoyal@in.ibm.com
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.17-2-686 (i686))
Message-Id: <20060908092524.E06FD34042@koto.vergenet.net>
Date: Fri,  8 Sep 2006 18:25:24 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Re: [PATCH] Kcore elf note namesz field fix
In-Reply-To: <20060905193222.GA29478@in.ibm.com>
X-Newsgroups: gmane.linux.kernel,gmane.comp.boot-loaders.fastboot.general

On Tue, 5 Sep 2006 15:32:22 -0400, Vivek Goyal wrote:
> 
> 
> 
> o As per ELF specifications, it looks like that elf note "namesz" field contains
>  the length of "name" including the size of null character. And 
>  currently we are filling "namesz" without taking into the consideration
>  the null character size.
> 
> o Kexec-tools performs this check deligently hence I ran into the issue
>  while trying to open /proc/kcore in kexec-tools for some info.
> 
> Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>

That is in keeping with my reading of pages 2-4 and 2-5
of version 1.1 of the specification (is there a later version?)

Acked: Simon Horman <horms@verge.net.au>

> ---
> 
> fs/proc/kcore.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff -puN fs/proc/kcore.c~kcore-elf-note-namesz-fix fs/proc/kcore.c
> --- linux-2.6.18-rc3-1M/fs/proc/kcore.c~kcore-elf-note-namesz-fix	2006-08-31 16:10:41.000000000 -0400
> +++ linux-2.6.18-rc3-1M-root/fs/proc/kcore.c	2006-08-31 16:10:41.000000000 -0400
> @@ -100,7 +100,7 @@ static int notesize(struct memelfnote *e
> 	int sz;
> 
> 	sz = sizeof(struct elf_note);
> -	sz += roundup(strlen(en->name), 4);
> +	sz += roundup((strlen(en->name) + 1), 4);
> 	sz += roundup(en->datasz, 4);
> 
> 	return sz;
> @@ -116,7 +116,7 @@ static char *storenote(struct memelfnote
> 
> #define DUMP_WRITE(addr,nr) do { memcpy(bufp,addr,nr); bufp += nr; } while(0)
> 
> -	en.n_namesz = strlen(men->name);
> +	en.n_namesz = strlen(men->name) + 1;
> 	en.n_descsz = men->datasz;
> 	en.n_type = men->type;
> 
> _

