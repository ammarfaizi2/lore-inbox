Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWBUWiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWBUWiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWBUWiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:38:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:6154 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750948AbWBUWix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:38:53 -0500
Date: Tue, 21 Feb 2006 23:38:45 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, akpm@osdl.org, agruen@suse.de, stable@kernel.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Remove MODULE_PARM
Message-ID: <20060221223845.GA10437@mars.ravnborg.org>
References: <200602200533.k1K5Xxpm015038@shell0.pdx.osdl.net> <20060220222132.GA28042@kroah.com> <1140493352.31524.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140493352.31524.24.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 02:42:32PM +1100, Rusty Russell wrote:
> 
> How about we clean the last 50 callers instead?  Compile tested with
> allyesconfig, but that doesn't get those hard to reach places...

Hi Andrew.
Can this patch simmer in -mm for a while?
I plan to look through it soon to do a sanity check.

	Sam

> 
> Cheers!
> Rusty.
> 
> MODULE_PARM was actually breaking: recent gcc version optimize them out
> as unused.  It's time to replace the last users, which are generally in
> the most unloved drivers anyway.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> 
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/Documentation/networking/ray_cs.txt working-2.6.16-rc4-PARAM/Documentation/networking/ray_cs.txt
> --- linux-2.6.16-rc4/Documentation/networking/ray_cs.txt	2006-01-10 15:17:56.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/Documentation/networking/ray_cs.txt	2006-02-21 13:09:47.000000000 +1100
> @@ -25,7 +25,7 @@ the essid= string parameter is available
>  This will change after the method of sorting out parameters for all
>  the PCMCIA drivers is agreed upon.  If you must have a built in driver
>  with nondefault parameters, they can be edited in
> -/usr/src/linux/drivers/net/pcmcia/ray_cs.c.  Searching for MODULE_PARM
> +/usr/src/linux/drivers/net/pcmcia/ray_cs.c.  Searching for module_param
>  will find them all.
>  
>  Information on card services is available at:
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/Documentation/sound/oss/Introduction working-2.6.16-rc4-PARAM/Documentation/sound/oss/Introduction
> --- linux-2.6.16-rc4/Documentation/sound/oss/Introduction	2005-02-04 18:47:38.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/Documentation/sound/oss/Introduction	2006-02-21 13:09:55.000000000 +1100
> @@ -69,7 +69,7 @@ are available, for example IRQ, address,
>  
>  Warning, the options for different cards sometime use different names 
>  for the same or a similar feature (dma1= versus dma16=).  As a last 
> -resort, inspect the code (search for MODULE_PARM).
> +resort, inspect the code (search for module_param).
>  
>  Notes:
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/Documentation/sound/oss/cs46xx working-2.6.16-rc4-PARAM/Documentation/sound/oss/cs46xx
> --- linux-2.6.16-rc4/Documentation/sound/oss/cs46xx	2004-02-04 14:43:11.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/Documentation/sound/oss/cs46xx	2006-02-21 13:12:30.000000000 +1100
> @@ -88,7 +88,7 @@ parameters.  for a copy email: twoller@c
>  
>  MODULE_PARMS definitions
>  ------------------------
> -MODULE_PARM(defaultorder, "i");
> +module_param(defaultorder, ulong, 0);
>  defaultorder=N
>  where N is a value from 1 to 12
>  The buffer order determines the size of the dma buffer for the driver.
> @@ -98,18 +98,18 @@ to not underrun the dma buffer as easily
>  rather than 64k as some of the games work more responsively.
>  (2^N) * PAGE_SIZE = allocated buffer size
>  
> -MODULE_PARM(cs_debuglevel, "i");
> -MODULE_PARM(cs_debugmask, "i");
> +module_param(cs_debuglevel, ulong, 0644);
> +module_param(cs_debugmask, ulong, 0644);
>  cs_debuglevel=N
>  cs_debugmask=0xMMMMMMMM
>  where N is a value from 0 (no debug printfs), to 9 (maximum)
>  0xMMMMMMMM is a debug mask corresponding to the CS_xxx bits (see driver source).
>  
> -MODULE_PARM(hercules_egpio_disable, "i");
> +module_param(hercules_egpio_disable, ulong, 0);
>  hercules_egpio_disable=N
>  where N is a 0 (enable egpio), or a 1 (disable egpio support)
>  
> -MODULE_PARM(initdelay, "i");
> +module_param(initdelay, ulong, 0);
>  initdelay=N
>  This value is used to determine the millescond delay during the initialization
>  code prior to powering up the PLL.  On laptops this value can be used to
> @@ -118,19 +118,19 @@ system is booted under battery power the
>  properly delay the required time.  Also, if the system is booted under AC power
>  and then the power removed, the mdelay()/udelay() functions will not delay properly.
>   
> -MODULE_PARM(powerdown, "i");
> +module_param(powerdown, ulong, 0);
>  powerdown=N
>  where N is 0 (disable any powerdown of the internal blocks) or 1 (enable powerdown)
>  
>  
> -MODULE_PARM(external_amp, "i");
> +module_param(external_amp, bool, 0);
>  external_amp=1
>  if N is set to 1, then force enabling the EAPD support in the primary AC97 codec.
>  override the detection logic and force the external amp bit in the AC97 0x26 register
>  to be reset (0).  EAPD should be 0 for powerup, and 1 for powerdown.  The VTB Santa Cruz
>  card has inverted logic, so there is a special function for these cards.
>  
> -MODULE_PARM(thinkpad, "i");
> +module_param(thinkpad, bool, 0);
>  thinkpad=1
>  if N is set to 1, then force enabling the clkrun functionality.
>  Currently, when the part is being used, then clkrun is disabled for the entire system,
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/arch/ppc/8xx_io/cs4218_tdm.c working-2.6.16-rc4-PARAM/arch/ppc/8xx_io/cs4218_tdm.c
> --- linux-2.6.16-rc4/arch/ppc/8xx_io/cs4218_tdm.c	2006-01-10 15:18:17.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/arch/ppc/8xx_io/cs4218_tdm.c	2006-02-21 13:13:06.000000000 +1100
> @@ -126,11 +126,11 @@ static int numReadBufs = 4, readbufSize 
>  */
>  static volatile cbd_t	*rx_base, *rx_cur, *tx_base, *tx_cur;
>  
> -MODULE_PARM(catchRadius, "i");
> -MODULE_PARM(numBufs, "i");
> -MODULE_PARM(bufSize, "i");
> -MODULE_PARM(numreadBufs, "i");
> -MODULE_PARM(readbufSize, "i");
> +module_param(catchRadius, int, 0);
> +module_param(numBufs, int, 0);
> +module_param(bufSize, int, 0);
> +module_param(numreadBufs, int, 0);
> +module_param(readbufSize, int, 0);
>  
>  #define arraysize(x)	(sizeof(x)/sizeof(*(x)))
>  #define le2be16(x)	(((x)<<8 & 0xff00) | ((x)>>8 & 0x00ff))
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/block/ataflop.c working-2.6.16-rc4-PARAM/drivers/block/ataflop.c
> --- linux-2.6.16-rc4/drivers/block/ataflop.c	2006-02-21 12:58:59.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/block/ataflop.c	2006-02-21 13:15:32.000000000 +1100
> @@ -271,7 +271,7 @@ unsigned char *DMABuffer;			  /* buffer 
>  static unsigned long PhysDMABuffer;   /* physical address */
>  
>  static int UseTrackbuffer = -1;		  /* Do track buffering? */
> -MODULE_PARM(UseTrackbuffer, "i");
> +module_param(UseTrackbuffer, int, 0);
>  
>  unsigned char *TrackBuffer;			  /* buffer for reads */
>  static unsigned long PhysTrackBuffer; /* physical address */
> @@ -296,7 +296,7 @@ static int MotorOn = 0, MotorOffTrys;
>  static int IsFormatting = 0, FormatError;
>  
>  static int UserSteprate[FD_MAX_UNITS] = { -1, -1 };
> -MODULE_PARM(UserSteprate, "1-" __MODULE_STRING(FD_MAX_UNITS) "i");
> +module_param_array(UserSteprate, int, NULL, 0);
>  
>  /* Synchronization of FDC access. */
>  static volatile int fdc_busy = 0;
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/cdrom/cm206.c working-2.6.16-rc4-PARAM/drivers/cdrom/cm206.c
> --- linux-2.6.16-rc4/drivers/cdrom/cm206.c	2006-02-21 12:59:01.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/cdrom/cm206.c	2006-02-21 13:15:25.000000000 +1100
> @@ -218,12 +218,12 @@ static int cm206_base = CM206_BASE;
>  static int cm206_irq = CM206_IRQ;
>  #ifdef MODULE
>  static int cm206[2] = { 0, 0 };	/* for compatible `insmod' parameter passing */
> +module_param_array(cm206, int, NULL, 0);	/* base,irq or irq,base */
>  #endif
>  
> -MODULE_PARM(cm206_base, "i");	/* base */
> -MODULE_PARM(cm206_irq, "i");	/* irq */
> -MODULE_PARM(cm206, "1-2i");	/* base,irq or irq,base */
> -MODULE_PARM(auto_probe, "i");	/* auto probe base and irq */
> +module_param(cm206_base, int, 0);	/* base */
> +module_param(cm206_irq, int, 0);	/* irq */
> +module_param(auto_probe, bool, 0);	/* auto probe base and irq */
>  MODULE_LICENSE("GPL");
>  
>  #define POLLOOP 100		/* milliseconds */
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/cdrom/sbpcd.c working-2.6.16-rc4-PARAM/drivers/cdrom/sbpcd.c
> --- linux-2.6.16-rc4/drivers/cdrom/sbpcd.c	2005-10-31 12:20:38.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/cdrom/sbpcd.c	2006-02-21 13:18:51.000000000 +1100
> @@ -464,8 +464,13 @@ static int sbpcd[] =
>  static  __cacheline_aligned DEFINE_SPINLOCK(sbpcd_lock);
>  static struct request_queue *sbpcd_queue;
>  
> -MODULE_PARM(sbpcd, "2i");
> -MODULE_PARM(max_drives, "i");
> +/* You can only set the first pair, from old MODULE_PARM code.  */
> +static int sbpcd_set(const char *val, struct kernel_param *kp)
> +{
> +	get_options((char *)val, 2, (int *)sbpcd);
> +	return 0;
> +}
> +module_param_call(sbpcd, sbpcd_set, NULL, NULL, 0);
>  
>  #define NUM_PROBE  (sizeof(sbpcd) / sizeof(int))
>  
> @@ -553,6 +558,7 @@ static unsigned char msgnum;
>  static char msgbuf[80];
>  
>  static int max_drives = MAX_DRIVES;
> +module_param(max_drives, int, 0);
>  #ifndef MODULE
>  static unsigned char setup_done;
>  static const char *str_sb_l = "soundblaster";
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/char/istallion.c working-2.6.16-rc4-PARAM/drivers/char/istallion.c
> --- linux-2.6.16-rc4/drivers/char/istallion.c	2006-02-21 12:59:08.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/char/istallion.c	2006-02-21 13:20:37.000000000 +1100
> @@ -379,13 +379,13 @@ MODULE_DESCRIPTION("Stallion Intelligent
>  MODULE_LICENSE("GPL");
>  
>  
> -MODULE_PARM(board0, "1-3s");
> +module_parm_array(board0, charp, NULL, 0);
>  MODULE_PARM_DESC(board0, "Board 0 config -> name[,ioaddr[,memaddr]");
> -MODULE_PARM(board1, "1-3s");
> +module_parm_array(board1, charp, NULL, 0);
>  MODULE_PARM_DESC(board1, "Board 1 config -> name[,ioaddr[,memaddr]");
> -MODULE_PARM(board2, "1-3s");
> +module_parm_array(board2, charp, NULL, 0);
>  MODULE_PARM_DESC(board2, "Board 2 config -> name[,ioaddr[,memaddr]");
> -MODULE_PARM(board3, "1-3s");
> +module_parm_array(board3, charp, NULL, 0);
>  MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,memaddr]");
>  
>  #endif
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/char/mxser.c working-2.6.16-rc4-PARAM/drivers/char/mxser.c
> --- linux-2.6.16-rc4/drivers/char/mxser.c	2006-02-21 12:59:08.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/char/mxser.c	2006-02-21 13:21:32.000000000 +1100
> @@ -243,10 +243,10 @@ static int verbose = 0;
>  
>  MODULE_AUTHOR("Casper Yang");
>  MODULE_DESCRIPTION("MOXA Smartio/Industio Family Multiport Board Device Driver");
> -MODULE_PARM(ioaddr, "1-4i");
> -MODULE_PARM(ttymajor, "i");
> -MODULE_PARM(calloutmajor, "i");
> -MODULE_PARM(verbose, "i");
> +module_param_array(ioaddr, int, NULL, 0);
> +module_param(ttymajor, int, 0);
> +module_param(calloutmajor, int, 0);
> +module_param(verbose, bool, 0);
>  MODULE_LICENSE("GPL");
>  
>  struct mxser_log {
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/char/riscom8.c working-2.6.16-rc4-PARAM/drivers/char/riscom8.c
> --- linux-2.6.16-rc4/drivers/char/riscom8.c	2006-02-21 12:59:09.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/char/riscom8.c	2006-02-21 13:21:58.000000000 +1100
> @@ -1743,10 +1743,10 @@ static int iobase;
>  static int iobase1;
>  static int iobase2;
>  static int iobase3;
> -MODULE_PARM(iobase, "i");
> -MODULE_PARM(iobase1, "i");
> -MODULE_PARM(iobase2, "i");
> -MODULE_PARM(iobase3, "i");
> +module_param(iobase, int, 0);
> +module_param(iobase1, int, 0);
> +module_param(iobase2, int, 0);
> +module_param(iobase3, int, 0);
>  
>  MODULE_LICENSE("GPL");
>  #endif /* MODULE */
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hardware/avm/b1dma.c working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/b1dma.c
> --- linux-2.6.16-rc4/drivers/isdn/hardware/avm/b1dma.c	2005-08-29 14:39:35.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/b1dma.c	2006-02-21 13:22:14.000000000 +1100
> @@ -39,7 +39,7 @@ MODULE_AUTHOR("Carsten Paeth");
>  MODULE_LICENSE("GPL");
>  
>  static int suppress_pollack = 0;
> -MODULE_PARM(suppress_pollack, "0-1i");
> +module_param(suppress_pollack, bool, 0);
>  
>  /* ------------------------------------------------------------- */
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hardware/avm/b1isa.c working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/b1isa.c
> --- linux-2.6.16-rc4/drivers/isdn/hardware/avm/b1isa.c	2005-02-04 18:45:29.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/b1isa.c	2006-02-21 13:22:42.000000000 +1100
> @@ -169,8 +169,8 @@ static struct pci_dev isa_dev[MAX_CARDS]
>  static int io[MAX_CARDS];
>  static int irq[MAX_CARDS];
>  
> -MODULE_PARM(io, "1-" __MODULE_STRING(MAX_CARDS) "i");
> -MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_CARDS) "i");
> +module_param_array(io, int, NULL, 0);
> +module_param_array(irq, int, NULL, 0);
>  MODULE_PARM_DESC(io, "I/O base address(es)");
>  MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hardware/avm/c4.c working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/c4.c
> --- linux-2.6.16-rc4/drivers/isdn/hardware/avm/c4.c	2005-08-29 14:39:35.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/c4.c	2006-02-21 13:24:39.000000000 +1100
> @@ -50,7 +50,7 @@ MODULE_DEVICE_TABLE(pci, c4_pci_tbl);
>  MODULE_DESCRIPTION("CAPI4Linux: Driver for AVM C2/C4 cards");
>  MODULE_AUTHOR("Carsten Paeth");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(suppress_pollack, "0-1i");
> +module_param(suppress_pollack, bool, 0);
>  
>  /* ------------------------------------------------------------- */
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hardware/avm/t1isa.c working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/t1isa.c
> --- linux-2.6.16-rc4/drivers/isdn/hardware/avm/t1isa.c	2005-08-29 14:39:35.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hardware/avm/t1isa.c	2006-02-21 13:23:13.000000000 +1100
> @@ -519,9 +519,9 @@ static int io[MAX_CARDS];
>  static int irq[MAX_CARDS];
>  static int cardnr[MAX_CARDS];
>  
> -MODULE_PARM(io, "1-" __MODULE_STRING(MAX_CARDS) "i");
> -MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_CARDS) "i");
> -MODULE_PARM(cardnr, "1-" __MODULE_STRING(MAX_CARDS) "i");
> +module_param_array(io, int, NULL, 0);
> +module_param_array(irq, int, NULL, 0);
> +module_param_array(cardnr, int, NULL, 0);
>  MODULE_PARM_DESC(io, "I/O base address(es)");
>  MODULE_PARM_DESC(irq, "IRQ number(s) (assigned)");
>  MODULE_PARM_DESC(cardnr, "Card number(s) (as jumpered)");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hysdn/hycapi.c working-2.6.16-rc4-PARAM/drivers/isdn/hysdn/hycapi.c
> --- linux-2.6.16-rc4/drivers/isdn/hysdn/hycapi.c	2006-01-10 15:18:43.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hysdn/hycapi.c	2006-02-21 13:24:57.000000000 +1100
> @@ -31,7 +31,7 @@
>  static char hycapi_revision[]="$Revision: 1.8.6.4 $";
>  
>  unsigned int hycapi_enable = 0xffffffff; 
> -MODULE_PARM(hycapi_enable, "i");
> +module_param(hycapi_enable, uint, 0);
>  
>  typedef struct _hycapi_appl {
>  	unsigned int ctrl_mask;
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/hysdn/hysdn_net.c working-2.6.16-rc4-PARAM/drivers/isdn/hysdn/hysdn_net.c
> --- linux-2.6.16-rc4/drivers/isdn/hysdn/hysdn_net.c	2006-01-10 15:18:43.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/hysdn/hysdn_net.c	2006-02-21 13:25:06.000000000 +1100
> @@ -24,7 +24,7 @@
>  #include "hysdn_defs.h"
>  
>  unsigned int hynet_enable = 0xffffffff; 
> -MODULE_PARM(hynet_enable, "i");
> +module_param(hynet_enable, uint, 0);
>  
>  /* store the actual version for log reporting */
>  char *hysdn_net_revision = "$Revision: 1.8.6.4 $";
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/isdn/isdnloop/isdnloop.c working-2.6.16-rc4-PARAM/drivers/isdn/isdnloop/isdnloop.c
> --- linux-2.6.16-rc4/drivers/isdn/isdnloop/isdnloop.c	2006-01-10 15:18:44.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/isdn/isdnloop/isdnloop.c	2006-02-21 13:25:26.000000000 +1100
> @@ -22,7 +22,7 @@ static char *isdnloop_id = "loop0";
>  MODULE_DESCRIPTION("ISDN4Linux: Pseudo Driver that simulates an ISDN card");
>  MODULE_AUTHOR("Fritz Elfert");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(isdnloop_id, "s");
> +module_param(isdnloop_id, charp, 0);
>  MODULE_PARM_DESC(isdnloop_id, "ID-String of first card");
>  
>  static int isdnloop_addcard(char *);
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/media/video/zr36120.c working-2.6.16-rc4-PARAM/drivers/media/video/zr36120.c
> --- linux-2.6.16-rc4/drivers/media/video/zr36120.c	2006-02-21 12:59:34.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/media/video/zr36120.c	2006-02-21 13:26:11.000000000 +1100
> @@ -70,10 +70,10 @@ MODULE_AUTHOR("Pauline Middelink <middel
>  MODULE_DESCRIPTION("Zoran ZR36120 based framegrabber");
>  MODULE_LICENSE("GPL");
>  
> -MODULE_PARM(triton1,"i");
> -MODULE_PARM(cardtype,"1-" __MODULE_STRING(ZORAN_MAX) "i");
> -MODULE_PARM(video_nr,"i");
> -MODULE_PARM(vbi_nr,"i");
> +module_param(triton1, uint, 0);
> +module_param_array(cardtype, uint, NULL, 0);
> +module_param(video_nr, int, 0);
> +module_param(vbi_nr, int, 0);
>  
>  static int zoran_cards;
>  static struct zoran zorans[ZORAN_MAX];
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/mmc/au1xmmc.c working-2.6.16-rc4-PARAM/drivers/mmc/au1xmmc.c
> --- linux-2.6.16-rc4/drivers/mmc/au1xmmc.c	2006-02-21 12:59:36.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/mmc/au1xmmc.c	2006-02-21 13:41:36.000000000 +1100
> @@ -87,7 +87,7 @@ struct au1xmmc_host *au1xmmc_hosts[AU1XM
>  static int dma = 1;
>  
>  #ifdef MODULE
> -MODULE_PARM(dma, "i");
> +module_param(dma, bool, 0);
>  MODULE_PARM_DESC(dma, "Use DMA engine for data transfers (0 = disabled)");
>  #endif
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/mtd/maps/pcmciamtd.c working-2.6.16-rc4-PARAM/drivers/mtd/maps/pcmciamtd.c
> --- linux-2.6.16-rc4/drivers/mtd/maps/pcmciamtd.c	2006-02-21 12:59:36.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/mtd/maps/pcmciamtd.c	2006-02-21 13:27:18.000000000 +1100
> @@ -28,7 +28,7 @@
>  
>  #ifdef CONFIG_MTD_DEBUG
>  static int debug = CONFIG_MTD_DEBUG_VERBOSE;
> -MODULE_PARM(debug, "i");
> +module_param(debug, int, 0);
>  MODULE_PARM_DESC(debug, "Set Debug Level 0=quiet, 5=noisy");
>  #undef DEBUG
>  #define DEBUG(n, format, arg...) \
> @@ -89,17 +89,17 @@ static int mem_type;
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Simon Evans <spse@secret.org.uk>");
>  MODULE_DESCRIPTION(DRIVER_DESC);
> -MODULE_PARM(bankwidth, "i");
> +module_param(bankwidth, int, 0);
>  MODULE_PARM_DESC(bankwidth, "Set bankwidth (1=8 bit, 2=16 bit, default=2)");
> -MODULE_PARM(mem_speed, "i");
> +module_param(mem_speed, int, 0);
>  MODULE_PARM_DESC(mem_speed, "Set memory access speed in ns");
> -MODULE_PARM(force_size, "i");
> +module_param(force_size, int, 0);
>  MODULE_PARM_DESC(force_size, "Force size of card in MiB (1-64)");
> -MODULE_PARM(setvpp, "i");
> +module_param(setvpp, int, 0);
>  MODULE_PARM_DESC(setvpp, "Set Vpp (0=Never, 1=On writes, 2=Always on, default=0)");
> -MODULE_PARM(vpp, "i");
> +module_param(vpp, int, 0);
>  MODULE_PARM_DESC(vpp, "Vpp value in 1/10ths eg 33=3.3V 120=12V (Dangerous)");
> -MODULE_PARM(mem_type, "i");
> +module_param(mem_type, int, 0);
>  MODULE_PARM_DESC(mem_type, "Set Memory type (0=Flash, 1=RAM, 2=ROM, default=0)");
>  
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/atari_bionet.c working-2.6.16-rc4-PARAM/drivers/net/atari_bionet.c
> --- linux-2.6.16-rc4/drivers/net/atari_bionet.c	2005-10-31 12:20:51.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/atari_bionet.c	2006-02-21 13:28:36.000000000 +1100
> @@ -123,7 +123,7 @@ static char version[] =
>   * Global variable 'bionet_debug'. Can be set at load time by 'insmod'
>   */
>  unsigned int bionet_debug = NET_DEBUG;
> -MODULE_PARM(bionet_debug, "i");
> +module_param(bionet_debug, int, 0);
>  MODULE_PARM_DESC(bionet_debug, "bionet debug level (0-2)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/atari_pamsnet.c working-2.6.16-rc4-PARAM/drivers/net/atari_pamsnet.c
> --- linux-2.6.16-rc4/drivers/net/atari_pamsnet.c	2005-10-31 12:20:51.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/atari_pamsnet.c	2006-02-21 13:28:42.000000000 +1100
> @@ -119,7 +119,7 @@ static char *version =
>   * Global variable 'pamsnet_debug'. Can be set at load time by 'insmod'
>   */
>  unsigned int pamsnet_debug = NET_DEBUG;
> -MODULE_PARM(pamsnet_debug, "i");
> +module_param(pamsnet_debug, int, 0);
>  MODULE_PARM_DESC(pamsnet_debug, "pamsnet debug enable (0-1)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/atarilance.c working-2.6.16-rc4-PARAM/drivers/net/atarilance.c
> --- linux-2.6.16-rc4/drivers/net/atarilance.c	2005-10-31 12:20:51.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/atarilance.c	2006-02-21 13:28:50.000000000 +1100
> @@ -78,7 +78,7 @@ static int lance_debug = LANCE_DEBUG;
>  #else
>  static int lance_debug = 1;
>  #endif
> -MODULE_PARM(lance_debug, "i");
> +module_param(lance_debug, int, 0);
>  MODULE_PARM_DESC(lance_debug, "atarilance debug level (0-3)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/cassini.c working-2.6.16-rc4-PARAM/drivers/net/cassini.c
> --- linux-2.6.16-rc4/drivers/net/cassini.c	2006-02-21 12:59:38.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/cassini.c	2006-02-21 13:32:49.000000000 +1100
> @@ -191,12 +191,15 @@
>  static char version[] __devinitdata =
>  	DRV_MODULE_NAME ".c:v" DRV_MODULE_VERSION " (" DRV_MODULE_RELDATE ")\n";
>  
> +static int cassini_debug = -1;	/* -1 == use CAS_DEF_MSG_ENABLE as value */
> +static int link_mode;
> +
>  MODULE_AUTHOR("Adrian Sun (asun@darksunrising.com)");
>  MODULE_DESCRIPTION("Sun Cassini(+) ethernet driver");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(cassini_debug, "i");
> +module_param(cassini_debug, int, 0);
>  MODULE_PARM_DESC(cassini_debug, "Cassini bitmapped debugging message enable value");
> -MODULE_PARM(link_mode, "i");
> +module_param(link_mode, int, 0);
>  MODULE_PARM_DESC(link_mode, "default link mode");
>  
>  /*
> @@ -208,7 +211,7 @@ MODULE_PARM_DESC(link_mode, "default lin
>   * Value in seconds, for user input.
>   */
>  static int linkdown_timeout = DEFAULT_LINKDOWN_TIMEOUT;
> -MODULE_PARM(linkdown_timeout, "i");
> +module_param(linkdown_timeout, int, 0);
>  MODULE_PARM_DESC(linkdown_timeout,
>  "min reset interval in sec. for PCS linkdown issue; disabled if not positive");
>  
> @@ -220,8 +223,6 @@ MODULE_PARM_DESC(linkdown_timeout,
>  static int link_transition_timeout;
>  
>  
> -static int cassini_debug = -1;	/* -1 == use CAS_DEF_MSG_ENABLE as value */
> -static int link_mode;
>  
>  static u16 link_modes[] __devinitdata = {
>  	BMCR_ANENABLE,			 /* 0 : autoneg */
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/chelsio/cxgb2.c working-2.6.16-rc4-PARAM/drivers/net/chelsio/cxgb2.c
> --- linux-2.6.16-rc4/drivers/net/chelsio/cxgb2.c	2005-10-31 12:20:51.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/chelsio/cxgb2.c	2006-02-21 13:32:55.000000000 +1100
> @@ -124,7 +124,7 @@ MODULE_LICENSE("GPL");
>  
>  static int dflt_msg_enable = DFLT_MSG_ENABLE;
>  
> -MODULE_PARM(dflt_msg_enable, "i");
> +module_param(dflt_msg_enable, int, 0);
>  MODULE_PARM_DESC(dflt_msg_enable, "Chelsio T1 message enable bitmap");
>  
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/fec_8xx/fec_main.c working-2.6.16-rc4-PARAM/drivers/net/fec_8xx/fec_main.c
> --- linux-2.6.16-rc4/drivers/net/fec_8xx/fec_main.c	2005-02-04 18:50:06.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/fec_8xx/fec_main.c	2006-02-21 13:32:04.000000000 +1100
> @@ -55,11 +55,11 @@ MODULE_AUTHOR("Pantelis Antoniou <panto@
>  MODULE_DESCRIPTION("Motorola 8xx FEC ethernet driver");
>  MODULE_LICENSE("GPL");
>  
> -MODULE_PARM(fec_8xx_debug, "i");
> +int fec_8xx_debug = -1;		/* -1 == use FEC_8XX_DEF_MSG_ENABLE as value */
> +module_param(fec_8xx_debug, int, 0);
>  MODULE_PARM_DESC(fec_8xx_debug,
>  		 "FEC 8xx bitmapped debugging message enable value");
>  
> -int fec_8xx_debug = -1;		/* -1 == use FEC_8XX_DEF_MSG_ENABLE as value */
>  
>  /*************************************************/
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/fs_enet/fs_enet-main.c working-2.6.16-rc4-PARAM/drivers/net/fs_enet/fs_enet-main.c
> --- linux-2.6.16-rc4/drivers/net/fs_enet/fs_enet-main.c	2006-01-10 15:18:53.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/fs_enet/fs_enet-main.c	2006-02-21 13:33:07.000000000 +1100
> @@ -58,11 +58,11 @@ MODULE_DESCRIPTION("Freescale Ethernet D
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(DRV_MODULE_VERSION);
>  
> -MODULE_PARM(fs_enet_debug, "i");
> +int fs_enet_debug = -1;		/* -1 == use FS_ENET_DEF_MSG_ENABLE as value */
> +module_param(fs_enet_debug, int, 0);
>  MODULE_PARM_DESC(fs_enet_debug,
>  		 "Freescale bitmapped debugging message enable value");
>  
> -int fs_enet_debug = -1;		/* -1 == use FS_ENET_DEF_MSG_ENABLE as value */
>  
>  static void fs_set_multicast_list(struct net_device *dev)
>  {
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/gt96100eth.c working-2.6.16-rc4-PARAM/drivers/net/gt96100eth.c
> --- linux-2.6.16-rc4/drivers/net/gt96100eth.c	2006-01-10 15:18:53.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/gt96100eth.c	2006-02-21 13:30:04.000000000 +1100
> @@ -114,8 +114,8 @@ static int max_interrupt_work = 32;
>  
>  static char mac0[18] = "00.02.03.04.05.06";
>  static char mac1[18] = "00.01.02.03.04.05";
> -MODULE_PARM(mac0, "c18");
> -MODULE_PARM(mac1, "c18");
> +module_param_string(mac0, mac0, 18, 0);
> +module_param_string(mac1, mac0, 18, 0);
>  MODULE_PARM_DESC(mac0, "MAC address for GT96100 ethernet port 0");
>  MODULE_PARM_DESC(mac1, "MAC address for GT96100 ethernet port 1");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/hamradio/dmascc.c working-2.6.16-rc4-PARAM/drivers/net/hamradio/dmascc.c
> --- linux-2.6.16-rc4/drivers/net/hamradio/dmascc.c	2006-01-10 15:18:53.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/hamradio/dmascc.c	2006-02-21 13:27:39.000000000 +1100
> @@ -280,7 +280,7 @@ static unsigned long rand;
>  
>  MODULE_AUTHOR("Klaus Kudielka");
>  MODULE_DESCRIPTION("Driver for high-speed SCC boards");
> -MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NUM_DEVS) "i");
> +module_param_array(io, int, NULL, 0);
>  MODULE_LICENSE("GPL");
>  
>  static void __exit dmascc_exit(void)
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/hamradio/mkiss.c working-2.6.16-rc4-PARAM/drivers/net/hamradio/mkiss.c
> --- linux-2.6.16-rc4/drivers/net/hamradio/mkiss.c	2006-02-21 12:59:39.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/hamradio/mkiss.c	2006-02-21 13:27:47.000000000 +1100
> @@ -1012,7 +1012,7 @@ static void __exit mkiss_exit_driver(voi
>  
>  MODULE_AUTHOR("Ralf Baechle DL5RB <ralf@linux-mips.org>");
>  MODULE_DESCRIPTION("KISS driver for AX.25 over TTYs");
> -MODULE_PARM(crc_force, "i");
> +module_param(crc_force, int, 0);
>  MODULE_PARM_DESC(crc_force, "crc [0 = auto | 1 = none | 2 = flexnet | 3 = smack]");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_LDISC(N_AX25);
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/irda/irport.c working-2.6.16-rc4-PARAM/drivers/net/irda/irport.c
> --- linux-2.6.16-rc4/drivers/net/irda/irport.c	2006-02-21 12:59:40.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/irda/irport.c	2006-02-21 13:28:28.000000000 +1100
> @@ -1118,9 +1118,9 @@ static void __exit irport_cleanup(void)
>   	}
>  }
>  
> -MODULE_PARM(io, "1-4i");
> +module_param_array(io, int, NULL, 0);
>  MODULE_PARM_DESC(io, "Base I/O addresses");
> -MODULE_PARM(irq, "1-4i");
> +module_param_array(irq, int, NULL, 0);
>  MODULE_PARM_DESC(irq, "IRQ lines");
>  
>  MODULE_AUTHOR("Dag Brattli <dagb@cs.uit.no>");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/lasi_82596.c working-2.6.16-rc4-PARAM/drivers/net/lasi_82596.c
> --- linux-2.6.16-rc4/drivers/net/lasi_82596.c	2006-01-10 15:18:54.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/lasi_82596.c	2006-02-21 13:30:43.000000000 +1100
> @@ -177,7 +177,7 @@ static int i596_debug = (DEB_SERIOUS|DEB
>  MODULE_AUTHOR("Richard Hirst");
>  MODULE_DESCRIPTION("i82596 driver");
>  MODULE_LICENSE("GPL");
> -MODULE_PARM(i596_debug, "i");
> +module_param(i596_debug, int, 0);
>  MODULE_PARM_DESC(i596_debug, "lasi_82596 debug mask");
>  
>  /* Copy frames shorter than rx_copybreak, otherwise pass on up in
> @@ -1520,9 +1520,9 @@ static void set_multicast_list(struct ne
>  	}
>  }
>  
> -MODULE_PARM(debug, "i");
> -MODULE_PARM_DESC(debug, "lasi_82596 debug mask");
>  static int debug = -1;
> +module_param(debug, int, 0);
> +MODULE_PARM_DESC(debug, "lasi_82596 debug mask");
>  
>  static int num_drivers;
>  static struct net_device *netdevs[MAX_DRIVERS];
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/mac89x0.c working-2.6.16-rc4-PARAM/drivers/net/mac89x0.c
> --- linux-2.6.16-rc4/drivers/net/mac89x0.c	2005-02-04 18:50:07.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/mac89x0.c	2006-02-21 13:31:09.000000000 +1100
> @@ -629,7 +629,7 @@ static int set_mac_address(struct net_de
>  static struct net_device *dev_cs89x0;
>  static int debug;
>  
> -MODULE_PARM(debug, "i");
> +module_param(debug, int, 0);
>  MODULE_PARM_DESC(debug, "CS89[02]0 debug level (0-5)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/mace.c working-2.6.16-rc4-PARAM/drivers/net/mace.c
> --- linux-2.6.16-rc4/drivers/net/mace.c	2006-01-10 15:18:54.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/mace.c	2006-02-21 13:30:56.000000000 +1100
> @@ -1042,7 +1042,7 @@ static void __exit mace_cleanup(void)
>  
>  MODULE_AUTHOR("Paul Mackerras");
>  MODULE_DESCRIPTION("PowerMac MACE driver.");
> -MODULE_PARM(port_aaui, "i");
> +module_param(port_aaui, int, 0);
>  MODULE_PARM_DESC(port_aaui, "MACE uses AAUI port (0-1)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/meth.c working-2.6.16-rc4-PARAM/drivers/net/meth.c
> --- linux-2.6.16-rc4/drivers/net/meth.c	2005-07-15 04:39:09.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/drivers/net/meth.c	2006-02-21 13:31:01.000000000 +1100
> @@ -62,7 +62,7 @@ MODULE_DESCRIPTION("SGI O2 Builtin Fast 
>  
>  #ifdef HAVE_TX_TIMEOUT
>  static int timeout = TX_TIMEOUT;
> -MODULE_PARM(timeout, "i");
> +module_param(timeout, int, 0);
>  #endif
>  
>  /*
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/ne-h8300.c working-2.6.16-rc4-PARAM/drivers/net/ne-h8300.c
> --- linux-2.6.16-rc4/drivers/net/ne-h8300.c	2005-08-29 14:39:43.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/drivers/net/ne-h8300.c	2006-02-21 13:31:30.000000000 +1100
> @@ -600,9 +600,9 @@ static int io[MAX_NE_CARDS];
>  static int irq[MAX_NE_CARDS];
>  static int bad[MAX_NE_CARDS];	/* 0xbad = bad sig or no reset ack */
>  
> -MODULE_PARM(io, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
> -MODULE_PARM(irq, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
> -MODULE_PARM(bad, "1-" __MODULE_STRING(MAX_NE_CARDS) "i");
> +module_param_array(io, int, NULL, 0);
> +module_param_array(irq, int, NULL, 0);
> +module_param_array(bad, int, NULL, 0);
>  MODULE_PARM_DESC(io, "I/O base address(es)");
>  MODULE_PARM_DESC(irq, "IRQ number(s)");
>  MODULE_DESCRIPTION("H8/300 NE2000 Ethernet driver");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/ni5010.c working-2.6.16-rc4-PARAM/drivers/net/ni5010.c
> --- linux-2.6.16-rc4/drivers/net/ni5010.c	2005-02-04 18:50:07.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/ni5010.c	2006-02-21 13:31:42.000000000 +1100
> @@ -766,8 +766,8 @@ static void ni5010_show_registers(struct
>  #ifdef MODULE
>  static struct net_device *dev_ni5010;
>  
> -MODULE_PARM(io, "i");
> -MODULE_PARM(irq, "i");
> +module_param(io, int, 0);
> +module_param(irq, int, 0);
>  MODULE_PARM_DESC(io, "ni5010 I/O base address");
>  MODULE_PARM_DESC(irq, "ni5010 IRQ number");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/net/sun3lance.c working-2.6.16-rc4-PARAM/drivers/net/sun3lance.c
> --- linux-2.6.16-rc4/drivers/net/sun3lance.c	2006-02-21 12:59:44.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/net/sun3lance.c	2006-02-21 13:31:51.000000000 +1100
> @@ -71,7 +71,7 @@ static int lance_debug = LANCE_DEBUG;
>  #else
>  static int lance_debug = 1;
>  #endif
> -MODULE_PARM(lance_debug, "i");
> +module_param(lance_debug, int, 0);
>  MODULE_PARM_DESC(lance_debug, "SUN3 Lance debug level (0-3)");
>  MODULE_LICENSE("GPL");
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/s390/block/dasd.c working-2.6.16-rc4-PARAM/drivers/s390/block/dasd.c
> --- linux-2.6.16-rc4/drivers/s390/block/dasd.c	2006-02-21 12:59:54.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/s390/block/dasd.c	2006-02-21 13:35:13.000000000 +1100
> @@ -44,7 +44,6 @@ MODULE_AUTHOR("Holger Smolinski <Holger.
>  MODULE_DESCRIPTION("Linux on S/390 DASD device driver,"
>  		   " Copyright 2000 IBM Corporation");
>  MODULE_SUPPORTED_DEVICE("dasd");
> -MODULE_PARM(dasd, "1-" __MODULE_STRING(256) "s");
>  MODULE_LICENSE("GPL");
>  
>  /*
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/s390/block/dasd_devmap.c working-2.6.16-rc4-PARAM/drivers/s390/block/dasd_devmap.c
> --- linux-2.6.16-rc4/drivers/s390/block/dasd_devmap.c	2006-02-21 12:59:54.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/s390/block/dasd_devmap.c	2006-02-21 13:36:06.000000000 +1100
> @@ -16,6 +16,7 @@
>  #include <linux/config.h>
>  #include <linux/ctype.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  
>  #include <asm/debug.h>
>  #include <asm/uaccess.h>
> @@ -69,6 +70,8 @@ int dasd_autodetect = 0;	/* is true, whe
>   * strings when running as a module.
>   */
>  static char *dasd[256];
> +module_param_array(dasd, charp, NULL, 0);
> +
>  /*
>   * Single spinlock to protect devmap structures and lists.
>   */
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/scsi/arm/cumana_2.c working-2.6.16-rc4-PARAM/drivers/scsi/arm/cumana_2.c
> --- linux-2.6.16-rc4/drivers/scsi/arm/cumana_2.c	2006-02-21 13:00:03.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/scsi/arm/cumana_2.c	2006-02-21 13:36:31.000000000 +1100
> @@ -550,6 +550,6 @@ module_exit(cumanascsi2_exit);
>  
>  MODULE_AUTHOR("Russell King");
>  MODULE_DESCRIPTION("Cumana SCSI-2 driver for Acorn machines");
> -MODULE_PARM(term, "1-8i");
> +module_param_array(term, int, NULL, 0);
>  MODULE_PARM_DESC(term, "SCSI bus termination");
>  MODULE_LICENSE("GPL");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/scsi/arm/eesox.c working-2.6.16-rc4-PARAM/drivers/scsi/arm/eesox.c
> --- linux-2.6.16-rc4/drivers/scsi/arm/eesox.c	2006-02-21 13:00:03.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/scsi/arm/eesox.c	2006-02-21 13:36:56.000000000 +1100
> @@ -674,6 +674,6 @@ module_exit(eesox_exit);
>  
>  MODULE_AUTHOR("Russell King");
>  MODULE_DESCRIPTION("EESOX 'Fast' SCSI driver for Acorn machines");
> -MODULE_PARM(term, "1-8i");
> +module_param_array(term, int, NULL, 0);
>  MODULE_PARM_DESC(term, "SCSI bus termination");
>  MODULE_LICENSE("GPL");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/scsi/arm/powertec.c working-2.6.16-rc4-PARAM/drivers/scsi/arm/powertec.c
> --- linux-2.6.16-rc4/drivers/scsi/arm/powertec.c	2006-02-21 13:00:03.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/scsi/arm/powertec.c	2006-02-21 13:36:59.000000000 +1100
> @@ -466,6 +466,6 @@ module_exit(powertecscsi_exit);
>  
>  MODULE_AUTHOR("Russell King");
>  MODULE_DESCRIPTION("Powertec SCSI driver");
> -MODULE_PARM(term, "1-8i");
> +module_param_array(term, int, NULL, 0);
>  MODULE_PARM_DESC(term, "SCSI bus termination");
>  MODULE_LICENSE("GPL");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/scsi/atari_scsi.c working-2.6.16-rc4-PARAM/drivers/scsi/atari_scsi.c
> --- linux-2.6.16-rc4/drivers/scsi/atari_scsi.c	2006-01-10 15:19:04.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/scsi/atari_scsi.c	2006-02-21 13:37:26.000000000 +1100
> @@ -239,17 +239,17 @@ static int atari_read_overruns = 0;
>  #endif
>  
>  static int setup_can_queue = -1;
> -MODULE_PARM(setup_can_queue, "i");
> +module_param(setup_can_queue, int, 0);
>  static int setup_cmd_per_lun = -1;
> -MODULE_PARM(setup_cmd_per_lun, "i");
> +module_param(setup_cmd_per_lun, int, 0);
>  static int setup_sg_tablesize = -1;
> -MODULE_PARM(setup_sg_tablesize, "i");
> +module_param(setup_sg_tablesize, int, 0);
>  #ifdef SUPPORT_TAGS
>  static int setup_use_tagged_queuing = -1;
> -MODULE_PARM(setup_use_tagged_queuing, "i");
> +module_param(setup_use_tagged_queuing, int, 0);
>  #endif
>  static int setup_hostid = -1;
> -MODULE_PARM(setup_hostid, "i");
> +module_param(setup_hostid, int, 0);
>  
>  
>  #if defined(CONFIG_TT_DMA_EMUL)
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/drivers/video/pm3fb.c working-2.6.16-rc4-PARAM/drivers/video/pm3fb.c
> --- linux-2.6.16-rc4/drivers/video/pm3fb.c	2006-02-21 13:00:23.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/drivers/video/pm3fb.c	2006-02-21 13:40:55.000000000 +1100
> @@ -3532,26 +3532,26 @@ int __init pm3fb_init(void)
>  MODULE_AUTHOR("Romain Dolbeau");
>  MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
>  static char *mode[PM3_MAX_BOARD];
> -MODULE_PARM(mode,PM3_MAX_BOARD_MODULE_ARRAY_STRING);
> +module_param_array(mode, charp, NULL, 0);
>  MODULE_PARM_DESC(mode,"video mode");
> -MODULE_PARM(disable,PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
> +module_param_array(disable, short, NULL, 0);
>  MODULE_PARM_DESC(disable,"disable board");
>  static short off[PM3_MAX_BOARD];
> -MODULE_PARM(off,PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
> +module_param_array(off, short, NULL, 0);
>  MODULE_PARM_DESC(off,"disable board");
>  static char *pciid[PM3_MAX_BOARD];
> -MODULE_PARM(pciid,PM3_MAX_BOARD_MODULE_ARRAY_STRING);
> +module_param_array(pciid, charp, NULL, 0);
>  MODULE_PARM_DESC(pciid,"board PCI Id");
> -MODULE_PARM(noaccel,PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
> +module_param_array(noaccel, short, NULL, 0);
>  MODULE_PARM_DESC(noaccel,"disable accel");
>  static char *font[PM3_MAX_BOARD];
> -MODULE_PARM(font,PM3_MAX_BOARD_MODULE_ARRAY_STRING);
> +module_param_array(font, charp, NULL, 0);
>  MODULE_PARM_DESC(font,"choose font");
> -MODULE_PARM(depth,PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
> +module_param(depth, short, NULL, 0);
>  MODULE_PARM_DESC(depth,"boot-time depth");
> -MODULE_PARM(printtimings, "h");
> +module_param(printtimings, short, NULL, 0);
>  MODULE_PARM_DESC(printtimings, "print the memory timings of the card(s)");
> -MODULE_PARM(forcesize, PM3_MAX_BOARD_MODULE_ARRAY_SHORT);
> +module_param(forcesize, short, NULL, 0);
>  MODULE_PARM_DESC(forcesize, "force specified memory size");
>  /*
>  MODULE_SUPPORTED_DEVICE("Permedia3 PCI boards")
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/include/linux/module.h working-2.6.16-rc4-PARAM/include/linux/module.h
> --- linux-2.6.16-rc4/include/linux/module.h	2006-01-10 15:19:50.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/include/linux/module.h	2006-02-21 13:42:08.000000000 +1100
> @@ -544,25 +544,6 @@ static inline void module_remove_driver(
>  
>  /* BELOW HERE ALL THESE ARE OBSOLETE AND WILL VANISH */
>  
> -struct obsolete_modparm {
> -	char name[64];
> -	char type[64-sizeof(void *)];
> -	void *addr;
> -};
> -
> -static inline void MODULE_PARM_(void) { }
> -#ifdef MODULE
> -/* DEPRECATED: Do not use. */
> -#define MODULE_PARM(var,type)						    \
> -extern struct obsolete_modparm __parm_##var \
> -__attribute__((section("__obsparm"))); \
> -struct obsolete_modparm __parm_##var = \
> -{ __stringify(var), type, &MODULE_PARM_ }; \
> -__MODULE_PARM_TYPE(var, type);
> -#else
> -#define MODULE_PARM(var,type) static void __attribute__((__unused__)) *__parm_##var = &MODULE_PARM_;
> -#endif
> -
>  #define __MODULE_STRING(x) __stringify(x)
>  
>  /* Use symbol_get and symbol_put instead.  You'll thank me. */
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/include/video/pm3fb.h working-2.6.16-rc4-PARAM/include/video/pm3fb.h
> --- linux-2.6.16-rc4/include/video/pm3fb.h	2005-10-31 12:21:21.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/include/video/pm3fb.h	2006-02-21 13:39:39.000000000 +1100
> @@ -1128,10 +1128,7 @@
>  #endif
>  
>  /* max number of simultaneous board */
> -/* warning : make sure module array def's are coherent with PM3_MAX_BOARD */
>  #define PM3_MAX_BOARD 4
> -#define PM3_MAX_BOARD_MODULE_ARRAY_SHORT "1-4h"
> -#define PM3_MAX_BOARD_MODULE_ARRAY_STRING "1-4s"
>  
>  /* max size of options */
>  #define PM3_OPTIONS_SIZE 256
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/init/Kconfig working-2.6.16-rc4-PARAM/init/Kconfig
> --- linux-2.6.16-rc4/init/Kconfig	2006-02-21 13:01:38.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/init/Kconfig	2006-02-21 13:54:54.000000000 +1100
> @@ -459,15 +459,6 @@ config MODULE_FORCE_UNLOAD
>  	  rmmod).  This is mainly for kernel developers and desperate users.
>  	  If unsure, say N.
>  
> -config OBSOLETE_MODPARM
> -	bool
> -	default y
> -	depends on MODULES
> -	help
> -	  You need this option to use module parameters on modules which
> -	  have not been converted to the new module parameter system yet.
> -	  If unsure, say Y.
> -
>  config MODVERSIONS
>  	bool "Module versioning support"
>  	depends on MODULES
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/kernel/module.c working-2.6.16-rc4-PARAM/kernel/module.c
> --- linux-2.6.16-rc4/kernel/module.c	2006-02-21 13:01:41.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/kernel/module.c	2006-02-21 14:05:04.000000000 +1100
> @@ -182,24 +182,6 @@ static unsigned long __find_symbol(const
>   	return 0;
>  }
>  
> -/* Find a symbol in this elf symbol table */
> -static unsigned long find_local_symbol(Elf_Shdr *sechdrs,
> -				       unsigned int symindex,
> -				       const char *strtab,
> -				       const char *name)
> -{
> -	unsigned int i;
> -	Elf_Sym *sym = (void *)sechdrs[symindex].sh_addr;
> -
> -	/* Search (defined) internal symbols first. */
> -	for (i = 1; i < sechdrs[symindex].sh_size/sizeof(*sym); i++) {
> -		if (sym[i].st_shndx != SHN_UNDEF
> -		    && strcmp(name, strtab + sym[i].st_name) == 0)
> -			return sym[i].st_value;
> -	}
> -	return 0;
> -}
> -
>  /* Search for module by name: must hold module_mutex. */
>  static struct module *find_module(const char *name)
>  {
> @@ -731,139 +713,6 @@ static inline void module_unload_init(st
>  }
>  #endif /* CONFIG_MODULE_UNLOAD */
>  
> -#ifdef CONFIG_OBSOLETE_MODPARM
> -/* Bounds checking done below */
> -static int obsparm_copy_string(const char *val, struct kernel_param *kp)
> -{
> -	strcpy(kp->arg, val);
> -	return 0;
> -}
> -
> -static int set_obsolete(const char *val, struct kernel_param *kp)
> -{
> -	unsigned int min, max;
> -	unsigned int size, maxsize;
> -	int dummy;
> -	char *endp;
> -	const char *p;
> -	struct obsolete_modparm *obsparm = kp->arg;
> -
> -	if (!val) {
> -		printk(KERN_ERR "Parameter %s needs an argument\n", kp->name);
> -		return -EINVAL;
> -	}
> -
> -	/* type is: [min[-max]]{b,h,i,l,s} */
> -	p = obsparm->type;
> -	min = simple_strtol(p, &endp, 10);
> -	if (endp == obsparm->type)
> -		min = max = 1;
> -	else if (*endp == '-') {
> -		p = endp+1;
> -		max = simple_strtol(p, &endp, 10);
> -	} else
> -		max = min;
> -	switch (*endp) {
> -	case 'b':
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   1, param_set_byte, &dummy);
> -	case 'h':
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   sizeof(short), param_set_short, &dummy);
> -	case 'i':
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   sizeof(int), param_set_int, &dummy);
> -	case 'l':
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   sizeof(long), param_set_long, &dummy);
> -	case 's':
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   sizeof(char *), param_set_charp, &dummy);
> -
> -	case 'c':
> -		/* Undocumented: 1-5c50 means 1-5 strings of up to 49 chars,
> -		   and the decl is "char xxx[5][50];" */
> -		p = endp+1;
> -		maxsize = simple_strtol(p, &endp, 10);
> -		/* We check lengths here (yes, this is a hack). */
> -		p = val;
> -		while (p[size = strcspn(p, ",")]) {
> -			if (size >= maxsize) 
> -				goto oversize;
> -			p += size+1;
> -		}
> -		if (size >= maxsize) 
> -			goto oversize;
> -		return param_array(kp->name, val, min, max, obsparm->addr,
> -				   maxsize, obsparm_copy_string, &dummy);
> -	}
> -	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
> -	return -EINVAL;
> - oversize:
> -	printk(KERN_ERR
> -	       "Parameter %s doesn't fit in %u chars.\n", kp->name, maxsize);
> -	return -EINVAL;
> -}
> -
> -static int obsolete_params(const char *name,
> -			   char *args,
> -			   struct obsolete_modparm obsparm[],
> -			   unsigned int num,
> -			   Elf_Shdr *sechdrs,
> -			   unsigned int symindex,
> -			   const char *strtab)
> -{
> -	struct kernel_param *kp;
> -	unsigned int i;
> -	int ret;
> -
> -	kp = kmalloc(sizeof(kp[0]) * num, GFP_KERNEL);
> -	if (!kp)
> -		return -ENOMEM;
> -
> -	for (i = 0; i < num; i++) {
> -		char sym_name[128 + sizeof(MODULE_SYMBOL_PREFIX)];
> -
> -		snprintf(sym_name, sizeof(sym_name), "%s%s",
> -			 MODULE_SYMBOL_PREFIX, obsparm[i].name);
> -
> -		kp[i].name = obsparm[i].name;
> -		kp[i].perm = 000;
> -		kp[i].set = set_obsolete;
> -		kp[i].get = NULL;
> -		obsparm[i].addr
> -			= (void *)find_local_symbol(sechdrs, symindex, strtab,
> -						    sym_name);
> -		if (!obsparm[i].addr) {
> -			printk("%s: falsely claims to have parameter %s\n",
> -			       name, obsparm[i].name);
> -			ret = -EINVAL;
> -			goto out;
> -		}
> -		kp[i].arg = &obsparm[i];
> -	}
> -
> -	ret = parse_args(name, args, kp, num, NULL);
> - out:
> -	kfree(kp);
> -	return ret;
> -}
> -#else
> -static int obsolete_params(const char *name,
> -			   char *args,
> -			   struct obsolete_modparm obsparm[],
> -			   unsigned int num,
> -			   Elf_Shdr *sechdrs,
> -			   unsigned int symindex,
> -			   const char *strtab)
> -{
> -	if (num != 0)
> -		printk(KERN_WARNING "%s: Ignoring obsolete parameters\n",
> -		       name);
> -	return 0;
> -}
> -#endif /* CONFIG_OBSOLETE_MODPARM */
> -
>  static const char vermagic[] = VERMAGIC_STRING;
>  
>  #ifdef CONFIG_MODVERSIONS
> @@ -1847,27 +1696,17 @@ static struct module *load_module(void _
>  	set_fs(old_fs);
>  
>  	mod->args = args;
> -	if (obsparmindex) {
> -		err = obsolete_params(mod->name, mod->args,
> -				      (struct obsolete_modparm *)
> -				      sechdrs[obsparmindex].sh_addr,
> -				      sechdrs[obsparmindex].sh_size
> -				      / sizeof(struct obsolete_modparm),
> -				      sechdrs, symindex,
> -				      (char *)sechdrs[strindex].sh_addr);
> -		if (setupindex)
> -			printk(KERN_WARNING "%s: Ignoring new-style "
> -			       "parameters in presence of obsolete ones\n",
> -			       mod->name);
> -	} else {
> -		/* Size of section 0 is 0, so this works well if no params */
> -		err = parse_args(mod->name, mod->args,
> -				 (struct kernel_param *)
> -				 sechdrs[setupindex].sh_addr,
> -				 sechdrs[setupindex].sh_size
> -				 / sizeof(struct kernel_param),
> -				 NULL);
> -	}
> +	if (obsparmindex)
> +		printk(KERN_WARNING "%s: Ignoring obsolete parameters\n",
> +		       mod->name);
> +
> +	/* Size of section 0 is 0, so this works well if no params */
> +	err = parse_args(mod->name, mod->args,
> +			 (struct kernel_param *)
> +			 sechdrs[setupindex].sh_addr,
> +			 sechdrs[setupindex].sh_size
> +			 / sizeof(struct kernel_param),
> +			 NULL);
>  	if (err < 0)
>  		goto arch_cleanup;
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/kernel/rcutorture.c working-2.6.16-rc4-PARAM/kernel/rcutorture.c
> --- linux-2.6.16-rc4/kernel/rcutorture.c	2006-02-21 13:01:41.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/kernel/rcutorture.c	2006-02-21 13:43:13.000000000 +1100
> @@ -54,15 +54,15 @@ static int verbose;		/* Print more debug
>  static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
>  static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
>  
> -MODULE_PARM(nreaders, "i");
> +module_param(nreaders, int, 0);
>  MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
> -MODULE_PARM(stat_interval, "i");
> +module_param(stat_interval, int, 0);
>  MODULE_PARM_DESC(stat_interval, "Number of seconds between stats printk()s");
> -MODULE_PARM(verbose, "i");
> +module_param(verbose, bool, 0);
>  MODULE_PARM_DESC(verbose, "Enable verbose debugging printk()s");
> -MODULE_PARM(test_no_idle_hz, "i");
> +module_param(test_no_idle_hz, bool, 0);
>  MODULE_PARM_DESC(test_no_idle_hz, "Test support for tickless idle CPUs");
> -MODULE_PARM(shuffle_interval, "i");
> +module_param(shuffle_interval, int, 0);
>  MODULE_PARM_DESC(shuffle_interval, "Number of seconds between shuffles");
>  #define TORTURE_FLAG "rcutorture: "
>  #define PRINTK_STRING(s) \
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/au1000.c working-2.6.16-rc4-PARAM/sound/oss/au1000.c
> --- linux-2.6.16-rc4/sound/oss/au1000.c	2006-01-10 15:20:11.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/sound/oss/au1000.c	2006-02-21 13:43:52.000000000 +1100
> @@ -98,7 +98,7 @@
>  
>  /* Boot options */
>  static int      vra = 0;	// 0 = no VRA, 1 = use VRA if codec supports it
> -MODULE_PARM(vra, "i");
> +module_param(vra, bool, 0);
>  MODULE_PARM_DESC(vra, "if 1 use VRA if codec supports it");
>  
>  
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/au1550_ac97.c working-2.6.16-rc4-PARAM/sound/oss/au1550_ac97.c
> --- linux-2.6.16-rc4/sound/oss/au1550_ac97.c	2006-02-21 13:02:29.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/sound/oss/au1550_ac97.c	2006-02-21 13:46:07.000000000 +1100
> @@ -77,7 +77,7 @@
>   * 0 = no VRA, 1 = use VRA if codec supports it
>   */
>  static int      vra = 1;
> -MODULE_PARM(vra, "i");
> +module_param(vra, bool, 0);
>  MODULE_PARM_DESC(vra, "if 1 use VRA if codec supports it");
>  
>  static struct au1550_state {
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/dmasound/dmasound_core.c working-2.6.16-rc4-PARAM/sound/oss/dmasound/dmasound_core.c
> --- linux-2.6.16-rc4/sound/oss/dmasound/dmasound_core.c	2005-02-04 18:48:27.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/sound/oss/dmasound/dmasound_core.c	2006-02-21 13:43:42.000000000 +1100
> @@ -195,18 +195,18 @@
>       */
>  
>  int dmasound_catchRadius = 0;
> -MODULE_PARM(dmasound_catchRadius, "i");
> +module_param(dmasound_catchRadius, int, 0);
>  
>  static unsigned int numWriteBufs = DEFAULT_N_BUFFERS;
> -MODULE_PARM(numWriteBufs, "i");
> +module_param(numWriteBufs, int, 0);
>  static unsigned int writeBufSize = DEFAULT_BUFF_SIZE ;	/* in bytes */
> -MODULE_PARM(writeBufSize, "i");
> +module_param(writeBufSize, int, 0);
>  
>  #ifdef HAS_RECORD
>  static unsigned int numReadBufs = DEFAULT_N_BUFFERS;
> -MODULE_PARM(numReadBufs, "i");
> +module_param(numReadBufs, int, 0);
>  static unsigned int readBufSize = DEFAULT_BUFF_SIZE;	/* in bytes */
> -MODULE_PARM(readBufSize, "i");
> +module_param(readBufSize, int, 0);
>  #endif
>  
>  MODULE_LICENSE("GPL");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/ite8172.c working-2.6.16-rc4-PARAM/sound/oss/ite8172.c
> --- linux-2.6.16-rc4/sound/oss/ite8172.c	2006-02-21 13:02:32.000000000 +1100
> +++ working-2.6.16-rc4-PARAM/sound/oss/ite8172.c	2006-02-21 13:44:31.000000000 +1100
> @@ -1966,9 +1966,9 @@ static int i2s_fmt[NR_DEVICE];
>  
>  static unsigned int devindex;
>  
> -MODULE_PARM(spdif, "1-" __MODULE_STRING(NR_DEVICE) "i");
> +module_param_array(spdif, int, NULL, 0);
>  MODULE_PARM_DESC(spdif, "if 1 the S/PDIF digital output is enabled");
> -MODULE_PARM(i2s_fmt, "1-" __MODULE_STRING(NR_DEVICE) "i");
> +module_param_array(i2s_fmt, int, NULL, 0);
>  MODULE_PARM_DESC(i2s_fmt, "the format of I2S");
>  
>  MODULE_AUTHOR("Monta Vista Software, stevel@mvista.com");
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/swarm_cs4297a.c working-2.6.16-rc4-PARAM/sound/oss/swarm_cs4297a.c
> --- linux-2.6.16-rc4/sound/oss/swarm_cs4297a.c	2005-05-25 13:49:32.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/sound/oss/swarm_cs4297a.c	2006-02-21 13:45:16.000000000 +1100
> @@ -153,8 +153,8 @@ static void start_adc(struct cs4297a_sta
>  #if CSDEBUG
>  static unsigned long cs_debuglevel = 4;	// levels range from 1-9
>  static unsigned long cs_debugmask = CS_INIT /*| CS_IOCTL*/;
> -MODULE_PARM(cs_debuglevel, "i");
> -MODULE_PARM(cs_debugmask, "i");
> +module_param(cs_debuglevel, int, 0);
> +module_param(cs_debugmask, int, 0);
>  #endif
>  #define CS_TRUE 	1
>  #define CS_FALSE 	0
> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.16-rc4/sound/oss/waveartist.c working-2.6.16-rc4-PARAM/sound/oss/waveartist.c
> --- linux-2.6.16-rc4/sound/oss/waveartist.c	2005-05-25 13:49:32.000000000 +1000
> +++ working-2.6.16-rc4-PARAM/sound/oss/waveartist.c	2006-02-21 13:46:00.000000000 +1100
> @@ -2028,8 +2028,8 @@ __setup("waveartist=", setup_waveartist)
>  #endif
>  
>  MODULE_DESCRIPTION("Rockwell WaveArtist RWA-010 sound driver");
> -MODULE_PARM(io, "i");		/* IO base */
> -MODULE_PARM(irq, "i");		/* IRQ */
> -MODULE_PARM(dma, "i");		/* DMA */
> -MODULE_PARM(dma2, "i");		/* DMA2 */
> +module_param(io, int, 0);		/* IO base */
> +module_param(irq, int, 0);		/* IRQ */
> +module_param(dma, int, 0);		/* DMA */
> +module_param(dma2, int, 0);		/* DMA2 */
>  MODULE_LICENSE("GPL");
> 
> -- 
>  ccontrol: http://ozlabs.org/~rusty/ccontrol
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
