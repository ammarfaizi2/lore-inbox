Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317485AbSFMHSH>; Thu, 13 Jun 2002 03:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317486AbSFMHSG>; Thu, 13 Jun 2002 03:18:06 -0400
Received: from mail.zmailer.org ([62.240.94.4]:31899 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317485AbSFMHSF>;
	Thu, 13 Jun 2002 03:18:05 -0400
Date: Thu, 13 Jun 2002 10:18:06 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Federico Sevilla III <jijo@free.net.ph>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Very large font size crashing X Font Server and Grounding Server to a Halt (was: remote DoS in Mozilla 1.0)
Message-ID: <20020613101806.F19520@mea-ext.zmailer.org>
In-Reply-To: <20020610102006.A6947@lemuria.org> <Pine.LNX.4.44.0206130908550.985-100000@kalabaw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 09:44:33AM +0800, Federico Sevilla III wrote:
> From:	Federico Sevilla III <jijo@free.net.ph>
> To:	BugTraq Mailing List <bugtraq@securityfocus.com>,
> 	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> 
> (Note: bug originally posted on BugTraq, this response is cross-posted to
> the LKML because of the way the server hosting the X font server ground to
> a halt.)

  It really is nothing new.  (Besides of XFree86's Type1 engine calling 
  abort() when it does not like to do something ..)
...
> Suggestions on how to work around this on multiple levels would definitely
> be appreciated. I'll be starting by removing the X font server from our
> file and authentication server onto some high-powered workstation, but I'm
> sure this won't be enough, and knowing that a user process like xfs-daemon
> can drag the Linux kernel down to knees is not very comforting. :(

  ANY very big program with active working set larger than memory size
  has problems at Linux / Linux has problems handling it.  Indeed the
  problem is _not_ new, nor trivial to solve efficiently.  The ultimate
  situation is called "trashing", where a program to proceed a page of
  code needs to be moved into memory, and to make room for that, some
  other program page must be moved out..  What makes the issue more
  difficult is that the memory is used for lots and lots of different
  kinds of buffers and caches as well, and playing a balancing act on
  them all is quite difficult.

  This is recurring topic at  linux-kernel  list, and has its own
  list called  linux-mm  (not at vger, though.)

  Others may have different views on the issue, but I think that:
     2.0:        fairly tolerable OOM/trashing behaviour
     2.2:        got worse
     2.4.early:  rather terrible
     2.4.late:   improved somewhat, roughly in par with 2.2

>  --> Jijo
> - -- 
> Federico Sevilla III   :  <http://jijo.free.net.ph/>
...
> Please read the FAQ at  http://www.tux.org/lkml/

/Matti Aarnio
