Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131257AbRADJpp>; Thu, 4 Jan 2001 04:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131550AbRADJpg>; Thu, 4 Jan 2001 04:45:36 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:61352 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S131257AbRADJp1>; Thu, 4 Jan 2001 04:45:27 -0500
To: Chris Mason <mason@suse.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] filemap_fdatasync & related changes
In-Reply-To: <428710000.978539866@tiny>
From: Christoph Rohland <cr@sap.com>
In-Reply-To: <428710000.978539866@tiny>
Message-ID: <m3ae982yq5.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 04 Jan 2001 10:48:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> writes:
> Just noticed the filemap_fdatasync code doesn't check the return value from
> writepage.  Linus, would you take a patch that redirtied the page, puts it
> back onto the dirty list (at the tail), and unlocks the page when writepage
> returns 1?
> 
> That would loop forever if the writepage func kept returning 1 though...I
> think that's what we want, unless someone like ramfs made a writepage func
> that always returned 1.

shmem has such a writepage for locked shm segments. It also always
return 1 if the swap space is exhausted. So everybody using shared
anonymous, SYSV shared or POSIX shared memory can hit this.

I invented the return code 1 exactly to be able to handle this.

Greetings
                Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
