Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278465AbRJZN0I>; Fri, 26 Oct 2001 09:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278468AbRJZNZ6>; Fri, 26 Oct 2001 09:25:58 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:11529 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S278465AbRJZNZq>; Fri, 26 Oct 2001 09:25:46 -0400
Message-ID: <3BD9647A.B6244D05@firsdown.demon.co.uk>
Date: Fri, 26 Oct 2001 14:26:18 +0100
From: Dave Garry <daveg@firsdown.demon.co.uk>
Organization: Daemon Solutions Ltd
X-Mailer: Mozilla 4.51C-Caldera [en] (X11; I; Linux 2.2.5 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Waugh <twaugh@redhat.com>
CC: junio@siamese.dhis.twinsun.com, bill davidsen <davidsen@tmr.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: linux-2.4.12 / linux-2.4.13 parallel port problem
In-Reply-To: <20011024230917.H7544@redhat.com> <ioWB7.5038$rR5.921319585@newssvr17.news.prodigy.com> <20011025165226.T7544@redhat.com> <7vofmuu9d7.fsf@siamese.dhis.twinsun.com> <20011026104125.Z7544@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> 
> On Fri, Oct 26, 2001 at 12:51:48AM -0700, junio@siamese.dhis.twinsun.com wrote:
> 
> > >From the original poster's description, 2.4.10 claimed to have
> > detected both address and irq for parport0, while 2.4.12,
> > according to the your response, could not tell that IRQ=7.  Do
> > you mean that the logic which made 2.4.10 to claime to have
> > detected IRQ=7 was faulty and the logic in 2.4.12 is being
> > careful not to misdetect?
> 
> Oh, I see.  No, this is a regression.  Please try this patch:

Firstly, I was unable to apply this patch on 2.4.13...

I'm now running 2.4.14-pre2, still had difficulty applying
the patch, and ended up patching parport_pc.c by hand. (?)

However, loading the parport_pc module, with NO arguments,
like I was doing up till 2.4.10, and it still does not
recognise the port as being in ECP mode:

[root@p450 /root]# modprobe parport_pc
[root@p450 /root]# dmesg -c
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100

If I load the module WITH arguments, something I've never
had to do in the past, it works:

[root@p450 /root]# modprobe parport_pc io=0x378 irq=7
[root@p450 /root]# dmesg -c
parport0: PC-style at 0x378 (0x778), irq 7, using FIFO [PCSPP,TRISTATE,COMPAT,ECP]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: faking semi-colon
parport0: Printer, Hewlett-Packard HP LaserJet 1100

I'm still unsure why I NEED to supply arguments
to this module.

Regards.

-- 
Dave Garry,
Daemon Solutions Ltd
