Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262350AbREUCoO>; Sun, 20 May 2001 22:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262352AbREUCoE>; Sun, 20 May 2001 22:44:04 -0400
Received: from are.twiddle.net ([64.81.246.98]:16646 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S262350AbREUCnr>;
	Sun, 20 May 2001 22:43:47 -0400
Date: Sun, 20 May 2001 19:43:40 -0700
From: Richard Henderson <rth@twiddle.net>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
Message-ID: <20010520194340.C19096@twiddle.net>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10105202210370.1667-100000@callisto.of.borg> <3B083878.1785C27D@mandrakesoft.com> <20010521001949.R754@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521001949.R754@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Mon, May 21, 2001 at 12:19:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 12:19:49AM +0200, Ingo Oeser wrote:
> AFAIK "const" is only a promise to the compiler, that we write
> this data ONCE and read only after this initial write. So the
> decision on the section is implementation defined.

No, the problem is not with which section, but what flags that
section should have.  If you put only "const" data in a section,
then the section should have SHF_WRITE clear.  Conversely, if
you put writable data in a section then SHF_WRITE should be set.

Now, one could argue that gcc should scan the entire file to
see if there are any non-constant data members added to a 
particular section, and set SHF_WRITE if any such exist.

My answer is: you would not like gcc's memory usage under these
conditions.


r~
