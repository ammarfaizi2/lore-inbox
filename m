Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289360AbSA1UIZ>; Mon, 28 Jan 2002 15:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289364AbSA1UIP>; Mon, 28 Jan 2002 15:08:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32263 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289360AbSA1UIE>;
	Mon, 28 Jan 2002 15:08:04 -0500
Message-ID: <3C55AE06.9C9AB33F@zip.com.au>
Date: Mon, 28 Jan 2002 12:01:10 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kevin Breit <mrproper@ximian.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet data corruption?
In-Reply-To: <1012250404.5401.6.camel@kbreit.lan>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin Breit wrote:
> 
> Hi,
>         The other night, my friend was sending me a video over the internet.
> We tried http, ftp, and other protocols, using different download
> applications.  It seemed to be corrupt, the same way, everytime.  It
> wouldn't work, and had a different md5sum than the "good" version on my
> friend's computer.  Eventually we got it working.
>         The same issue came up again today.  I uploaded my Java project on my
> professor's server and it gives me an error.  However, if I load the
> html file with the Java applet in my web browser from this hard disk
> (instead of from the prof's), it works.
>         I am wondering if there is some sort of corruption going on here.  I am
> using Red Hat's 2.4.9-21 kernel.
> 

Generally, IP checksumming should catch this.

However, a number of ethernet cards do IP checksumming in
hardware, so the kernel doesn't bother doing the checksum
in software.

So if you are experiencing data corruption on the path
between the NIC's FIFO memory, the PCI bus and main memory,
it will not be detected.  This is somewhat of a flaw in the
whole idea of checksum offload, IMO...

What ethernet card are you using?

-
