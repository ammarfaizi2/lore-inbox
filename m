Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSFGWL2>; Fri, 7 Jun 2002 18:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317351AbSFGWL1>; Fri, 7 Jun 2002 18:11:27 -0400
Received: from daimi.au.dk ([130.225.16.1]:55069 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317354AbSFGWLZ>;
	Fri, 7 Jun 2002 18:11:25 -0400
Message-ID: <3D012F89.36DDEA25@daimi.au.dk>
Date: Sat, 08 Jun 2002 00:11:21 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anna Riley <ariley@ignitesports.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel meltdown
In-Reply-To: <D466FBEAA19E7E408BE3FAAC6EEB567601820186@utah.ignitemedia.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anna Riley wrote:
> 
> Hi there,
> I am hoping someone can help me. This morning one of our web servers
> crapped itself and I don't know why. It's running RedHat 7.2 kernel
> version 2.4.9-31smp. I couldn't login from the console so I had to
> reset it. When it came back up it was fine. This is what I am seeing
> in the messages log: 
> 
> Jun 7 02:57:43 web02 kernel: kernel BUG at slab.c:1767!

I looked up that line in the source and found this piece of code:

		full_free = 0;
		p = searchp->slabs_free.next;
		while (p != &searchp->slabs_free) {
			slabp = list_entry(p, slab_t, list);
			if (slabp->inuse)
				BUG();
			full_free++;
			p = p->next;
		}

Could it be a race with this particular slabp being taken in use
by another CPU at this very moment?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
