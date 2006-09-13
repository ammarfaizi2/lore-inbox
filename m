Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWIMHox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWIMHox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 03:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbWIMHox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 03:44:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:62748 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751670AbWIMHow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 03:44:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=upT97TMb9+5Cbua1zgOy5gxLNka/pC8lwtgckURnPY1ILCnlO2aeugt8xu1JYCSy7iVMzLjmpl6vcCcmvRrFRg2U1IUwsi1CPbbnlnQuRgQ45VHayYIr0XuDnrb/dRBK3vtH9WjvMX3Uvne1HVGNJH885KcJeo6ee0Cc8A501b8=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: MSI K9N Neo: corruption on streaming PATA/SATA i/o - testers needed
Date: Wed, 13 Sep 2006 09:41:48 +0200
User-Agent: KMail/1.8.2
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
References: <200609121046.24610.vda.linux@googlemail.com> <200609121818.44766.vda.linux@googlemail.com>
In-Reply-To: <200609121818.44766.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609130941.48695.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml'ers

If you happen to have the same mobo, MSI AM2 K9N NEO-F

http://www.msi.com.tw/program/products/mainboard/mbd/pro_mbd_detail.php?UID=733

and streaming disk i/o works for you, plase send me:
* kernel version and .config
* hdparm -i output
* lspci -vvvxxx output

Thanks... now with gory details.

On Tuesday 12 September 2006 18:18, Denis Vlasenko wrote:
> > I bought new Athlon46 mobo with AM2 socket and recently
> > I noticed that copying large amounts of data reliably
> > crashes 2.6.17.11 64-bit on it.
> > 
> > memtest runs ok on this machine overnight.
> > Machine is not overclocked.
> > 
> > Copying movies from SATA drive to PATA drive oopses
> > after few gigabytes transferred. Creating iso image
> > with mkisofs (done entirely on PATA drive, no SATA attached)
> > does the same.
> > 
> > After some testing I found ou that rw load crashes
> > machine rather fast, while read load usually runs for several
> > minutes before crash. Setting udma4 or udma3 instead of udma5
> > doesn't help. Pity I don't have my own SATA drive to run tests
> > with it, ran most of the tests on PATA drive.
> 
> I obtained PCI config space dumps under Windows XP on this machine
> and compared them to Linux settings. Integrated PATA IDE controller
> has some differences in rows 5x and 8x.

As Alan pointed out, there aren't any obvious differences which
may affect IDE. They are mostly in AMD CPU Northbridge...

I bought SATA II Samsung drive yesterday. Created 32gb file on it.
Windows XP can do "copy 32g nul" - no problems.
The very same thing on Linux randomly crashes in a few minutes.

Please note that I was using Linux on this machine for a bit more than
a month and I had just one unexplained (at that time) crash.
I compiled stuff on it and copied a lot of files (kernel trees, for one),
without crashes. It was feeling like everything was working okay.

So it seems likely that memory corruption and resulting crashes
occur only when there are large amounts of streaming I/O, "short"
reads/writes (less than ten megabytes at once) are affected much less
or not affected at all.

BTW, I tried running with mem=500 and tried 32-bit kernels,
still crashes.

I also did a direct device-to-device copy using dd
(translation: no filesystem code involved) and it crashed too.

And to repeat: it happens both on PATA IDE Western Digital drive
(WDC WD2500JB-55GVC0, FwRev=08.02D08, SerialNo=WD-WCAL78337950)
and this new Samsung SATA drive...

Does this rings any bells? What is different when I do streaming i/o?
IOW: where should I start poking in the driver? Because Windows
somehow works, dammit... it must be possible to make it work...

I do not have another mobo for testing.
--
vda
