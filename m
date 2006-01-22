Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWAVUpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWAVUpa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 15:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWAVUp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 15:45:29 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:17117 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751347AbWAVUp2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 15:45:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r4jImfpERsksfVK995Rro+AFgeqZMQAqYyd1GLZNML1b7R63Ji7jaW/V0iG0K5zQ9K66sXVeH5Lq1Y8FRqewW5rPqMYJFZ809orBosUDe9u5spiK7mvtth2NIIukCuFpKuORI++L6U5HydaLR6RVfQWIO7C9i09mSCC4/As4QRI=
Message-ID: <9a8748490601221238t318e483g9b0013f5cb7a85ce@mail.gmail.com>
Date: Sun, 22 Jan 2006 21:38:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] disable per cpu intr in /proc/stat
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060122202204.GA26295@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060122202204.GA26295@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Olaf Hering <olh@suse.de> wrote:
> (No bugzilla or benchmark)
>
> From: schwab@suse.de
> Subject: Reading /proc/stat is slooow
>
> Don't compute and display the per-irq sums on ia64 either, too much
> overhead for mostly useless figures.
>
> --- linux-2.6.14/fs/proc/proc_misc.c.~1~        2005-12-06 18:12:28.840059961 +0100
> +++ linux-2.6.14/fs/proc/proc_misc.c    2005-12-06 18:13:51.211896515 +0100
> @@ -498,7 +498,7 @@ static int show_stat(struct seq_file *p,
>         }
>         seq_printf(p, "intr %llu", (unsigned long long)sum);
>
> -#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA)
> +#if !defined(CONFIG_PPC64) && !defined(CONFIG_ALPHA) && !defined(CONFIG_IA64)
>         for (i = 0; i < NR_IRQS; i++)
>                 seq_printf(p, " %u", kstat_irqs(i));
>  #endif

Hmm, this changes userspace visible data... should we be doing that?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
