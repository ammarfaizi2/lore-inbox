Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269133AbRGaA5O>; Mon, 30 Jul 2001 20:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269134AbRGaA5D>; Mon, 30 Jul 2001 20:57:03 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:46341 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S269133AbRGaA4x>; Mon, 30 Jul 2001 20:56:53 -0400
Date: Tue, 31 Jul 2001 02:57:00 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010731025700.G28253@emma1.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B5FC7FB.D5AF0932@zip.com.au> <20010726130809.D17244@emma1.emma.line.org> <3B60022D.C397D80E@zip.com.au> <20010726143002.E17244@emma1.emma.line.org> <9jpea7$s25$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9jpea7$s25$1@penguin.transmeta.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Linus Torvalds wrote:

> In article <20010726143002.E17244@emma1.emma.line.org>,
> Matthias Andree  <matthias.andree@stud.uni-dortmund.de> wrote:
> >
> >However, the remaining problem is being synchronous with respect to open
> >(fixed for ext3 with your fsync() as I understand it), rename, link and
> >unlink. With ext2, and as you write it, with ext3 as well, there is
> >currently no way to tell when the link/rename has been committed to
> >disk, unless you set mount -o sync or chattr +S or call sync() (the
> >former is not an option because it's far too expensive).
> 
> Congratulations. You have been brainwashed by Dan Bernstein.

No, I asked Wietse Venema what assumptions Postfix makes. Since he
refuses to fsync() directories, he has Postfix set chattr +S to enforce
the semantics he expects. No problem here.

> Use fsync() on the directory. 
> 
> Logical, isn't it?

Why go all the lengths to look up each single directory path component
again just to fsync() stuff that doesn't belong to you and that you
don't want synched, possibly the entire device?

Chase up to the root manually, because Linux' ext2 violates SUS v2
fsync() (which requires meta data synched BTW), as has been pointed out
(and fixed in ReiserFS and ext3)?

Admittedly, MTAs are (supposed to be) (per command of RFC-1123) more
paranoid than the average application - and per lack of standard whether
rename/link & Co. need to be synchronous or asynchronous, this is a
problem for the MTA.

So, please tell my why Single Unix Specification v2 specifies EIO for
rename. Asynchronous I/O cannot possibly trigger immediate EIO.

-- 
Matthias Andree
