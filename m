Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129027AbRBGRyQ>; Wed, 7 Feb 2001 12:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbRBGRyG>; Wed, 7 Feb 2001 12:54:06 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:10245 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129027AbRBGRx6>; Wed, 7 Feb 2001 12:53:58 -0500
Message-ID: <3A818B8B.A3AABD9C@baldauf.org>
Date: Wed, 07 Feb 2001 18:53:15 +0100
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: David Rees <dbr@spoke.nols.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
In-Reply-To: <511820000.981567599@tiny>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Mason wrote:

> On Wednesday, February 07, 2001 06:30:01 PM +0100 Xuan Baldauf
> <xuan--reiserfs@baldauf.org> wrote:
> > In my case, it's a SIS5513 board.
> >
> > I have to note that I now have one case which is between offset 9260 and
> > 11016. So probably the tails unpacking theory does not work out.
> >
> > After a more systematical search, I have found following offsets:
> >
> > 9260..11016 = 1756
> > 4204.. 5964 = 1760
> > 2160.. 3243 = 1083
> > 2896.. 3534 =  638
> > 1392.. 3704 = 2312
> >
> > and so on. Maybe I should write a program which automatically detects and
> > reports the zero blocks. I think the theory of tails unpacking does not
> > work out, because there are also areas affected which are not between 2048
> > and 4096. Also the length of the zeroing can be greater than 2048.
> > However, I did not encounter a length of over 4096.
> >
>
> Files up to around 16k in length can have tails, and tails can be larger
> than 2048 bytes.

Oh, I thought that if tails are larger than 2048 bytes, they get converted to
ordinary 4k blocks. The last case (with 2312 zero block size) is the only case
where the first entry after the zero block is the last entry of the file. (This
file is smaller than 4k, all other files should be larger than 4k).

>
>
> Also interesting would be info about when the file closes.  reiserfs only
> creates a tail on file close (file writes always go to full blocks).  If
> you application has the file mmap'd the rules change a little (does it?).

I have to admit that I do not really know: The ad server is a java application,
I do not know wether java on linux does mmap for FileInputStream and
FileOutputStream. "lsof" shows an ordinary file descriptor (such as "13u") at
the FD column for those files, libraries do not have an fd, they have "mem" in
the FD section. So I guess that the files are not memmapped, the implementation
is easier with ordinary read()s and write()s.

It's interesting that the zeroed section never crosses a 4k boundary...

>
>
> -chris

Xuân.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
