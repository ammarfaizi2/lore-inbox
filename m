Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315358AbSEQMZa>; Fri, 17 May 2002 08:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEQMZa>; Fri, 17 May 2002 08:25:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39690 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315358AbSEQMYg>; Fri, 17 May 2002 08:24:36 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: rusty@rustcorp.com.au (Rusty Russell)
Date: Fri, 17 May 2002 13:17:25 +0100 (BST)
Cc: davem@redhat.com (David S. Miller), torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E178eMm-0000NO-00@wagner.rustcorp.com.au> from "Rusty Russell" at May 17, 2002 07:49:40 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178gfl-0006Ip-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I would much rather fix these instances than add yet another
> > interface.
> 
> I'll accept that if someone's volunteering to audit the kernel for
> them every six months.
> 
> Sorry I wasn't clear: I'm saying *replace*, not add,

Replace requires you audit every single use, and then work out how to
handle those that do care about the length and the point it faulted. From
what I've seen of the stuff that has been fixed we have a mix of the
following

1.	Misports of ancient verify_* code - eg the serial ones
2.	Not checking the return code - 100% legal and standards compliant

I've seen very few that have other screwups. In fact I've seen far more
incorrect uses of kmalloc with a user passed input field, kmalloc with
maths overflows, copy*user with maths overflows and the like

Alan
