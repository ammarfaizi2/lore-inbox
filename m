Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135174AbRDLUTe>; Thu, 12 Apr 2001 16:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135195AbRDLUTY>; Thu, 12 Apr 2001 16:19:24 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56335 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S135174AbRDLUTO>;
	Thu, 12 Apr 2001 16:19:14 -0400
Date: Thu, 12 Apr 2001 17:18:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Szabolcs Szakacsits <szaka@f-secure.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: scheduler went mad?
In-Reply-To: <Pine.LNX.4.30.0104122145520.19377-100000@fs131-224.f-secure.com>
Message-ID: <Pine.LNX.4.21.0104121632330.18260-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Apr 2001, Szabolcs Szakacsits wrote:

> You mean without dropping out_of_memory() test in kswapd and calling
> oom_kill() in page fault [i.e. without additional patch]?

No.  I think it's ok for __alloc_pages() to call oom_kill()
IF we turn out to be out of memory, but that should not even
be needed.

Also, when a task in __alloc_pages() is OOM-killed, it will
have PF_MEMALLOC set and will immediately break out of the
loop. The rest of the system will spin around in the loop
until the victim has exited and then their allocations will
succeed.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

