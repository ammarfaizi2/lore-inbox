Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129631AbRAKW2x>; Thu, 11 Jan 2001 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131525AbRAKW2n>; Thu, 11 Jan 2001 17:28:43 -0500
Received: from james.kalifornia.com ([208.179.0.2]:12079 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S129965AbRAKW2e>; Thu, 11 Jan 2001 17:28:34 -0500
Message-ID: <3A5E3389.DAA29EAC@linux.com>
Date: Thu, 11 Jan 2001 14:28:25 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Juchem <juchem@uni-mannheim.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: bugreporting script - second try
In-Reply-To: <Pine.LNX.4.30.0101111300440.21849-100000@gandalf.math.uni-mannheim.de>
Content-Type: multipart/mixed;
 boundary="------------B4392D0615DF488301B50D7C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B4392D0615DF488301B50D7C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Matthias Juchem wrote:

> On Wed, 10 Jan 2001, Richard Torkar wrote:
>
> > I do not have any PPP, and no kdb installed on that machine, neither do I
> > have procinfo. Shouldn't it say N/A or not found instead of the above? The
> > ppp part is not true ;-).
>
> > Other thing I thought about was the Ctrl-D thingy when entering text.
> > What if ppl don't have any text to enter? Shouldn't is say on each line
> > that if you don't have anything to write then just write N/A and press
> > Ctrl-D? Because pressing Ctrl-D directly doesn't do any good.
>
> Could you please check the new version here:
>
>   http://www.brightice.de/src/bugreport.sh

problem: exits top level shell if no filename is specified, annoyance
aesthetics: cat: /proc/scsi/scsi: No such file or directory, simple
aesthetics:  GNU make               3.79.1,
problem:  Linux libc5 C Library  5@..
aesthetics:  Linux libc6 C Library  2.2,
problem:  Linux C++ library      27@..
problem:  Net-tools
problem:  PPP                    file
aesthetics: .config, recommend stripping the ^CONFIG_ and =, combine all 'y'
and 'm'

example fix for C library:
   sed \
     '/C [lL]ibrary /!d; s/[^0-9]*\([0-9.]*\).*/\1/' \
     /lib/libc.so.6

example fix for C++ library:
   basename $(/usr/bin/ls -f /usr/i486-linux-libc5/lib/libg++.so.27 \
     |gawk '{print $NF}')

example fix for GNU make:
   make --version|sed '/version/!d; s/[^0-9]*\([0-9.]*\).*/\1/'

example fix for net-tools:
   1) hostname from sh-utils:
       hostname --version|sed '/GNU sh/!d; s/[^0-9]*\([0-9.]*\).*/\1/'
   2) ifconfig from net-tools:
      ifconfig --version 2>&1|sed '/net\-tools/!d; s/[^0-9]*\([0-9.]*\).*/\1/'

pppd requires a proper /etc/ppp/options file before printing the version, if
you have devfs and a disconnecting modem, i.e. usb modem, it must be
attached for the /dev entry or pppd will refuse to run.

I prefer using e2fsck to report the version:
   e2fsck -V 2>&1 |sed '/e2fsck/!d; s/e2fsck [^0-9]*\([0-9.]*\).*/\1/'


---
-d


--------------B4392D0615DF488301B50D7C
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
url:www.blue-labs.org
adr:;;;;;;
version:2.1
email;internet:david@blue-labs.org
title:Blue Labs Developer
note;quoted-printable:GPG key: http://www.blue-labs.org/david@nifty.key=0D=0A
x-mozilla-cpt:;9952
fn:David Ford
end:vcard

--------------B4392D0615DF488301B50D7C--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
