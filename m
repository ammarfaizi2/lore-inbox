Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbTKJNAZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263392AbTKJNAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:00:25 -0500
Received: from web20604.mail.yahoo.com ([216.136.226.162]:17945 "HELO
	web20604.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262855AbTKJNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:00:22 -0500
Message-ID: <20031110130021.35782.qmail@web20604.mail.yahoo.com>
Date: Mon, 10 Nov 2003 05:00:21 -0800 (PST)
From: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: PATCH: CMD640 IDE chipset
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200310292036.56309.bzolnier@elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Hi Bartolomiej!
> Hi,
> > --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
wrote:
> > > Hi,
> > >
> > > Can you please drop all code-style changes (such as foo() -> foo
())
> >
> >  sorry about that, I ran Lindent on it...
> Please read Documentation/CodingStyle instead ;-).

  I've read it and I got the impression that a code cleanup is in order
  but nevermind, I left it as wrongly indented as it was.

> >    Please excuse me for sending this patch as an attachment,
> > but as my mail account is Yahoo! and I'm too lazy to find a better
> > sollution, I cannot get the patch through the web interface without
> > breaking the lines.
> Okay.
> >   This patch integrates the CMD640 chipset support in the 2.4.22
> > kernel. I was using it succesfully in the 2.2.x kernel series, but
> > got no result in the 2.4.x kernels. After comparing the 2 versions,
> > I noticed errors in the new version (outb_p() instead of outl_p())
> > and also some useless code (the wrapers: __put_cmd640_reg() and 
> > __get_cmd640_reg() - which I removed and placed the locks where
needed;
> It seems Alexander already covered removal of wrappers...
> > the pci_conf1() and pci_conf2() functions).
> You can't remove them.
> /* Find out what kind of PCI probing is supported otherwise
>    we break some Adaptec cards...  */

  OK, you are right, i am wrong. This functions are back.

> >   I also removed the CONFIG_BLK_DEV_CMD640_ENHANCED config option,
as
> > it
> > makes little difference for the kernel size.
> >   The init_hwif_cmd640() function had to be rewritten because it is
> > called once for each ide interface found, so the old way of
addressing
> > all the drives in one run was no longer working. Therefore, to not
> > break all the code, came the need for a function that computes the
> > index from the ide_drive_t* : calculate_index().
> ide_probe_for_cmd640x() should be still be used instead.

  I disagree.

> By removing setup_device_ptrs() and moving this driver to generic PCI
layer,
> you broke support for VLB version of CMD640.

  I don't have a VLB version to test it on, but by reading the code I
think
  that it will work just fine.
  Anyway, if I'm wrong I should get a prize for breaking something that
was
  allready broken :-)))) .

> Also there is a comment in a cmd640.c:
> /*
>  * The CMD640x chip does not support DWORD config write cycles, but
some
>  * of the BIOSes use them to implement the config services.
>  */
> which worries me that it might be not safe to move this driver to
generic
> IDE PCI layer (at least for now).

  Don't worry man, just read the code and you shall find peace of
mind....

> >   The code that handles PIO settings was rearanged in a new
function:
> > cmd640_tuneproc().
> Is this really necessary, it is even harder to read it now...

  It is necessary, unless the purpose of this piece of code is
readability.

> Stefan, please rework your patch.  Thanks.

  If you say that the only way I will get this driver fixed is to keep
it
  ugly then I will send you a lame patch that does just that.

> cheers,
> --bartlomiej

later,



=====
Stefan Talpalaru

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
