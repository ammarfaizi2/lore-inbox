Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262240AbSJJJxl>; Thu, 10 Oct 2002 05:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262247AbSJJJxl>; Thu, 10 Oct 2002 05:53:41 -0400
Received: from satan.intac.net ([199.173.52.34]:59918 "EHLO source.intac.net")
	by vger.kernel.org with ESMTP id <S262240AbSJJJxj>;
	Thu, 10 Oct 2002 05:53:39 -0400
Date: Thu, 10 Oct 2002 05:56:52 -0400 (EDT)
From: <kernellist@source.intac.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel oops message - Need some help pin-pointing the cause
In-Reply-To: <Pine.LNX.4.21.0210092340080.29539-100000@source.intac.net>
Message-ID: <Pine.LNX.4.21.0210100556300.29818-100000@source.intac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Im taking wild guesses right now - would disabling swap somehow help me
out?

On Wed, 9 Oct 2002 kernellist@source.intac.net wrote:

> Would multiple oops messages from the same box help? I just got two
> more. I get a run-away modperl process, it's killed by the kernel, but
> then port is seen as still in use. fuser shows nothing. netstat -ln shows
> as the port listening - Though I cant connect to the port? Anyone have
> any ideas? Is there at least a "qucik fix" for me so I can at least make
> the kernel see the port as being free so I can start up my modperl
> server? The only way I can get the apache started it if I reboot. So,
> please let me know if any more info is needed.
> 
> Thanks
> 
> On Wed, 9 Oct 2002 kernellist@source.intac.net wrote:
> 
> > First the oops message, then below that you will find more detailed info
> > on the software and hardware:
> > 
> > Out of Memory: Killed process 24511 (httpd).
> > Unable to handle kernel paging request at virtual address f8973000
> >  printing eip:
> > c0107387
> > *pde = 01e4d067
> > *pte = 00000000
> > Oops: 0000
> > nfs lockd sunrpc 3c59x e100 usb-uhci usbcore ext3 jbd aic7xxx DAC960
> > sd_mod sc
> > CPU:    1
> > EIP:    0010:[<c0107387>]    Not tainted
> > EFLAGS: 00010286
> > 
> > EIP is at copy_segments [kernel] 0x57 (2.4.18-5.2smp)
> > eax: f8962000   ebx: f8962000   ecx: 00004000   edx: f8972000
> > esi: f8973000   edi: f8962000   ebp: d97db500   esp: cb735f18
> > ds: 0018   es: 0018   ss: 0018
> > Process httpd (pid: 19151, stackpage=cb735000)
> > Stack: 00000000 00000000 ec0452c0 ec0452c0 c011ab1d e529e000 d97db500
> > cb734000 
> >        00001d29 f5ff9a2c cb734000 ec0452c0 d97db500 00000300 00000001
> > ee9fa5a0 
> >        ee9fa400 00000001 f764ea64 f675ea84 e529e000 c011b41a 00000011
> > e529e000 
> > Call Trace: [<c011ab1d>] copy_mm [kernel] 0x30d 
> > [<c011b41a>] do_fork [kernel] 0x4ca 
> > [<c0107685>] sys_fork [kernel] 0x15 
> > [<c0108c6b>] system_call [kernel] 0x33 
> > 
> > 
> > Code: f3 a5 89 9d 80 00 00 00 b9 ff ff ff ff 89 8d 84 00 00 00 5b 
> >  <3>Trying to vfree() nonexistent vm area (f8973000)
> > 
> > 
> > Kernel version:
> > 
> > 2.4.18-5.2smp #1 SMP
> > Hidden patch applied
> > 
> > Output of lspci:
> > 
> > 00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
> > 00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
> > 00:09.0 PCI bridge: Intel Corporation 80960RP [i960 RP
> > Microprocessor/Bridge] (rev 05)
> > 00:09.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
> > 00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
> > (rev 74)
> > 00:0c.0 SCSI storage controller: Adaptec 7896
> > 00:0c.1 SCSI storage controller: Adaptec 7896
> > 00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
> > (rev 08)
> > 00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
> > 00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
> > 00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
> > 00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
> > 00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23)
> > 01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
> > 
> > lsmod output:
> > 
> > Module                  Size  Used by
> > eepro100               22386   1 	#Note - I was using e100, but just
> > 					#changed to eepro100 right after
> > 					#this box came up from the reboot
> > nfs                    92235  12  (autoclean)
> > lockd                  59471   1  (autoclean) [nfs]
> > sunrpc                 85366   1  (autoclean) [nfs lockd]
> > 3c59x                  32100   1 
> > usb-uhci               26752   0  (unused)
> > usbcore                77167   1  [usb-uhci]
> > ext3                   73608   5 
> > jbd                    54880   5  [ext3]
> > aic7xxx               132425   0  (unused)
> > DAC960                 73070   6 
> > sd_mod                 13666   0  (unused)
> > scsi_mod              125385   2  [aic7xxx sd_mod]
> > 
> > 
> > Our mod_perl apache(1.3.22) build opts:
> > 
> > 			 --enable-module=vhost_alias \
> >                         --enable-module=usertrack \
> >                         --enable-module=expires \
> >                         --enable-module=alias \
> >                         --enable-module=mime \
> >                         --enable-module=setenvif \
> >                         --enable-module=cgi \
> >                         --enable-module=auth \
> >                         --disable-module=rewrite \
> >                         --disable-module=proxy \
> >                         --disable-module=negotiation \
> >                         --disable-module=autoindex \
> >                         --disable-module=asis \
> >                         --disable-module=imap \
> >                         --disable-module=actions \
> >                         --disable-module=userdir \
> >                         --disable-module=access \
> >                         --disable-module=status \
> >                         --disable-module=headers \
> >                         --disable-module=so \
> >                         --disable-rule=EXPAT '
> > 
> > 
> > 
> > basically, our modperl server dies when we get the oops, and it can not
> > bind on the port we need it to run - fuser shows nothing listening, though
> > a netstat -l shows that the machine is listening on the port. So, anyone
> > can tell me whhat is causing the oops message? And, if I have open
> > connections how can I kill them if the process that was listening for
> > those connections is no longer running? Can I do something in
> > proc(/proc/net/{udp|tcp|raw})? Hopefully I have given enough
> > information. If anything else is needed, please let me know.
> > 
> > Also, every other box I have has the same software. We have two different
> > types of hardware - But this host is the only one that has ever had a
> > problem. So, I am suspecting ram or second cpu having a problem. Can
> > anyone give me a definite on what is wrong? I will be running lm_sensors
> > on this to see if anything becomes obvious.
> > 
> > Thanks all.
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

