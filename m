Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316339AbSIDXdM>; Wed, 4 Sep 2002 19:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316342AbSIDXdM>; Wed, 4 Sep 2002 19:33:12 -0400
Received: from dp.samba.org ([66.70.73.150]:38874 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S316339AbSIDXdK>;
	Wed, 4 Sep 2002 19:33:10 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15734.39068.766611.169333@argo.ozlabs.ibm.com>
Date: Thu, 5 Sep 2002 09:34:52 +1000 (EST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "J.A. Magallon" <jamagallon@able.es>, Remco Post <r.post@sara.nl>,
       morten.helgesen@nextframe.net, linux-kernel@vger.kernel.org
Subject: Re: writing OOPS/panic info to nvram?
In-Reply-To: <1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
References: <E471FA7E-C00E-11D6-A20D-000393911DE2@sara.nl>
	<20020904140856.GA1949@werewolf.able.es>
	<1031149539.2788.120.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:

> With what will you write it - not the linux block layer thats for sure.
> Ingo has patches for doing network dumps which are kind of neat

Rusty has written a very basic polled-mode IDE driver for precisely
this situation.  He even tested it on x86 and powermac. :)  He has a
little user-space program that allocates a file and uses FIOBMAP to
work out which disk blocks it is using.  The program writes a
signature to the blocks and then tells the kernel crashdump module the
block numbers.  When the kernel panics, it calls the crashdump module
which first reads the blocks it was told and makes sure they have the
right signature, then writes the oops information to those blocks and
then reboots.

IDE was relatively straightforward since you can do basic block I/O
with just the ATA-1 or ATA-2 registers and command set and PIO.  In
contrast, I believe SCSI defeated him. :)

Paul.
