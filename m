Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313882AbSEEXtd>; Sun, 5 May 2002 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSEEXtc>; Sun, 5 May 2002 19:49:32 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:18950 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S313882AbSEEXtc>;
	Sun, 5 May 2002 19:49:32 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: make mrproper depends on .hdepend? 
In-Reply-To: Your message of "Sun, 05 May 2002 12:16:03 CST."
             <Pine.LNX.4.44.0205051206340.23089-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 May 2002 09:49:22 +1000
Message-ID: <8509.1020642562@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 May 2002 12:16:03 -0600 (MDT), 
Thunder from the hill <thunder@ngforever.de> wrote:
>Something weird just broke my build of .hdepend. I tried to make clean 
>afterwards, and make clean aborted due to an aborted .hdepend. I tried to 
>make mrproper, but the problem reoccurred.
>
>I rm'd the .hdepend, then I could make clean and mrproper. However, IMO 
>make clean and make mrproper shouldn't depend on .hdepend to be complete. 
>Or is there any sane reason not to parse .hdepend for make mrproper & co.?

Just another kbuild 2.4 bug.  During make clean/mrproper directory
traversal Rules.make is included.  Rules.make unconditionally includes
.depend from this directory and the global .hdepend, no matter what the
target is.

It can be fixed but there are more important problems and nobody has
got round to it.  rm the broken .[h]depend file gets around the bug.

