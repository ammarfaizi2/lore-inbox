Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292996AbSCEMcb>; Tue, 5 Mar 2002 07:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293042AbSCEMcW>; Tue, 5 Mar 2002 07:32:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:4101 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292996AbSCEMcH>; Tue, 5 Mar 2002 07:32:07 -0500
Date: Tue, 5 Mar 2002 09:31:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH] breaking up the pagemap_lru_lock in rmap
In-Reply-To: <793424263.1015276658@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44L.0203050930070.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Martin J. Bligh wrote:

> > Maybe that's more a sympthom that the rmap is doing
> > something silly with the lock acquired,
>
> It seems that we're reusing the pagemap_lru_lock for both the lru chain
> and the pte chain locking, which is hurting somewhat. Maybe a per-zone
> lock is enough to break this up (would also dispose of cross-node lock
> cacheline bouncing) ... I still think the two chains need to be seperated
> from each other though.

Absolutely agreed.  I'll happily accept patches for this,
but unfortunately don't have the time to implement this
myself right now.

The reason the pagemap_lru_lock protects both the lru
lists and the pte_chain lists is that it was the easiest
way to get -rmap running on SMP and I had (and still have)
a pretty large TODO list of -rmap and unrelated things...

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

