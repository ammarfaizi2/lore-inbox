Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbRAIWpo>; Tue, 9 Jan 2001 17:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAIWpg>; Tue, 9 Jan 2001 17:45:36 -0500
Received: from esteel10.client.dti.net ([209.73.14.10]:60489 "EHLO
	nynews01.e-steel.com") by vger.kernel.org with ESMTP
	id <S129835AbRAIWpI>; Tue, 9 Jan 2001 17:45:08 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: Floppy disk strange behavior
Date: 09 Jan 2001 17:44:58 -0500
Organization: e-STEEL Netops news server
Message-ID: <m3puhwtket.fsf@shookay.e-steel.com>
In-Reply-To: <E14G6S5-0007UK-00@the-village.bc.nu> <Pine.GSO.4.21.0101091642260.9953-100000@weyl.math.psu.edu>
NNTP-Posting-Host: shookay.e-steel
X-Trace: nynews01.e-steel.com 979080232 27336 192.168.3.43 (9 Jan 2001 22:43:52 GMT)
X-Complaints-To: news@nynews01.e-steel.com
NNTP-Posting-Date: 9 Jan 2001 22:43:52 GMT
X-Newsreader: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, I emailed bug-fileutils@gnu.org and got this response from Jim Meyering
<jim@meyering.net>:

Thanks for the report.
That's fixed in the latest test release.
  ftp://alpha.gnu.org/gnu/fetish/fileutils-4.0.35.tar.gz

It's fixed in 4.0.33, too.

viro@math.psu.edu (Alexander Viro) writes:
> On Tue, 9 Jan 2001, Alan Cox wrote:
> 
> > > dd bug. It tries to ftruncate() the output file and gets all upset when
> > > kernel refuses to truncate a block device (surprise, surprise).
> > 
> > Standards compliant but unexpected. 
> 
> dd is supposed to be portable. On Solaris:
> % man ftruncate
> [snip]
>       EINVAL    The fildes argument  does  not  correspond  to  an
>                ordinary file.
>  
> > Actually its explicitly mentioned by the spec that truncate _may_ extend
> > a file but need not do so. 
> 
> However, it also explicitly mentions that truncate can fail for non-regular
> file.
> 
> > > Try to build GNU dd on other Unices and you will be able to trigger that
> > > bug on quite a few of them.
> > 
> > I think not
> 
> Solaris, for one thing. OK, let's ask folks to test it on different systems
> and see what it gives.
> 
> > > ftruncate(2) is _not_ supposed to succeed on anything other than regular
> > > files. I.e. dd(1) should not call it and expect success if file is not
> > > regular. Plain and simple...
> > 
> > 2.2 is least suprise 2.4 is most information, but misleading errno IMHO
> 
> Agreed. It should be -EINVAL, not -EPERM.
> 
> IMO there are two issues:
> 	* dd(1) portability bug. Obviously there - ftruncate(2) is allowed
> to fail on non-regular ones. Fix is trivial and it (or something equivalent)
> should go into the fileutils.
> 	* What should 2.4 do here? I would prefer -EINVAL - it is true
> (requested action is invalid for the arguments we got), it is consistent
> with other systems and it doesn't hide the failure. Data that used to
> be in the file we were trying to truncate is still there. -EPERM is
> arguably wrong here - it's not like the problem was in the lack of
> permissions.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
