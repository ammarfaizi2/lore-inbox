Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285803AbRLHEGF>; Fri, 7 Dec 2001 23:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285802AbRLHEFw>; Fri, 7 Dec 2001 23:05:52 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:3045 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S285800AbRLHEFg>; Fri, 7 Dec 2001 23:05:36 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D7CE@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Ken Brownfield'" <brownfld@irridia.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Linux 2.4.17-pre6
Date: Fri, 7 Dec 2001 20:05:31 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, sorry..

I submitted that patch because newer as emits a warning, but I guess that's
the lesser of two evils, huh?

Regards -- Andy


> -----Original Message-----
> From: Ken Brownfield [mailto:brownfld@irridia.com]
> Sent: Friday, December 07, 2001 7:41 PM
> To: Marcelo Tosatti
> Cc: lkml
> Subject: Re: Linux 2.4.17-pre6
> Importance: High
> 
> 
> At the end of a -pre6 bzImage compile I'm getting this:
> 
> gcc -E -D__KERNEL__ -I/usr/src/linux-2.4.17-pre6/include 
> -D__BIG_KERNEL__ -D__ASSEMBLY__ -traditional 
> -DSVGA_MODE=NORMAL_VGA  setup.S -o bsetup.s
> as -o bsetup.o bsetup.s
> bsetup.s: Assembler messages:
> bsetup.s:1857: Error: suffix or operands invalid for `lcall'
> make[1]: *** [bsetup.o] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.4.17-pre6/arch/i386/boot'
> make: *** [bzImage] Error 2
> 
> It looks like the following patch from -pre6 causes compiles 
> to fail for
> me:
> 
> 
> --- linux-2.4.16/arch/i386/boot/setup.S	Fri Nov  9 19:58:02 2001
> +++ linux/arch/i386/boot/setup.S	Fri Dec  7 16:53:24 2001
> @@ -539,7 +539,7 @@
>  	cmpw	$0, %cs:realmode_swtch
>  	jz	rmodeswtch_normal
>  
> -	lcall	%cs:realmode_swtch
> +	lcall	*%cs:realmode_swtch
>  
>  	jmp	rmodeswtch_end
> 
>  
> Now granted, I'm a little behind:
> 
> % gcc -v
> Reading specs from 
> /usr/lib/gcc-lib/i386-redhat-linux/egcs-2.91.66/specs
> gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)
> % ld -v
> GNU ld version 2.9.5 (with BFD 2.9.5.0.22)
> 
> But do we really want to prevent RH6.2 (for example) from 
> compiling 2.4
> at this late stage?  2.95.3 became the minimum _after_ 2.4 
> was released,
> I now notice in Changes.
> 
> I'm reverting this patchlet for now, but I'm unsure if this will cause
> functionality issues.  Any input would be appreciated.
> 
> I could shift to 2.95.3, but with 3.0 "around the corner", 
> I'm hesitant
> to spend the additional testing time.  Not a huge deal, but...
> 
> Thanks,
> -- 
> Ken.
> brownfld@irridia.com
> 
> On Fri, Dec 07, 2001 at 07:38:23PM -0200, Marcelo Tosatti wrote:
> | 
> | Hi, 
> | 
> | Some critical stuff this time: Notably the multithread 
> coredump deadlock
> | fix and the copy_user_highpage fix for some architectures...
> | 
> | pre6:
> | 
> | - ISDN fixes					(Kai 
> Germaschewski)
> | - Eicon driver updates				(Kai 
> Germaschewski)
> | - ymfpci update					(Pete Zaitcev)
> | - Fix multithread coredump deadlock		(Manfred Spraul)
> | - Support /dev/kmem access to vmalloc space	(Marc Boucher)
> | - ext3 fixes/enhancements			(Andrew Morton)	
> | - Add IT8172G driver to Config.in/Makefile	(Giacomo Catenazzi)
> | - Configure.help update				(Eric 
> S. Raymond)
> | - Create __devexit_p() function and use that on 
> |   drivers which need it to make it possible to 
> |   use newer binutils				(Keith Owens) 
> | - Make PCMCIA compile without PCI support	(Paul Mackerras)
> | - Use copy_user_highpage instead copy_highpage
> |   on COW path.					(David 
> S. Miller)
> | - Cacheline align some more performance
> |   critical spinlocks				(Anton 
> Blanchard)
> | - sonypi driver update				
> (Michael C.B. Ashley/Bob Donnelly)
> | - direct render for some SiS cards		(Torsten Duwe/Alan Cox)
> | - full handling of the NFSv3 'jukebox' feature  (Trond Myklebust)
> | - NFS performance improvements			(Trond 
> Myklebust)
> | - More parport fixes				(Tim Waugh)
> | - Fix lots of core NCR5380 bugs			(Alan Cox)
> | - NCR5380/PAS driver update			(Alan Cox)
> | - Add aacraid to the SCSI list			(Alan Cox)
> | - fdomain driver fixes				(Alan Cox)
> | 
> | 
> | pre5:
> | 
> | - 8139too fixes					(Andreas Dilger)
> | - sym53c8xx_2 update				(Gerard Roudier)
> | - loopback deadlock bugfix			(Jan Kara)
> | - Yet another devfs update			(Richard Gooch)	
> | - Enable K7 SSE					(John Clemens)
> | - Make grab_cache_page return NULL instead 
> |   ERR_PTR: callers expect NULL on failure	(Christoph Hellwig)
> | - Make ide-{disk-floppy} compile without 
> |   PROCFS support				(Robert Love)
> | - Another ymfpci update				(Pete Zaitcev)
> | - indent NCR5380.{c,h}, g_NCR5380.{c,h}, plus 
> |   NCR5380 fix					(Alan Cox)
> | - SPARC32/64 update				(David S. Miller)
> | - Fix atyfb warnings				(David 
> S. Miller)
> | - Make bootmem init code correctly align 
> |   bootmem data					(David 
> S. Miller)
> | - Networking updates				(David 
> S. Miller)
> | - Fix scanning luns > 7 on SCSI-3 devices 	(Michael Clark)
> | - Add sparse lun hint for Chaparral G8324 
> | 	Fibre-SCSI controller			(Michael Clark)
> | - Really apply sg changes			(me)
> | - Parport updates				(Tim Waugh)
> | - ReiserFS updates				(Vladimir V. Saveliev)
> | - Make AGP code scan all kinds of devices:
> |   they are not always video ones		(Alan Cox)
> | - EXPORT_NO_SYMBOLS in floppy.c			(Alan Cox)
> | - Pentium IV Hyperthreading support		(Alan Cox)
> | 
> | pre4:
> | 
> | - Added missing tcp_diag.c and tcp_diag.h	(me)
> | 
> | pre3:
> | 
> | - Enable ppro errata workaround                 (Dave Jones)
> | - Update tmpfs documentation                    (Christoph Rohland)
> | - Fritz!PCIv2 ISDN card support                 (Kai Germaschewski)
> | - Really apply ymfpci changes                   (Pete Zaitcev)
> | - USB update                                    (Greg KH)
> | - Adds detection of more eepro100 cards         (Troy A. Griffitts)
> | - Make ftruncate64() compliant with SuS         (Andrew Morton)
> | - ATI64 fb driver update                        (Geert Uytterhoeven)
> | - Coda fixes                                    (Jan Harkes)
> | - devfs update                                  (Richard Gooch)
> | - Fix ad1848 breakage in -pre2                  (Alan Cox)
> | - Network updates                               (David S. Miller)
> | - Add cramfs locking                            (Christoph Hellwig)
> | - Move locking of page_table_lock on expand_stack
> |   before accessing any vma field                (Manfred Spraul)
> | - Make time monotonous with gettimeofday        (Andi Kleen)
> | - Add MODULE_LICENSE(GPL) to ide-tape.c         (Mikael Pettersson)
> | - Minor cs46xx ioctl fix                        (Thomas Woller)
> | 
> | pre2:
> | 
> | - Remove userland header from bonding driver	(David 
> S. Miller)
> | - Create a SLAB for page tables on i386		
> (Christoph Hellwig)
> | - Unregister devices at shaper unload time	(David S. Miller)
> | - Remove several unused variables from various
> |   places in the kernel				(David 
> S. Miller)
> | - Fix slab code to not blindly trust cc_data():
> |   it may be not valid on some platforms		(David 
> S. Miller)
> | - Fix RTC driver bug				(David 
> S. Miller)
> | - SPARC 32/64 update				(David 
> S. Miller)
> | - W9966 V4L driver update			(Jakob Jemi)
> | - ad1848 driver fixes				(Alan 
> Cox/Daniel T. Cobra)
> | - PCMCIA update					(David Hinds)
> | - Fix PCMCIA problem with multiple PCI busses 	(Paul Mackerras)
> | - Correctly free per-process signal struct	(Dave McCracken)
> | - IA64 PAL/signal headers cleanup		(Nathan Myers)
> | - ymfpci driver cleanup 			(Pete Zaitcev)
> | - Change NLS "licenses" to be "GPL/BSD" instead 
> |   only BSD.					(Robert Love)
> | - Fix serial module use count			(Russell King)
> | - Update sg to 3.1.22				
> (Douglas Gilbert)
> | - ieee1394 update				(Ben Collins)
> | - ReiserFS fixes				(Nikita Danilov)
> | - Update ACPI documentantion			(Patrick Mochel)
> | - Smarter atime update				(Andrew Morton)
> | - Correctly mark ext2 sb as dirty and sync it	(Andrew Morton) 
> | - IrDA update					(Jean 
> Tourrilhes)
> | - Count locked buffers at
> |   balance_dirty_state(): Helps interactivity under
> |   heavy IO workloads				(Andrew Morton)
> | - USB update					(Greg KH)
> | - ide-scsi locking fix                          (Christoph Hellwig)
> | 
> | pre1:
> | 
> | - Change USB maintainer 			(Greg Kroah-Hartman)
> | - Speeling fix for rd.c				(From 
> Ralf Baechle's tree)
> | - Updated URL for bigphysmem patch in v4l docs  (Adrian Bunk)
> | - Add buggy 440GX to broken pirq blacklist 	(Arjan Van de Ven)
> | - Add new entry to Sound blaster ISAPNP list	(Arjan 
> Van de Ven)
> | - Remove crap character from Configure.help	(Niels Kristian 
> Bech Jensen)
> | - Backout erroneous change to lookup_exec_domain (Christoph Hellwig)
> | - Update osst sound driver to 1.65		(Willem Riede)
> | - Fix i810 sound driver problems		(Andris Pavenis)
> | - Add AF_LLC define in network headers		
> (Arnaldo Carvalho de Melo)
> | - block_size cleanup on some SCSI drivers	(Erik Andersen)
> | - Added missing MODULE_LICENSE("GPL") in some   (Andreas Krennmair)
> |   modules
> | - Add ->show_options() to super_ops and 
> |   implement NFS method				(Alexander Viro)
> | - Updated i8k driver				
> (Massimo Dal Zoto)
> | - devfs update  				(Richard Gooch)
> | 
> | 
> | -
> | To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> | the body of a message to majordomo@vger.kernel.org
> | More majordomo info at  http://vger.kernel.org/majordomo-info.html
> | Please read the FAQ at  http://www.tux.org/lkml/
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
