Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132254AbRCVXoD>; Thu, 22 Mar 2001 18:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132262AbRCVXjd>; Thu, 22 Mar 2001 18:39:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:20487 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S132260AbRCVXh7>; Thu, 22 Mar 2001 18:37:59 -0500
Date: Thu, 22 Mar 2001 20:37:11 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Stephen Clouse <stephenc@theiqgroup.com>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <20010323002752.A5650@win.tue.nl>
Message-ID: <Pine.LNX.4.33.0103222033220.24040-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Mar 2001, Guest section DW wrote:
> On Thu, Mar 22, 2001 at 10:52:09PM +0000, Alan Cox wrote:
>
> > You can do overcommit avoidance in Linux if you are bored enough to try it.
>
> Would you accept it as the default? Would Linus?

It wouldn't help.  Suppose you run without overcommit and you
fill up RAM and swap to the last page.

Then you change the size of one of the windows on your desktop
and a program gets sent -SIGWINCH. In order to process this
signal, the program needs to allocate some variables on its
stack, possibly needing a new page to be allocated for its
stack ...

... and since this is something which could happen to any program
on the system, the result of non-overcommit would be getting a
random process killed (though not completely random, syslogd and
klogd would get killed more often than the others).

The only solution to not getting processes killed is to run with
enough memory and swap space, having an OOM killer which takes care
to *NOT* let any random innocent process gets killed is nothing but
a bonus, IMHO.

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

