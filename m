Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUK2FCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUK2FCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 00:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbUK2FCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 00:02:21 -0500
Received: from web13527.mail.yahoo.com ([216.136.173.208]:57772 "HELO
	web13527.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261631AbUK2FCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 00:02:16 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lrnHNZEwoarRENcdbYgLGWorFV/DkW/OIP7N/da+s3o1awycdi4Fl3L0dGKxgPCTq1eq2+2jHXtroebifIhv3nEA1FjEGW2Ll59ZwJkadDG6byxyOITjsG4+5hKGKXNceGeQLORlNjZu0VWvAR0Y/wKvqQH7R5NSz+ZOroWxRZI=  ;
Message-ID: <20041129050215.7465.qmail@web13527.mail.yahoo.com>
Date: Sun, 28 Nov 2004 21:02:15 -0800 (PST)
From: Richard Patterson <vectro@yahoo.com>
Subject: Re: Seekable pipes
To: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org
In-Reply-To: <20041128120006.312.69326.Mailman@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan,

> > I want to implement an interface for seekable
pipes
> > (and FIFOs) in the Linux kernel.

> Why not simply create two pipes, and use one for the
> data (from writer to reader) and the other for 
> control (r->w)? Then you would  not need to poke
> with the kernel after all.

The idea is that the reading side dosen't know it's a
pipe -- thus this interface can be used to provide
file-like access to non-filesystem objects like HTTP
files or Postgres large objects. With kernel support,
the reading side can be unaware that it is reading
from a pipe -- it just seeks. So you can do wierd
things like wget http://stuff/stuff.pdf | xpdf
/dev/stdin -- even though xpdf doesn't support piped
input.

However, Chris Siebenmann pointed out that a file
descriptor can be passed to other processes with
fork() or domain sockets -- thus the writer side of
the pipe would have to support multiple readers with
distinct positions. Which is a lot hairer than the
interface I outlined earlier.

Cheers,

--Ian Turner


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
