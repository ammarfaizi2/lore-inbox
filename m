Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWFGBWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWFGBWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 21:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWFGBWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 21:22:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:46105 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750756AbWFGBWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 21:22:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lHaiqJa3IpbwC7as5Lk/y6bF4GB+OUGuxgO3E4+ZzMWBt/iKEpm7xwTxma2rFRwtFyHR+lOAfrnFlxJh6O8O1dt/L/2iZCJsDXyJBsZ4W0y+WsimKgm/6odZAEYAflgWMZuSJfJBmXrZiflientxUJso7u+26cKYHKLL1oDLu5U=
Message-ID: <3faf05680606061822g25c242ddq58efdb762ca33252@mail.gmail.com>
Date: Wed, 7 Jun 2006 06:52:19 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Quick close of all the open files.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200606070033.k570X6Bu007481@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3faf05680606061445r7da489d9tc265018bc7960779@mail.gmail.com>
	 <200606062156.k56LuWFD001871@turing-police.cc.vt.edu>
	 <3faf05680606061502q28501343yb3a91dbda3c423b6@mail.gmail.com>
	 <200606070033.k570X6Bu007481@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > I checked as follows I did printf("lowest fd = %d",fileno(tmpfile()));
> > it prints 3
>
> Which proves that file descriptor 3 was closed, so tmpfile() was able to
> open it.  This certainly implies that fd 0, 1, 2 (connected to stdin,
> stdout, and stderr streams of stdio) are still open, contrary to your
> statement that *all* of them are closed.

I know 0,1,2 are open (I opened it) no need to tell it specifically,
HOW DO YOU THINK I CAN PRINT SOME THING WITHOUT OPENING THIS
FILES(stdout,stderr)?


>
> If file descriptor 3 is closed, but 4 is open, what does tmpfile()
> do? Hint - tmpfile() ends up invoking open(), and the manpage for that says:
>
>        Given a pathname for a file, open() returns a file descriptor, a small,
>        non-negative integer for  use  in  subsequent  system  calls  (read(2),
>        write(2), lseek(2), fcntl(2), etc.).  The file descriptor returned by a
>        successful call will be the lowest-numbered file  descriptor  not  cur-
>        rently open for the process.
>
> So.. explain why you think that "all files were closed"?  We know that 0..2
> were open, and we know nothing about 4..1023.
>
> This doesn't look like a kernel bug, you may want to continue the discussion
> on one of the various "beginning Linux C programming" lists.
>
> On Tue, 06 Jun 2006 23:03:38 BST, =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= said:
> > > (Hint - what does that fp->_chain = stderr *really* do? ;)
> >
> > As it touches the innards of the FILE type, it invokes undefined
> > behavior.  Nothing that follows can be considered a bug.
>
> Invoking undefined behavior is often considered a bug itself.  And it's
> certainly happening in userspace.. so there's a userspace bug. ;)
>
>
>
