Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291931AbSBNVnG>; Thu, 14 Feb 2002 16:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291930AbSBNVmq>; Thu, 14 Feb 2002 16:42:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11537 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291929AbSBNVmf>;
	Thu, 14 Feb 2002 16:42:35 -0500
Message-ID: <3C6C2F13.B8A30DB@zip.com.au>
Date: Thu, 14 Feb 2002 13:41:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Moibenko <moibenko@fnal.gov>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: fsync delays for a long time.
In-Reply-To: <E16bTZO-0001DH-00@the-village.bc.nu> <Pine.SGI.4.31.0202141526080.3270649-100000@fsgi03.fnal.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Moibenko wrote:
> 
> On Thu, 14 Feb 2002, Alan Cox wrote:
> 
> > > > > This could very well be due to request allocation starvation.
> > > > > fsync is sleeping in __get_request_wait() while bonnie keeps
> > > > > on stealing all the requests.
> > > >
> > > > That may amplify it but in the 2.2 case fsync on any sensible sized file
> > > > is already horribly performing. It hits databases like solid quite badly
> > > >
> > > please elaborate on "sensible sized". In my case it is less then 20MB.
> >
> > That ought to be ok. Andrew may well be right in that case.
> >
> Then what is your advise. Switch to 2.4.x?

I would recommend that, yes.  One consideration: if the problem
is still appearing in 2.4 then it is about 1000 times more
likely to get fixed.

What filesystem were you using, BTW?  ext2?

If you do test on 2.4, and the problem still appears, please try

wget http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/make_request.patch
patch -p1 < make_request.patch
