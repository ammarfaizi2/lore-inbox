Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268000AbRG0Olh>; Fri, 27 Jul 2001 10:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268735AbRG0Ol2>; Fri, 27 Jul 2001 10:41:28 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.0.107.130]:41095 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S268000AbRG0OlR>; Fri, 27 Jul 2001 10:41:17 -0400
Message-ID: <3B617CED.58F4DC06@home.com>
Date: Fri, 27 Jul 2001 09:38:37 -0500
From: Jordan <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Philip R. Auld" <pauld@egenera.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <E15Q7eW-0005cP-00@the-village.bc.nu> <3B6177DB.26C6D378@egenera.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Philip R. Auld" wrote:
> 
> Alan Cox wrote:
> >
> > Its certainly a good idea. But it sounds to me like he is describing the
> > normal effect of metadata only logging.
> >
> 
> Which brings up something I have been struggling with lately:
> 
> Linux (using both ext2 and reiserfs) can show garbage data blocks at the end of
> files after a crash. With reiserfs this is clearly due to metadata only logging
> and happens say 3 out of 5 times. With ext2 the frequency is about 1 in 5 times,
> and more often that not it is simply zeroed data. Sometimes it is old data
> though.
> 
> This is something that is not present in other unix filesystems as far as I can
> tell. If linux wants to be used in enterprise sites we can't allow
> old data blocks to be read. And ideally shouldn't allow zero blocks to be seen
> either, but this is somewhat less serious.
> 
> I cannot reproduce this in ufs on either freebsd or solaris8.
> 
> I have not tested it with xfs and jfs for linux yet (and don't have any native
> systems at hand.)
> 
> I believe vxfs to have a mechanism to prevent this despite metadata only
> logging.
> 
> reiserfs with full data logging enabled of course does not show this behavior
> (and works really well if you are willing to take the performance hit).
> 
> The basic test I use is to run this perl script for a while (to make sure at
> least somehting has had a chance to get written out) and then power-cycle the
> machine. When it comes back a simple tail logfile will show the problem. I also
> run bonnie before hand to fill the disk with a known pattern so its easier to
> spot.
> 
> linux is 2.2.16 and 2.4.2 from redhat 7.1. reiserfs is 3.5.33 and was tested
> only on 2.2.16.
> 
> #!/usr/bin/perl
> use Fcntl;
> $count = 0;
> while (1) {
> #sysopen(FH, "/scratch/logfile", O_RDWR|O_APPEND|O_CREAT|O_SYNC)
> sysopen(FH, "/scratch/logfile", O_RDWR|O_APPEND|O_CREAT)
>         or die "Couldn't open file $path : $!\n";
> print FH "Log file line ", $count , " yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda
> yadda  yadda  yadda  yadda  yadda  yadda  yadda  yadda \n" ;
> close (FH);
> #print $count , "\n";
> $count++;
> }
> 
> ------------------------------------------------------
> Philip R. Auld, Ph.D.                  Technical Staff
> Egenera Corp.                        pauld@egenera.com
> 165 Forest St, Marlboro, MA 01752        (508)786-9444
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I didn't know that there was a way to enable full data journaling using
reiserfs.  I was under the impression that with the latest round of the
unlink patch to go with 2.4.7 that reiserfs was basically in ordered
journaling mode instead of writeback (I believe that is the name), if I
am wrong or if there really is a way to enable full data journaling
please let me know.  Thanks.

Jordan
