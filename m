Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273522AbRIWN2D>; Sun, 23 Sep 2001 09:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273567AbRIWN1x>; Sun, 23 Sep 2001 09:27:53 -0400
Received: from [200.203.199.88] ([200.203.199.88]:28947 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S273522AbRIWN1m>;
	Sun, 23 Sep 2001 09:27:42 -0400
Date: Sun, 23 Sep 2001 10:27:16 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <m166aa82zg.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0109231026060.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Sep 2001, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:

> > > I would also like to have time to investigate what happens if the pages
> > > associated with a program load are handled in larger blocks, meta-pages
> > > perhaps, which would at least cause many to be loaded at once on a page
> > > fault, rather than faulting them in one at a time.
> >
> > This is an interesting thing, too. Something to look into for
> > 2.5 and if it turns out simple enough we may even want to
> > backport it to 2.4.
>
> filemap_nopage already does all of this except put the page in the
> page table.

Exactly, there are two things we need to fix:

1) set up the page tables in a clustered way
2) make filemap_nopage() aware of sequential IO and
   teach it to do asynchronous readahead .. maybe even
   with drop-behind on the VMA level ?

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

