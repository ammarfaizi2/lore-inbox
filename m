Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135241AbRDLR77>; Thu, 12 Apr 2001 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135243AbRDLR7t>; Thu, 12 Apr 2001 13:59:49 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64263 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135241AbRDLR7i>;
	Thu, 12 Apr 2001 13:59:38 -0400
Date: Thu, 12 Apr 2001 14:56:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.30.0104122008590.19377-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.21.0104121456020.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Szabolcs Szakacsits wrote:
> On Thu, 12 Apr 2001, Marcelo Tosatti wrote:
> 
> > This patch is broken, ignore it.
> > Just removing wakeup_bdflush() is indeed correct.
> > We already wakeup bdflush at try_to_free_buffers() anyway.
> 
> I still feel a bit unconfortable about processes looping forever in
> __alloc_pages and because of this oom_killer also can't be moved to
> page fault handler where I think its place should be. I'm using the
> patch below.

It's BROKEN.  This means that if you have one task using up
all memory and you're waiting for the OOM kill of that task
to have effect, your syslogd, etc... will have their allocations
fail and will die.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

