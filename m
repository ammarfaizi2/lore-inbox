Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318950AbSHMGwA>; Tue, 13 Aug 2002 02:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318951AbSHMGwA>; Tue, 13 Aug 2002 02:52:00 -0400
Received: from ns.tasking.nl ([195.193.207.2]:7687 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S318950AbSHMGv7>;
	Tue, 13 Aug 2002 02:51:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15704.44325.696035.477628@koli.tasking.nl>
Date: Tue, 13 Aug 2002 08:54:29 +0200
From: Kees Bakker <rnews@altium.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Irwan Hadi <irwanhadi@phxby.engr.usu.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31 hda: lost interrupt
In-Reply-To: <1029167456.16421.174.camel@irongate.swansea.linux.org.uk>
References: <15703.24219.318219.380751@koli.tasking.nl>
	<20020812153125.GA29884@phxby.com>
	<1029167456.16421.174.camel@irongate.swansea.linux.org.uk>
X-Mailer: VM 7.03 under Emacs 20.7.2
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> On Mon, 2002-08-12 at 16:31, Irwan Hadi wrote:
>> Well on my machine, with Maxtor DiamondMax 40 and Asus A7A255 ->
>> AliMagic chipset, and with kernel 2.5.26 I was having the same problem
>> too.
>> It seems the problem might be because I was using ext3fs, which soon I
>> found out corrupt the filesystem because of this lost interrupt thing.
>> Or this problem might occur because my system is an AMD Athlon.

Alan> It happened because you ran 2.5. IDE on 2.5 is not stable (especially on
Alan> 2.5.26)

It happened because of 2.5.26, not just 2.5 in general.

Last night I changed a few things in the 2.5.31 configuration and now it
boots OK.
1) switched over to ACPI (was using APM before)
2) enabled CONFIG_IDEDMA_PCI_AUTO (which I didn't do before because I
   wasn't sure about the "VIA V2" warning in relation to my VIA chipset)
3) removed ATA_F_NOADMA from the chipset flags in ide-pci.c (chip id:
   PCI_DEVICE_ID_VIA_82C586_1)

I get the feeling that it is all DMA related, especially with my VIA
chip. I haven't seen any evidence of corruption, if that's what you mean by
'not stable'.

>> My solution was to move back to ext2fs and kernel 2.4.18, although for
>> this I needed to fsck the hard drive a couple times because of the
>> occured corruption to the filesystem.

Alan> ext3 is stable on 2.4 systems.

And on 2.5 systems, right?
-- 
