Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263646AbUBDSaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 13:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUBDSaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 13:30:09 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:26240 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id S263646AbUBDS1n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 13:27:43 -0500
From: David Ronis <ronis@ronispc.chem.mcgill.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16417.14736.420280.796948@ronispc.chem.mcgill.ca>
Date: Wed, 4 Feb 2004 13:27:28 -0500
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
Cc: linux-kernel@vger.kernel.org
CC: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Problem with module-init-tools-3.0-pre3
In-Reply-To: <20040130073540.GA17435@linux-buechse.de>
References: <16409.11897.539398.14955@ronispc.chem.mcgill.ca>
	<20040130040158.4785D2C002@lists.samba.org>
	<20040130073540.GA17435@linux-buechse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: david.ronis@mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just built 2.6.2 and tried the scsi driver install/remove problem I
wrote about earlier (if, I manually remove the sg and aha152x modules with modprobe, I get an oops the next time they are used).  The problem is still present.

Here's what's in syslog:

Feb  4 13:16:16 ronispc kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000708
Feb  4 13:16:16 ronispc kernel:  printing eip:
Feb  4 13:16:16 ronispc kernel: c0162a50
Feb  4 13:16:16 ronispc kernel: *pde = 00000000
Feb  4 13:16:16 ronispc kernel: Oops: 0000 [#1]
Feb  4 13:16:16 ronispc kernel: CPU:    1
Feb  4 13:16:16 ronispc kernel: EIP:    0060:[<c0162a50>]    Not tainted
Feb  4 13:16:16 ronispc kernel: EFLAGS: 00010202
Feb  4 13:16:16 ronispc kernel: EIP is at cdev_get+0x20/0xb0
Feb  4 13:16:16 ronispc kernel: eax: e8736000   ebx: 00000708   ecx: 00000015   edx: e8737f28
Feb  4 13:16:16 ronispc kernel: esi: f739fb60   edi: 00000001   ebp: f739fb60   esp: e8737ed8
Feb  4 13:16:16 ronispc kernel: ds: 007b   es: 007b   ss: 0068
Feb  4 13:16:16 ronispc kernel: Process xsane (pid: 1629, threadinfo=e8736000 task=f1c5ccc0)
Feb  4 13:16:16 ronispc kernel: Stack: c0130185 ebbaa660 e8736000 00000000 c016293f f739fb60 c01ecf89 01500000 
Feb  4 13:16:16 ronispc kernel:        f739fb60 00000006 c0162920 00000000 e8736000 00000000 00000000 00000000 
Feb  4 13:16:16 ronispc kernel:        c0162767 f7fe2c00 01500000 e8737f28 00000000 e9e84da0 ea9802d4 00000001 
Feb  4 13:16:16 ronispc kernel: Call Trace:
Feb  4 13:16:16 ronispc kernel:  [<c0130185>] in_group_p+0x25/0x30
Feb  4 13:16:16 ronispc kernel:  [<c016293f>] exact_lock+0xf/0x20
Feb  4 13:16:16 ronispc kernel:  [<c01ecf89>] kobj_lookup+0x119/0x200
Feb  4 13:16:16 ronispc kernel:  [<c0162920>] exact_match+0x0/0x10
Feb  4 13:16:16 ronispc kernel:  [<c0162767>] chrdev_open+0x1e7/0x290
Feb  4 13:16:16 ronispc kernel:  [<c01576e0>] dentry_open+0x160/0x230
Feb  4 13:16:16 ronispc kernel:  [<c0157578>] filp_open+0x68/0x70
Feb  4 13:16:16 ronispc kernel:  [<c0157aeb>] sys_open+0x5b/0x90
Feb  4 13:16:16 ronispc kernel:  [<c01092ab>] syscall_call+0x7/0xb
Feb  4 13:16:16 ronispc kernel: 
Feb  4 13:16:16 ronispc kernel: Code: 83 3b 02 8b 40 10 74 7f c1 e0 05 8d 04 18 ff 80 a0 00 00 00 
Feb  4 13:16:16 ronispc kernel:  <6>note: xsane[1629] exited with preempt_count 1
Feb  4 13:16:16 ronispc kernel: bad: scheduling while atomic!
Feb  4 13:16:16 ronispc kernel: Call Trace:
Feb  4 13:16:16 ronispc kernel:  [<c011b8a1>] schedule+0x6e1/0x6f0
Feb  4 13:16:16 ronispc kernel:  [<c0153698>] free_pages_and_swap_cache+0x68/0xa0
Feb  4 13:16:16 ronispc kernel:  [<c0148db1>] unmap_vmas+0x241/0x2f0
Feb  4 13:16:16 ronispc kernel:  [<c014d1d9>] exit_mmap+0xe9/0x240
Feb  4 13:16:16 ronispc kernel:  [<c011e0b0>] mmput+0x70/0xd0
Feb  4 13:16:16 ronispc kernel:  [<c012290b>] do_exit+0x18b/0x500
Feb  4 13:16:16 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 13:16:16 ronispc kernel:  [<c010a3c5>] die+0xf5/0x100
Feb  4 13:16:16 ronispc kernel:  [<c01188ce>] do_page_fault+0x1de/0x530
Feb  4 13:16:16 ronispc kernel:  [<c01a3e81>] journal_stop+0x201/0x310
Feb  4 13:16:16 ronispc kernel:  [<c0171441>] dput+0x31/0x270
Feb  4 13:16:16 ronispc kernel:  [<c0167f14>] link_path_walk+0x694/0x9f0
Feb  4 13:16:16 ronispc kernel:  [<c01186f0>] do_page_fault+0x0/0x530
Feb  4 13:16:16 ronispc kernel:  [<c0109d15>] error_code+0x2d/0x38
Feb  4 13:16:16 ronispc kernel:  [<c0162a50>] cdev_get+0x20/0xb0
Feb  4 13:16:16 ronispc kernel:  [<c0130185>] in_group_p+0x25/0x30
Feb  4 13:16:16 ronispc kernel:  [<c016293f>] exact_lock+0xf/0x20
Feb  4 13:16:16 ronispc kernel:  [<c01ecf89>] kobj_lookup+0x119/0x200
Feb  4 13:16:16 ronispc kernel:  [<c0162920>] exact_match+0x0/0x10
Feb  4 13:16:16 ronispc kernel:  [<c0162767>] chrdev_open+0x1e7/0x290
Feb  4 13:16:16 ronispc kernel:  [<c01576e0>] dentry_open+0x160/0x230
Feb  4 13:16:16 ronispc kernel:  [<c0157578>] filp_open+0x68/0x70
Feb  4 13:16:16 ronispc kernel:  [<c0157aeb>] sys_open+0x5b/0x90
Feb  4 13:16:16 ronispc kernel:  [<c01092ab>] syscall_call+0x7/0xb

One other thing I noticed; after the oops, lsmod didn't show either sg
or aha152x as being installed.  Is it possible that the kernel still
thinks they were?

David

Juergen E. Fischer writes:
 > Hi,
 > 
 > On Fri, Jan 30, 2004 at 14:29:59 +1100, Rusty Russell wrote:
 > > Looks like aha152x or sd is not cleaning up properly, and when
 > > reinserted, something screws up.
 > 
 > I guess that's without the pending patch.  If it's aha152x, the patch
 > might also do some good in that departement.
 > 
 > 
 > Jürgen
 > 
 > -- 
 > A: No.
 > Q: Should I include quotations after my reply?
 > diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/aha152x.c linux-2.6.2-rc2/drivers/scsi/aha152x.c
 > --- orig/linux-2.6.2-rc2/drivers/scsi/aha152x.c	2004-01-24 11:54:43.000000000 +0100
 > +++ linux-2.6.2-rc2/drivers/scsi/aha152x.c	2004-01-30 08:21:54.000000000 +0100
 > @@ -1,6 +1,6 @@
 >  /* aha152x.c -- Adaptec AHA-152x driver
 >   * Author: Jürgen E. Fischer, fischer@norbit.de
 > - * Copyright 1993-2000 Jürgen E. Fischer
 > + * Copyright 1993-2004 Jürgen E. Fischer
 >   *
 >   * This program is free software; you can redistribute it and/or modify it
 >   * under the terms of the GNU General Public License as published by the
 > @@ -13,9 +13,17 @@
 >   * General Public License for more details.
 >   *
 >   *
 > - * $Id: aha152x.c,v 2.6 2003/10/30 20:52:47 fischer Exp $
 > + * $Id: aha152x.c,v 2.7 2004/01/24 11:42:59 fischer Exp $
 >   *
 >   * $Log: aha152x.c,v $
 > + * Revision 2.7  2004/01/24 11:42:59  fischer
 > + * - gather code that is not used by PCMCIA at the end
 > + * - move request_region for !PCMCIA case to detection
 > + * - migration to new scsi host api (remove legacy code)
 > + * - free host scribble before scsi_done
 > + * - fix error handling
 > + * - one isapnp device added to id_table
 > + *
 >   * Revision 2.6  2003/10/30 20:52:47  fischer
 >   * - interfaces changes for kernel 2.6
 >   * - aha152x_probe_one introduced for pcmcia stub
 > @@ -344,7 +352,8 @@ MODULE_AUTHOR("Jürgen Fischer");
 >  MODULE_DESCRIPTION(AHA152X_REVID);
 >  MODULE_LICENSE("GPL");
 >  
 > -#if defined(MODULE) && !defined(PCMCIA)
 > +#if !defined(PCMCIA)
 > +#if defined(MODULE)
 >  MODULE_PARM(io, "1-2i");
 >  MODULE_PARM_DESC(io,"base io address of controller");
 >  static int io[] = {0, 0};
 > @@ -398,21 +407,23 @@ MODULE_PARM(aha152x1, "1-9i");
 >  MODULE_PARM_DESC(aha152x1, "parameters for second controller");
 >  static int aha152x1[]  = {0, 11, 7, 1, 1, 1, DELAY_DEFAULT, 0, DEBUG_DEFAULT};
 >  #endif /* !defined(AHA152X_DEBUG) */
 > -#endif /* MODULE && !PCMCIA */
 > +#endif /* MODULE */
 >  
 >  #ifdef __ISAPNP__
 >  static struct isapnp_device_id id_table[] __devinitdata = {
 > -	{ ISAPNP_DEVICE_SINGLE('A','D','P',0x1505, 'A','D','P',0x1505), },
 > +	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 > +		ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), 0 },
 > +	{ ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 > +		ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1530), 0 },
 >  	{ ISAPNP_DEVICE_SINGLE_END, }
 >  };
 >  MODULE_DEVICE_TABLE(isapnp, id_table);
 >  #endif /* ISAPNP */
 >  
 > -/* set by aha152x_setup according to the command line */
 > -static int setup_count;
 > -static int registered_count;
 > -static struct aha152x_setup setup[2];
 > -static struct Scsi_Host *aha152x_host[2];
 > +#endif /* !PCMCIA */
 > +
 > +static int registered_count=0;
 > +static struct Scsi_Host *aha152x_host[2] = {0, 0};
 >  static Scsi_Host_Template aha152x_driver_template;
 >  
 >  /*
 > @@ -658,7 +669,6 @@ static irqreturn_t intr(int irq, void *d
 >  static void reset_ports(struct Scsi_Host *shpnt);
 >  static void aha152x_error(struct Scsi_Host *shpnt, char *msg);
 >  static void done(struct Scsi_Host *shpnt, int error);
 > -static int checksetup(struct aha152x_setup *setup);
 >  
 >  /* diagnostics */
 >  static void disp_ports(struct Scsi_Host *shpnt);
 > @@ -666,66 +676,6 @@ static void show_command(Scsi_Cmnd * ptr
 >  static void show_queues(struct Scsi_Host *shpnt);
 >  static void disp_enintr(struct Scsi_Host *shpnt);
 >  
 > -/* possible i/o addresses for the AIC-6260; default first */
 > -static unsigned short ports[] = { 0x340, 0x140 };
 > -
 > -#if !defined(SKIP_BIOSTEST)
 > -/* possible locations for the Adaptec BIOS; defaults first */
 > -static unsigned int addresses[] =
 > -{
 > -	0xdc000,		/* default first */
 > -	0xc8000,
 > -	0xcc000,
 > -	0xd0000,
 > -	0xd4000,
 > -	0xd8000,
 > -	0xe0000,
 > -	0xeb800,		/* VTech Platinum SMP */
 > -	0xf0000,
 > -};
 > -
 > -/* signatures for various AIC-6[23]60 based controllers.
 > -   The point in detecting signatures is to avoid useless and maybe
 > -   harmful probes on ports. I'm not sure that all listed boards pass
 > -   auto-configuration. For those which fail the BIOS signature is
 > -   obsolete, because user intervention to supply the configuration is
 > -   needed anyway.  May be an information whether or not the BIOS supports
 > -   extended translation could be also useful here. */
 > -static struct signature {
 > -	unsigned char *signature;
 > -	int sig_offset;
 > -	int sig_length;
 > -} signatures[] =
 > -{
 > -	{ "Adaptec AHA-1520 BIOS",	0x102e, 21 },
 > -		/* Adaptec 152x */
 > -	{ "Adaptec AHA-1520B",		0x000b, 17 },
 > -		/* Adaptec 152x rev B */
 > -	{ "Adaptec AHA-1520B",		0x0026, 17 },
 > -		/* Iomega Jaz Jet ISA (AIC6370Q) */
 > -	{ "Adaptec ASW-B626 BIOS",	0x1029, 21 },
 > -		/* on-board controller */
 > -	{ "Adaptec BIOS: ASW-B626",	0x000f, 22 },
 > -		/* on-board controller */
 > -	{ "Adaptec ASW-B626 S2",	0x2e6c, 19 },
 > -		/* on-board controller */
 > -	{ "Adaptec BIOS:AIC-6360",	0x000c, 21 },
 > -		/* on-board controller */
 > -	{ "ScsiPro SP-360 BIOS",	0x2873, 19 },
 > -		/* ScsiPro-Controller  */
 > -	{ "GA-400 LOCAL BUS SCSI BIOS", 0x102e, 26 },
 > -		/* Gigabyte Local-Bus-SCSI */
 > -	{ "Adaptec BIOS:AVA-282X",	0x000c, 21 },
 > -		/* Adaptec 282x */
 > -	{ "Adaptec IBM Dock II SCSI",	0x2edd, 24 },
 > -		/* IBM Thinkpad Dock II */
 > -	{ "Adaptec BIOS:AHA-1532P",	0x001c, 22 },
 > -		/* IBM Thinkpad Dock II SCSI */
 > -	{ "DTC3520A Host Adapter BIOS", 0x318a, 26 },
 > -		/* DTC 3520A ISA SCSI */
 > -};
 > -#endif
 > -
 >  
 >  /*
 >   *  queue services:
 > @@ -799,141 +749,6 @@ static inline Scsi_Cmnd *remove_SC(Scsi_
 >  	return ptr;
 >  }
 >  
 > -#if defined(PCMCIA) || !defined(MODULE)
 > -static void aha152x_setup(char *str, int *ints)
 > -{
 > -	if(setup_count>=ARRAY_SIZE(setup)) {
 > -		printk(KERN_ERR "aha152x: you can only configure up to two controllers\n");
 > -		return;
 > -	}
 > -
 > -	setup[setup_count].conf        = str;
 > -	setup[setup_count].io_port     = ints[0] >= 1 ? ints[1] : 0x340;
 > -	setup[setup_count].irq         = ints[0] >= 2 ? ints[2] : 11;
 > -	setup[setup_count].scsiid      = ints[0] >= 3 ? ints[3] : 7;
 > -	setup[setup_count].reconnect   = ints[0] >= 4 ? ints[4] : 1;
 > -	setup[setup_count].parity      = ints[0] >= 5 ? ints[5] : 1;
 > -	setup[setup_count].synchronous = ints[0] >= 6 ? ints[6] : 1;
 > -	setup[setup_count].delay       = ints[0] >= 7 ? ints[7] : DELAY_DEFAULT;
 > -	setup[setup_count].ext_trans   = ints[0] >= 8 ? ints[8] : 0;
 > -#if defined(AHA152X_DEBUG)
 > -	setup[setup_count].debug       = ints[0] >= 9 ? ints[9] : DEBUG_DEFAULT;
 > -	if (ints[0] > 9) {
 > -		printk(KERN_NOTICE "aha152x: usage: aha152x=<IOBASE>[,<IRQ>[,<SCSI ID>"
 > -		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>[,<DEBUG>]]]]]]]]\n");
 > -#else
 > -	if (ints[0] > 8) {                                                /*}*/
 > -		printk(KERN_NOTICE "aha152x: usage: aha152x=<IOBASE>[,<IRQ>[,<SCSI ID>"
 > -		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>]]]]]]]\n");
 > -#endif
 > -	} else {
 > -		setup_count++;
 > -	}
 > -}
 > -#endif
 > -
 > -#if !defined(MODULE)
 > -static int __init do_setup(char *str)
 > -{
 > -
 > -#if defined(AHA152X_DEBUG)
 > -	int ints[11];
 > -#else
 > -	int ints[10];
 > -#endif
 > -	int count=setup_count;
 > -
 > -	get_options(str, ARRAY_SIZE(ints), ints);
 > -	aha152x_setup(str,ints);
 > -
 > -	return count<setup_count;
 > -}
 > -
 > -__setup("aha152x=", do_setup);
 > -#endif
 > -
 > -/*
 > - * Test, if port_base is valid.
 > - *
 > - */
 > -static int aha152x_porttest(int io_port)
 > -{
 > -	int i;
 > -
 > -	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
 > -	for (i = 0; i < 16; i++)
 > -		SETPORT(io_port + O_STACK, i);
 > -
 > -	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
 > -	for (i = 0; i < 16 && GETPORT(io_port + O_STACK) == i; i++)
 > -		;
 > -
 > -	return (i == 16);
 > -}
 > -
 > -static int tc1550_porttest(int io_port)
 > -{
 > -	int i;
 > -
 > -	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
 > -	for (i = 0; i < 16; i++)
 > -		SETPORT(io_port + O_STACK, i);
 > -
 > -	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
 > -	for (i = 0; i < 16 && GETPORT(io_port + O_TC_STACK) == i; i++)
 > -		;
 > -
 > -	return (i == 16);
 > -}
 > -
 > -static int checksetup(struct aha152x_setup *setup)
 > -{
 > -
 > -#if !defined(PCMCIA)
 > -	int i;
 > -	for (i = 0; i < ARRAY_SIZE(ports) && (setup->io_port != ports[i]); i++)
 > -		;
 > -
 > -	if (i == ARRAY_SIZE(ports))
 > -		return 0;
 > -#endif
 > -	if (!request_region(setup->io_port, IO_RANGE, "aha152x"))
 > -		return 0;
 > -
 > -	if(aha152x_porttest(setup->io_port)) {
 > -		setup->tc1550=0;
 > -        } else if(tc1550_porttest(setup->io_port)) {
 > -		setup->tc1550=1;
 > -	} else {
 > -		release_region(setup->io_port, IO_RANGE);
 > -		return 0;
 > -	}
 > -
 > -	release_region(setup->io_port, IO_RANGE);
 > -
 > -
 > -	if ((setup->irq < IRQ_MIN) || (setup->irq > IRQ_MAX))
 > -		return 0;
 > -
 > -	if ((setup->scsiid < 0) || (setup->scsiid > 7))
 > -		return 0;
 > -
 > -	if ((setup->reconnect < 0) || (setup->reconnect > 1))
 > -		return 0;
 > -
 > -	if ((setup->parity < 0) || (setup->parity > 1))
 > -		return 0;
 > -
 > -	if ((setup->synchronous < 0) || (setup->synchronous > 1))
 > -		return 0;
 > -
 > -	if ((setup->ext_trans < 0) || (setup->ext_trans > 1))
 > -		return 0;
 > -
 > -
 > -	return 1;
 > -}
 > -
 >  static inline struct Scsi_Host *lookup_irq(int irqno)
 >  {
 >  	int i;
 > @@ -950,7 +765,6 @@ static irqreturn_t swintr(int irqno, voi
 >  	struct Scsi_Host *shpnt = lookup_irq(irqno);
 >  
 >  	if (!shpnt) {
 > -		/* no point using HOSTNO here! */
 >          	printk(KERN_ERR "aha152x: catched software interrupt %d for unknown controller.\n", irqno);
 >  		return IRQ_NONE;
 >  	}
 > @@ -961,17 +775,19 @@ static irqreturn_t swintr(int irqno, voi
 >  	return IRQ_HANDLED;
 >  }
 >  
 > -
 >  struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *setup)
 >  {
 >  	struct Scsi_Host *shpnt;
 >  
 >  	shpnt = scsi_host_alloc(&aha152x_driver_template, sizeof(struct aha152x_hostdata));
 >  	if (!shpnt) {
 > -		printk(KERN_ERR "aha152x: scsi_register failed\n");
 > +		printk(KERN_ERR "aha152x: scsi_host_alloc failed\n");
 >  		return NULL;
 >  	}
 >  
 > +	/* need to have host registered before triggering any interrupt */
 > +	aha152x_host[registered_count] = shpnt;
 > +
 >  	memset(HOSTDATA(shpnt), 0, sizeof *HOSTDATA(shpnt));
 >  
 >  	shpnt->io_port   = setup->io_port;
 > @@ -1034,24 +850,19 @@ struct Scsi_Host *aha152x_probe_one(stru
 >  	       DELAY,
 >  	       EXT_TRANS ? "enabled" : "disabled");
 >  
 > -	if (!request_region(shpnt->io_port, IO_RANGE, "aha152x"))
 > -		goto out_unregister;
 > -
 >  	/* not expecting any interrupts */
 >  	SETPORT(SIMODE0, 0);
 >  	SETPORT(SIMODE1, 0);
 >  
 > -	if (request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) < 0) {
 > -		printk(KERN_ERR "aha152x%d: driver needs an IRQ.\n", shpnt->host_no);
 > -		goto out_release_region;
 > +	if( request_irq(shpnt->irq, swintr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) ) {
 > +		printk(KERN_ERR "aha152x%d: irq %d busy.\n", shpnt->host_no, shpnt->irq);
 > +		goto out_host_put;
 >  	}
 >  
 >  	HOSTDATA(shpnt)->swint = 0;
 >  
 >  	printk(KERN_INFO "aha152x%d: trying software interrupt, ", shpnt->host_no);
 >  
 > -	/* need to have host registered before triggering any interrupt */
 > -	aha152x_host[registered_count] = shpnt;
 >  	mb();
 >  	SETPORT(DMACNTRL0, SWINT|INTEN);
 >  	mdelay(1000);
 > @@ -1066,9 +877,9 @@ struct Scsi_Host *aha152x_probe_one(stru
 >  
 >  		SETPORT(DMACNTRL0, INTEN);
 >  
 > -		printk(KERN_ERR "aha152x%d: IRQ %d possibly wrong.  "
 > +		printk(KERN_ERR "aha152x%d: irq %d possibly wrong.  "
 >  				"Please verify.\n", shpnt->host_no, shpnt->irq);
 > -		goto out_unregister_host;
 > +		goto out_host_put;
 >  	}
 >  	printk("ok.\n");
 >  
 > @@ -1077,322 +888,50 @@ struct Scsi_Host *aha152x_probe_one(stru
 >  	SETPORT(SSTAT0, 0x7f);
 >  	SETPORT(SSTAT1, 0xef);
 >  
 > -	if (request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) < 0) {
 > -		printk(KERN_ERR "aha152x%d: failed to reassign interrupt.\n", shpnt->host_no);
 > -		goto out_unregister_host;
 > -	}
 > -
 > -	scsi_add_host(shpnt, 0);
 > -	scsi_scan_host(shpnt);
 > -	return shpnt;	/* the pcmcia stub needs the return value; */
 > -
 > -out_unregister_host:
 > -	aha152x_host[registered_count] = NULL;
 > -out_release_region:
 > -	release_region(shpnt->io_port, IO_RANGE);
 > -out_unregister:
 > -	scsi_host_put(shpnt);
 > -	return NULL;
 > -}
 > -
 > -static int __init aha152x_init(void)
 > -{
 > -	int i, j, ok;
 > -#if defined(AUTOCONF)
 > -	aha152x_config conf;
 > -#endif
 > -#ifdef __ISAPNP__
 > -	struct pnp_dev *dev=0, *pnpdev[2] = {0, 0};
 > -#endif
 > -
 > -	if (setup_count) {
 > -		printk(KERN_INFO "aha152x: processing commandline: ");
 > -
 > -		for (i = 0; i < setup_count; i++)
 > -			if (!checksetup(&setup[i])) {
 > -				printk(KERN_ERR "\naha152x: %s\n", setup[i].conf);
 > -				printk(KERN_ERR "aha152x: invalid line\n");
 > -			}
 > -		printk("ok\n");
 > -	}
 > -
 > -#if defined(SETUP0)
 > -	if (setup_count < ARRAY_SIZE(setup)) {
 > -		struct aha152x_setup override = SETUP0;
 > -
 > -		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
 > -			if (!checksetup(&override)) {
 > -				printk(KERN_ERR "\naha152x: invalid override SETUP0={0x%x,%d,%d,%d,%d,%d,%d,%d}\n",
 > -				       override.io_port,
 > -				       override.irq,
 > -				       override.scsiid,
 > -				       override.reconnect,
 > -				       override.parity,
 > -				       override.synchronous,
 > -				       override.delay,
 > -				       override.ext_trans);
 > -			} else
 > -				setup[setup_count++] = override;
 > -		}
 > -	}
 > -#endif
 > -
 > -#if defined(SETUP1)
 > -	if (setup_count < ARRAY_SIZE(setup)) {
 > -		struct aha152x_setup override = SETUP1;
 > -
 > -		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
 > -			if (!checksetup(&override)) {
 > -				printk(KERN_ERR "\naha152x: invalid override SETUP1={0x%x,%d,%d,%d,%d,%d,%d,%d}\n",
 > -				       override.io_port,
 > -				       override.irq,
 > -				       override.scsiid,
 > -				       override.reconnect,
 > -				       override.parity,
 > -				       override.synchronous,
 > -				       override.delay,
 > -				       override.ext_trans);
 > -			} else
 > -				setup[setup_count++] = override;
 > -		}
 > -	}
 > -#endif
 > -
 > -#if defined(MODULE) && !defined(PCMCIA)
 > -	if (setup_count<ARRAY_SIZE(setup) && (aha152x[0]!=0 || io[0]!=0 || irq[0]!=0)) {
 > -		if(aha152x[0]!=0) {
 > -			setup[setup_count].conf        = "";
 > -			setup[setup_count].io_port     = aha152x[0];
 > -			setup[setup_count].irq         = aha152x[1];
 > -			setup[setup_count].scsiid      = aha152x[2];
 > -			setup[setup_count].reconnect   = aha152x[3];
 > -			setup[setup_count].parity      = aha152x[4];
 > -			setup[setup_count].synchronous = aha152x[5];
 > -			setup[setup_count].delay       = aha152x[6];
 > -			setup[setup_count].ext_trans   = aha152x[7];
 > -#if defined(AHA152X_DEBUG)
 > -			setup[setup_count].debug       = aha152x[8];
 > -#endif
 > -	  	} else if(io[0]!=0 || irq[0]!=0) {
 > -			if(io[0]!=0)  setup[setup_count].io_port = io[0];
 > -			if(irq[0]!=0) setup[setup_count].irq     = irq[0];
 > -
 > -	    		setup[setup_count].scsiid      = scsiid[0];
 > -	    		setup[setup_count].reconnect   = reconnect[0];
 > -	    		setup[setup_count].parity      = parity[0];
 > -	    		setup[setup_count].synchronous = sync[0];
 > -	    		setup[setup_count].delay       = delay[0];
 > -	    		setup[setup_count].ext_trans   = exttrans[0];
 > -#if defined(AHA152X_DEBUG)
 > -			setup[setup_count].debug       = debug[0];
 > -#endif
 > -		}
 > -
 > -          	if (checksetup(&setup[setup_count]))
 > -			setup_count++;
 > -		else
 > -			printk(KERN_ERR "aha152x: invalid module params io=0x%x, irq=%d,scsiid=%d,reconnect=%d,parity=%d,sync=%d,delay=%d,exttrans=%d\n",
 > -			       setup[setup_count].io_port,
 > -			       setup[setup_count].irq,
 > -			       setup[setup_count].scsiid,
 > -			       setup[setup_count].reconnect,
 > -			       setup[setup_count].parity,
 > -			       setup[setup_count].synchronous,
 > -			       setup[setup_count].delay,
 > -			       setup[setup_count].ext_trans);
 > -	}
 > -
 > -	if (setup_count<ARRAY_SIZE(setup) && (aha152x1[0]!=0 || io[1]!=0 || irq[1]!=0)) {
 > -		if(aha152x1[0]!=0) {
 > -			setup[setup_count].conf        = "";
 > -			setup[setup_count].io_port     = aha152x1[0];
 > -			setup[setup_count].irq         = aha152x1[1];
 > -			setup[setup_count].scsiid      = aha152x1[2];
 > -			setup[setup_count].reconnect   = aha152x1[3];
 > -			setup[setup_count].parity      = aha152x1[4];
 > -			setup[setup_count].synchronous = aha152x1[5];
 > -			setup[setup_count].delay       = aha152x1[6];
 > -			setup[setup_count].ext_trans   = aha152x1[7];
 > -#if defined(AHA152X_DEBUG)
 > -			setup[setup_count].debug       = aha152x1[8];
 > -#endif
 > -	  	} else if(io[1]!=0 || irq[1]!=0) {
 > -			if(io[1]!=0)  setup[setup_count].io_port = io[1];
 > -			if(irq[1]!=0) setup[setup_count].irq     = irq[1];
 > -
 > -	    		setup[setup_count].scsiid      = scsiid[1];
 > -	    		setup[setup_count].reconnect   = reconnect[1];
 > -	    		setup[setup_count].parity      = parity[1];
 > -	    		setup[setup_count].synchronous = sync[1];
 > -	    		setup[setup_count].delay       = delay[1];
 > -	    		setup[setup_count].ext_trans   = exttrans[1];
 > -#if defined(AHA152X_DEBUG)
 > -			setup[setup_count].debug       = debug[1];
 > -#endif
 > -		}
 > -		if (checksetup(&setup[setup_count]))
 > -			setup_count++;
 > -		else
 > -			printk(KERN_ERR "aha152x: invalid module params io=0x%x, irq=%d,scsiid=%d,reconnect=%d,parity=%d,sync=%d,delay=%d,exttrans=%d\n",
 > -			       setup[setup_count].io_port,
 > -			       setup[setup_count].irq,
 > -			       setup[setup_count].scsiid,
 > -			       setup[setup_count].reconnect,
 > -			       setup[setup_count].parity,
 > -			       setup[setup_count].synchronous,
 > -			       setup[setup_count].delay,
 > -			       setup[setup_count].ext_trans);
 > +	if ( request_irq(shpnt->irq, intr, SA_INTERRUPT|SA_SHIRQ, "aha152x", shpnt) ) {
 > +		printk(KERN_ERR "aha152x%d: failed to reassign irq %d.\n", shpnt->host_no, shpnt->irq);
 > +		goto out_host_put;
 >  	}
 > -#endif
 >  
 > -#ifdef __ISAPNP__
 > -	while ( setup_count<ARRAY_SIZE(setup) && (dev=pnp_find_dev(NULL, ISAPNP_VENDOR('A','D','P'), ISAPNP_FUNCTION(0x1505), dev)) ) {
 > -		if (pnp_device_attach(dev) < 0)
 > -			continue;
 > -		if (pnp_activate_dev(dev) < 0) {
 > -			pnp_device_detach(dev);
 > -			continue;
 > -		}
 > -		if (!pnp_port_valid(dev, 0)) {
 > -			pnp_device_detach(dev);
 > -			continue;
 > -		}
 > -		if (setup_count==1 && pnp_port_start(dev, 0)==setup[0].io_port) {
 > -			pnp_device_detach(dev);
 > -			continue;
 > -		}
 > -		setup[setup_count].io_port     = pnp_port_start(dev, 0);
 > -		setup[setup_count].irq         = pnp_irq(dev, 0);
 > -		setup[setup_count].scsiid      = 7;
 > -		setup[setup_count].reconnect   = 1;
 > -		setup[setup_count].parity      = 1;
 > -		setup[setup_count].synchronous = 1;
 > -		setup[setup_count].delay       = DELAY_DEFAULT;
 > -		setup[setup_count].ext_trans   = 0;
 > -#if defined(AHA152X_DEBUG)
 > -		setup[setup_count].debug       = DEBUG_DEFAULT;
 > -#endif
 > -		pnpdev[setup_count]            = dev;
 > -		printk (KERN_INFO
 > -			"aha152x: found ISAPnP AVA-1505A at io=0x%03x, irq=%d\n",
 > -			setup[setup_count].io_port, setup[setup_count].irq);
 > -		setup_count++;
 > +	if( scsi_add_host(shpnt, 0) ) {
 > +		free_irq(shpnt->irq, shpnt);
 > +		printk(KERN_ERR "aha152x%d: failed to add host.\n", shpnt->host_no);
 > +		goto out_host_put;
 >  	}
 > -#endif
 >  
 > -#if defined(AUTOCONF)
 > -	if (setup_count<ARRAY_SIZE(setup)) {
 > -#if !defined(SKIP_BIOSTEST)
 > -		ok = 0;
 > -		for (i = 0; i < ARRAY_SIZE(addresses) && !ok; i++)
 > -			for (j = 0; j<ARRAY_SIZE(signatures) && !ok; j++)
 > -				ok = isa_check_signature(addresses[i] + signatures[j].sig_offset,
 > -								signatures[j].signature, signatures[j].sig_length);
 > -
 > -		if (!ok && setup_count == 0)
 > -			return 0;
 > -
 > -		printk(KERN_INFO "aha152x: BIOS test: passed, ");
 > -#else
 > -		printk(KERN_INFO "aha152x: ");
 > -#endif				/* !SKIP_BIOSTEST */
 > -
 > -		ok = 0;
 > -		for (i = 0; i < ARRAY_SIZE(ports) && setup_count < 2; i++) {
 > -			if ((setup_count == 1) && (setup[0].io_port == ports[i]))
 > -				continue;
 > -
 > -			if (aha152x_porttest(ports[i])) {
 > -				ok++;
 > -				setup[setup_count].io_port = ports[i];
 > -				setup[setup_count].tc1550  = 0;
 > -
 > -				conf.cf_port =
 > -				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
 > -
 > -				setup[setup_count].irq = IRQ_MIN + conf.cf_irq;
 > -				setup[setup_count].scsiid = conf.cf_id;
 > -				setup[setup_count].reconnect = conf.cf_tardisc;
 > -				setup[setup_count].parity = !conf.cf_parity;
 > -				setup[setup_count].synchronous = conf.cf_syncneg;
 > -				setup[setup_count].delay = DELAY_DEFAULT;
 > -				setup[setup_count].ext_trans = 0;
 > -#if defined(AHA152X_DEBUG)
 > -				setup[setup_count].debug = DEBUG_DEFAULT;
 > -#endif
 > -				setup_count++;
 > -			} else if (tc1550_porttest(ports[i])) {
 > -				ok++;
 > -				setup[setup_count].io_port = ports[i];
 > -				setup[setup_count].tc1550  = 1;
 > -
 > -				conf.cf_port =
 > -				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
 > -
 > -				setup[setup_count].irq = IRQ_MIN + conf.cf_irq;
 > -				setup[setup_count].scsiid = conf.cf_id;
 > -				setup[setup_count].reconnect = conf.cf_tardisc;
 > -				setup[setup_count].parity = !conf.cf_parity;
 > -				setup[setup_count].synchronous = conf.cf_syncneg;
 > -				setup[setup_count].delay = DELAY_DEFAULT;
 > -				setup[setup_count].ext_trans = 0;
 > -#if defined(AHA152X_DEBUG)
 > -				setup[setup_count].debug = DEBUG_DEFAULT;
 > -#endif
 > -				setup_count++;
 > -			}
 > -		}
 > +	scsi_scan_host(shpnt);
 >  
 > -		if (ok)
 > -			printk("auto configuration: ok, ");
 > -	}
 > -#endif
 > +	registered_count++;
 >  
 > -	printk("detected %d controller(s)\n", setup_count);
 > +	return shpnt;
 >  
 > -	for (i=0; i<setup_count; i++) {
 > -		aha152x_probe_one(&setup[i]);
 > -		if (aha152x_host[registered_count]) {
 > -#ifdef __ISAPNP__
 > -			if(pnpdev[i])
 > -				HOSTDATA(aha152x_host[registered_count])->pnpdev=pnpdev[i];
 > -#endif
 > -			registered_count++;
 > -		}
 > -	}
 > +out_host_put:
 > +	aha152x_host[registered_count]=0;
 > +	scsi_host_put(shpnt);
 >  
 > -	return registered_count>0;
 > +	return 0;
 >  }
 >  
 > -static int aha152x_release(struct Scsi_Host *shpnt)
 > +void aha152x_release(struct Scsi_Host *shpnt)
 >  {
 > +	if(!shpnt)
 > +		return;
 > +
 >  	if (shpnt->irq)
 >  		free_irq(shpnt->irq, shpnt);
 >  
 > +#if !defined(PCMCIA)
 >  	if (shpnt->io_port)
 >  		release_region(shpnt->io_port, IO_RANGE);
 > +#endif
 >  
 >  #ifdef __ISAPNP__
 >  	if (HOSTDATA(shpnt)->pnpdev)
 >  		pnp_device_detach(HOSTDATA(shpnt)->pnpdev);
 >  #endif
 >  
 > +	scsi_remove_host(shpnt);
 >  	scsi_host_put(shpnt);
 > -
 > -	return 0;
 > -}
 > -
 > -static void __exit aha152x_exit(void)
 > -{
 > -	int i;
 > -
 > -	for(i=0; i<ARRAY_SIZE(setup); i++) {
 > -		if(aha152x_host[i]) {
 > -			scsi_remove_host(aha152x_host[i]);
 > -			aha152x_release(aha152x_host[i]);
 > -			aha152x_host[i]=0;
 > -		}
 > -	}
 >  }
 >  
 >  
 > @@ -1446,8 +985,8 @@ static int aha152x_internal_queue(Scsi_C
 >  
 >  #if defined(AHA152X_DEBUG)
 >  	if (HOSTDATA(shpnt)->debug & debug_queue) {
 > -		printk(INFO_LEAD "queue: cmd_len=%d pieces=%d size=%u cmnd=",
 > -		       CMDINFO(SCpnt), SCpnt->cmd_len, SCpnt->use_sg, SCpnt->request_bufflen);
 > +		printk(INFO_LEAD "queue: %p; cmd_len=%d pieces=%d size=%u cmnd=",
 > +		       CMDINFO(SCpnt), SCpnt, SCpnt->cmd_len, SCpnt->use_sg, SCpnt->request_bufflen);
 >  		print_command(SCpnt->cmnd);
 >  	}
 >  #endif
 > @@ -1466,7 +1005,7 @@ static int aha152x_internal_queue(Scsi_C
 >  			return FAILED;
 >  		}
 >  	} else {
 > -		SCpnt->host_scribble    = kmalloc(sizeof(struct aha152x_scdata), GFP_ATOMIC);
 > +		SCpnt->host_scribble = kmalloc(sizeof(struct aha152x_scdata), GFP_ATOMIC);
 >  		if(SCpnt->host_scribble==0) {
 >  			printk(ERR_LEAD "allocation failed\n", CMDINFO(SCpnt));
 >  			return FAILED;
 > @@ -1561,11 +1100,6 @@ static int aha152x_abort(Scsi_Cmnd *SCpn
 >  	Scsi_Cmnd *ptr;
 >  	unsigned long flags;
 >  
 > -	if(!shpnt) {
 > -		printk(ERR_LEAD "abort(%p): no host structure\n", CMDINFO(SCpnt), SCpnt);
 > -		return FAILED;
 > -	}
 > -
 >  #if defined(AHA152X_DEBUG)
 >  	if(HOSTDATA(shpnt)->debug & debug_eh) {
 >  		printk(DEBUG_LEAD "abort(%p)", CMDINFO(SCpnt), SCpnt);
 > @@ -1608,33 +1142,52 @@ static int aha152x_abort(Scsi_Cmnd *SCpn
 >  static void timer_expired(unsigned long p)
 >  {
 >  	Scsi_Cmnd	 *SCp   = (Scsi_Cmnd *)p;
 > -	struct semaphore *sem   = SCSEM(SCp);
 > -	struct Scsi_Host *shpnt = SCp->device->host;
 > +	struct semaphore *sem;
 > +	struct Scsi_Host *shpnt;
 > +	unsigned long flags;
 >  
 > -	/* remove command from issue queue */
 > -	if(remove_SC(&ISSUE_SC, SCp)) {
 > -		printk(KERN_INFO "aha152x: ABORT timed out - removed from issue queue\n");
 > -		kfree(SCp->host_scribble);
 > -		SCp->host_scribble=0;
 > -	} else {
 > -		printk(KERN_INFO "aha152x: ABORT timed out - not on issue queue\n");
 > +	if(SCp==0) {
 > +		printk(KERN_ERR "timer_expired: command not set\n");
 > +		return;
 >  	}
 >  
 > -	up(sem);
 > +	if(SCp->host_scribble==0) {
 > +		printk(KERN_ERR "timer_expired: host_scribble not set\n");
 > +		return;
 > +	}
 > +
 > +	if(SCp->device==0) {
 > +		printk(KERN_ERR "timer_expired: device not set\n");
 > +		return;
 > +	}
 > +		
 > +	shpnt = SCp->device->host;
 > +
 > +	if(shpnt==0) {
 > +		printk(KERN_ERR "timer_expired: host not set\n");
 > +		return;
 > +	}
 > +
 > + 	sem = SCSEM(SCp);
 > +
 > +	if(sem) {
 > +		up(sem);
 > +	} else {
 > +		printk(KERN_ERR "timer_expired: semaphore not set\n");
 > +	}
 >  }
 >  
 >  /*
 >   * Reset a device
 >   *
 > - * FIXME: never seen this live. might lockup...
 > - *
 >   */
 >  static int aha152x_device_reset(Scsi_Cmnd * SCpnt)
 >  {
 >  	struct Scsi_Host *shpnt = SCpnt->device->host;
 >  	DECLARE_MUTEX_LOCKED(sem);
 >  	struct timer_list timer;
 > -	int ret;
 > +	int ret, issued, disconnected;
 > +	unsigned long flags;
 >  
 >  #if defined(AHA152X_DEBUG)
 >  	if(HOSTDATA(shpnt)->debug & debug_eh) {
 > @@ -1648,13 +1201,18 @@ static int aha152x_device_reset(Scsi_Cmn
 >  		return FAILED;
 >  	}
 >  
 > +	DO_LOCK(flags);
 > +	issued       = remove_SC(&ISSUE_SC, SCpnt)==0;
 > +	disconnected = issued && remove_SC(&DISCONNECTED_SC, SCpnt);
 > +	DO_UNLOCK(flags);
 > +
 >  	SCpnt->cmd_len         = 0;
 >  	SCpnt->use_sg          = 0;
 >  	SCpnt->request_buffer  = 0;
 >  	SCpnt->request_bufflen = 0;
 >  
 >  	init_timer(&timer);
 > -	timer.data     = (unsigned long) cmd;
 > +	timer.data     = (unsigned long) SCpnt;
 >  	timer.expires  = jiffies + 100*HZ;   /* 10s */
 >  	timer.function = (void (*)(unsigned long)) timer_expired;
 >  
 > @@ -1662,18 +1220,36 @@ static int aha152x_device_reset(Scsi_Cmn
 >  	add_timer(&timer);
 >  	down(&sem);
 >  	del_timer(&timer);
 > -
 > +	
 >  	SCpnt->cmd_len         = SCpnt->old_cmd_len;
 >  	SCpnt->use_sg          = SCpnt->old_use_sg;
 >    	SCpnt->request_buffer  = SCpnt->buffer;
 >         	SCpnt->request_bufflen = SCpnt->bufflen;
 >  
 > +	DO_LOCK(flags);
 > +
 >  	if(SCpnt->SCp.phase & resetted) {
 > +		HOSTDATA(shpnt)->commands--;
 > +		if (!HOSTDATA(shpnt)->commands)
 > +			SETPORT(PORTA, 0);
 > +		kfree(SCpnt->host_scribble);
 > +		SCpnt->host_scribble=0;
 > +
 >  		ret = SUCCESS;
 >  	} else {
 > +		/* requeue */
 > +		if(!issued) {
 > +			append_SC(&ISSUE_SC, SCpnt);
 > +		} else if(disconnected) {
 > +			remove_SC(&ISSUE_SC, SCpnt);
 > +			append_SC(&DISCONNECTED_SC, SCpnt);
 > +		}
 > +	
 >  		ret = FAILED;
 >  	}
 >  
 > +	DO_UNLOCK(flags);
 > +
 >  	spin_lock_irq(shpnt->host_lock);
 >  	return ret;
 >  }
 > @@ -1681,13 +1257,17 @@ static int aha152x_device_reset(Scsi_Cmn
 >  static void free_hard_reset_SCs(struct Scsi_Host *shpnt, Scsi_Cmnd **SCs)
 >  {
 >  	Scsi_Cmnd *ptr;
 > -	unsigned long flags;
 > -
 > -	DO_LOCK(flags);
 >  
 >  	ptr=*SCs;
 >  	while(ptr) {
 > -		Scsi_Cmnd *next = SCNEXT(ptr);
 > +		Scsi_Cmnd *next;
 > +
 > +		if(SCDATA(ptr)) {
 > +			next = SCNEXT(ptr);
 > +		} else {
 > +			printk(DEBUG_LEAD "queue corrupted at %p\n", CMDINFO(ptr), ptr);
 > +			next = 0;
 > +		}
 >  
 >  		if (!ptr->device->soft_reset) {
 >  			DPRINTK(debug_eh, DEBUG_LEAD "disconnected command %p removed\n", CMDINFO(ptr), ptr);
 > @@ -1699,8 +1279,6 @@ static void free_hard_reset_SCs(struct S
 >  
 >  		ptr = next;
 >  	}
 > -
 > -	DO_UNLOCK(flags);
 >  }
 >  
 >  /*
 > @@ -1712,6 +1290,8 @@ static int aha152x_bus_reset(Scsi_Cmnd *
 >  	struct Scsi_Host *shpnt = SCpnt->device->host;
 >  	unsigned long flags;
 >  
 > +	DO_LOCK(flags);
 > +
 >  #if defined(AHA152X_DEBUG)
 >  	if(HOSTDATA(shpnt)->debug & debug_eh) {
 >  		printk(DEBUG_LEAD "aha152x_bus_reset(%p)", CMDINFO(SCpnt), SCpnt);
 > @@ -1729,12 +1309,12 @@ static int aha152x_bus_reset(Scsi_Cmnd *
 >  	SETPORT(SCSISEQ, 0);
 >  	mdelay(DELAY);
 >  
 > -	DPRINTK(debug_eh, DEBUG_LEAD "bus reset returns\n", CMDINFO(SCpnt));
 > +	DPRINTK(debug_eh, DEBUG_LEAD "bus resetted\n", CMDINFO(SCpnt));
 >  
 > -	DO_LOCK(flags);
 >  	setup_expected_interrupts(shpnt);
 >  	if(HOSTDATA(shpnt)->commands==0)
 >  		SETPORT(PORTA, 0);
 > +
 >  	DO_UNLOCK(flags);
 >  
 >  	return SUCCESS;
 > @@ -2000,6 +1580,7 @@ static void busfree_run(struct Scsi_Host
 >  #if defined(AHA152X_STAT)
 >  		action++;
 >  #endif
 > +
 >  		if(DONE_SC->SCp.phase & check_condition) {
 >  #if 0
 >  			if(HOSTDATA(shpnt)->debug & debug_eh) {
 > @@ -2029,47 +1610,57 @@ static void busfree_run(struct Scsi_Host
 >  #endif
 >  
 >  			if(!(DONE_SC->SCp.Status & not_issued)) {
 > +				Scsi_Cmnd *ptr = DONE_SC;
 > +				DONE_SC=0;
 >  #if 0
 > -				DPRINTK(debug_eh, ERR_LEAD "requesting sense\n", CMDINFO(DONE_SC));
 > +				DPRINTK(debug_eh, ERR_LEAD "requesting sense\n", CMDINFO(ptr));
 >  #endif
 >  
 > -				DONE_SC->cmnd[0]         = REQUEST_SENSE;
 > -				DONE_SC->cmnd[1]         = 0;
 > -				DONE_SC->cmnd[2]         = 0;
 > -				DONE_SC->cmnd[3]         = 0;
 > -				DONE_SC->cmnd[4]         = sizeof(DONE_SC->sense_buffer);
 > -				DONE_SC->cmnd[5]         = 0;
 > -				DONE_SC->cmd_len         = 6;
 > -				DONE_SC->use_sg          = 0; 
 > -				DONE_SC->request_buffer  = DONE_SC->sense_buffer;
 > -				DONE_SC->request_bufflen = sizeof(DONE_SC->sense_buffer);
 > +				ptr->cmnd[0]         = REQUEST_SENSE;
 > +				ptr->cmnd[1]         = 0;
 > +				ptr->cmnd[2]         = 0;
 > +				ptr->cmnd[3]         = 0;
 > +				ptr->cmnd[4]         = sizeof(ptr->sense_buffer);
 > +				ptr->cmnd[5]         = 0;
 > +				ptr->cmd_len         = 6;
 > +				ptr->use_sg          = 0; 
 > +				ptr->request_buffer  = ptr->sense_buffer;
 > +				ptr->request_bufflen = sizeof(ptr->sense_buffer);
 >  			
 >  				DO_UNLOCK(flags);
 > -				aha152x_internal_queue(DONE_SC, 0, check_condition, DONE_SC->scsi_done);
 > +				aha152x_internal_queue(ptr, 0, check_condition, ptr->scsi_done);
 >  				DO_LOCK(flags);
 > -
 > -				DONE_SC=0;
 > -			} else {
 >  #if 0
 > +			} else {
 >  				DPRINTK(debug_eh, ERR_LEAD "command not issued - CHECK CONDITION ignored\n", CMDINFO(DONE_SC));
 >  #endif
 >  			}
 >  		}
 >  
 >  		if(DONE_SC && DONE_SC->scsi_done) {
 > +#if defined(AHA152X_DEBUG)
 > +			int hostno=DONE_SC->device->host->host_no;
 > +			int id=DONE_SC->device->id & 0xf;
 > +			int lun=DONE_SC->device->lun & 0x7;
 > +#endif
 > +			Scsi_Cmnd *ptr = DONE_SC;
 > +			DONE_SC=0;
 > +
 >  			/* turn led off, when no commands are in the driver */
 >  			HOSTDATA(shpnt)->commands--;
 >  			if (!HOSTDATA(shpnt)->commands)
 >  				SETPORT(PORTA, 0);	/* turn led off */
 >  
 > +			if(ptr->scsi_done != reset_done) {
 > +				kfree(ptr->host_scribble);
 > +				ptr->host_scribble=0;
 > +			}
 > +
 >  			DO_UNLOCK(flags);
 > -			DPRINTK(debug_done, DEBUG_LEAD "calling scsi_done(%p)\n", CMDINFO(DONE_SC), DONE_SC);
 > -                	DONE_SC->scsi_done(DONE_SC);
 > -			DPRINTK(debug_done, DEBUG_LEAD "scsi_done(%p) returned\n", CMDINFO(DONE_SC), DONE_SC);
 > +			DPRINTK(debug_done, DEBUG_LEAD "calling scsi_done(%p)\n", hostno, id, lun, ptr);
 > +                	ptr->scsi_done(ptr);
 > +			DPRINTK(debug_done, DEBUG_LEAD "scsi_done(%p) returned\n", hostno, id, lun, ptr);
 >  			DO_LOCK(flags);
 > -
 > -			kfree(DONE_SC->host_scribble);
 > -			DONE_SC->host_scribble=0;
 >  		}
 >  
 >  		DONE_SC=0;
 > @@ -2936,11 +2527,11 @@ static void rsti_run(struct Scsi_Host *s
 >  		if (!ptr->device->soft_reset) {
 >  			remove_SC(&DISCONNECTED_SC, ptr);
 >  
 > -			ptr->result =  DID_RESET << 16;
 > -			ptr->scsi_done(ptr);
 > -
 >  			kfree(ptr->host_scribble);
 >  			ptr->host_scribble=0;
 > +
 > +			ptr->result =  DID_RESET << 16;
 > +			ptr->scsi_done(ptr);
 >  		}
 >  
 >  		ptr = next;
 > @@ -3382,7 +2973,11 @@ static void show_command(Scsi_Cmnd *ptr)
 >  		printk("aborted|");
 >  	if (ptr->SCp.phase & resetted)
 >  		printk("resetted|");
 > -	printk("; next=0x%p\n", SCNEXT(ptr));
 > +	if( SCDATA(ptr) ) {
 > +		printk("; next=0x%p\n", SCNEXT(ptr));
 > +	} else {
 > +		printk("; next=(host scribble NULL)\n");
 > +	}
 >  }
 >  
 >  /*
 > @@ -3406,7 +3001,7 @@ static void show_queues(struct Scsi_Host
 >  		printk(KERN_DEBUG "none\n");
 >  
 >  	printk(KERN_DEBUG "disconnected_SC:\n");
 > -	for (ptr = DISCONNECTED_SC; ptr; ptr = SCNEXT(ptr))
 > +	for (ptr = DISCONNECTED_SC; ptr; ptr = SCDATA(ptr) ? SCNEXT(ptr) : 0)
 >  		show_command(ptr);
 >  
 >  	disp_ports(shpnt);
 > @@ -3914,7 +3509,494 @@ static Scsi_Host_Template aha152x_driver
 >  	.use_clustering			= DISABLE_CLUSTERING,
 >  };
 >  
 > -#ifndef PCMCIA
 > +#if !defined(PCMCIA)
 > +static int setup_count;
 > +static struct aha152x_setup setup[2];
 > +
 > +/* possible i/o addresses for the AIC-6260; default first */
 > +static unsigned short ports[] = { 0x340, 0x140 };
 > +
 > +#if !defined(SKIP_BIOSTEST)
 > +/* possible locations for the Adaptec BIOS; defaults first */
 > +static unsigned int addresses[] =
 > +{
 > +	0xdc000,		/* default first */
 > +	0xc8000,
 > +	0xcc000,
 > +	0xd0000,
 > +	0xd4000,
 > +	0xd8000,
 > +	0xe0000,
 > +	0xeb800,		/* VTech Platinum SMP */
 > +	0xf0000,
 > +};
 > +
 > +/* signatures for various AIC-6[23]60 based controllers.
 > +   The point in detecting signatures is to avoid useless and maybe
 > +   harmful probes on ports. I'm not sure that all listed boards pass
 > +   auto-configuration. For those which fail the BIOS signature is
 > +   obsolete, because user intervention to supply the configuration is
 > +   needed anyway.  May be an information whether or not the BIOS supports
 > +   extended translation could be also useful here. */
 > +static struct signature {
 > +	unsigned char *signature;
 > +	int sig_offset;
 > +	int sig_length;
 > +} signatures[] =
 > +{
 > +	{ "Adaptec AHA-1520 BIOS",	0x102e, 21 },
 > +		/* Adaptec 152x */
 > +	{ "Adaptec AHA-1520B",		0x000b, 17 },
 > +		/* Adaptec 152x rev B */
 > +	{ "Adaptec AHA-1520B",		0x0026, 17 },
 > +		/* Iomega Jaz Jet ISA (AIC6370Q) */
 > +	{ "Adaptec ASW-B626 BIOS",	0x1029, 21 },
 > +		/* on-board controller */
 > +	{ "Adaptec BIOS: ASW-B626",	0x000f, 22 },
 > +		/* on-board controller */
 > +	{ "Adaptec ASW-B626 S2",	0x2e6c, 19 },
 > +		/* on-board controller */
 > +	{ "Adaptec BIOS:AIC-6360",	0x000c, 21 },
 > +		/* on-board controller */
 > +	{ "ScsiPro SP-360 BIOS",	0x2873, 19 },
 > +		/* ScsiPro-Controller  */
 > +	{ "GA-400 LOCAL BUS SCSI BIOS", 0x102e, 26 },
 > +		/* Gigabyte Local-Bus-SCSI */
 > +	{ "Adaptec BIOS:AVA-282X",	0x000c, 21 },
 > +		/* Adaptec 282x */
 > +	{ "Adaptec IBM Dock II SCSI",   0x2edd, 24 },
 > +		/* IBM Thinkpad Dock II */
 > +	{ "Adaptec BIOS:AHA-1532P",     0x001c, 22 },
 > +		/* IBM Thinkpad Dock II SCSI */
 > +	{ "DTC3520A Host Adapter BIOS", 0x318a, 26 },
 > +		/* DTC 3520A ISA SCSI */
 > +};
 > +#endif /* !SKIP_BIOSTEST */
 > +
 > +/*
 > + * Test, if port_base is valid.
 > + *
 > + */
 > +static int aha152x_porttest(int io_port)
 > +{
 > +	int i;
 > +
 > +	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
 > +	for (i = 0; i < 16; i++)
 > +		SETPORT(io_port + O_STACK, i);
 > +
 > +	SETPORT(io_port + O_DMACNTRL1, 0);	/* reset stack pointer */
 > +	for (i = 0; i < 16 && GETPORT(io_port + O_STACK) == i; i++)
 > +		;
 > +
 > +	return (i == 16);
 > +}
 > +
 > +static int tc1550_porttest(int io_port)
 > +{
 > +	int i;
 > +
 > +	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
 > +	for (i = 0; i < 16; i++)
 > +		SETPORT(io_port + O_STACK, i);
 > +
 > +	SETPORT(io_port + O_TC_DMACNTRL1, 0);	/* reset stack pointer */
 > +	for (i = 0; i < 16 && GETPORT(io_port + O_TC_STACK) == i; i++)
 > +		;
 > +
 > +	return (i == 16);
 > +}
 > +
 > +
 > +static int checksetup(struct aha152x_setup *setup)
 > +{
 > +	int i;
 > +	for (i = 0; i < ARRAY_SIZE(ports) && (setup->io_port != ports[i]); i++)
 > +		;
 > +
 > +	if (i == ARRAY_SIZE(ports))
 > +		return 0;
 > +
 > +	if ( request_region(setup->io_port, IO_RANGE, "aha152x")==0 ) {
 > +		printk(KERN_ERR "aha152x: io port 0x%x busy.\n", setup->io_port);
 > +		return 0;
 > +	}
 > +
 > +	if( aha152x_porttest(setup->io_port) ) {
 > +		setup->tc1550=0;
 > +	} else if( tc1550_porttest(setup->io_port) ) {
 > +		setup->tc1550=1;
 > +	} else {
 > +		release_region(setup->io_port, IO_RANGE);
 > +		return 0;
 > +	}
 > +
 > +	release_region(setup->io_port, IO_RANGE);
 > +
 > +	if ((setup->irq < IRQ_MIN) || (setup->irq > IRQ_MAX))
 > +		return 0;
 > +
 > +	if ((setup->scsiid < 0) || (setup->scsiid > 7))
 > +		return 0;
 > +
 > +	if ((setup->reconnect < 0) || (setup->reconnect > 1))
 > +		return 0;
 > +
 > +	if ((setup->parity < 0) || (setup->parity > 1))
 > +		return 0;
 > +
 > +	if ((setup->synchronous < 0) || (setup->synchronous > 1))
 > +		return 0;
 > +
 > +	if ((setup->ext_trans < 0) || (setup->ext_trans > 1))
 > +		return 0;
 > +
 > +
 > +	return 1;
 > +}
 > +
 > +
 > +static int __init aha152x_init(void)
 > +{
 > +	int i, j, ok;
 > +#if defined(AUTOCONF)
 > +	aha152x_config conf;
 > +#endif
 > +#ifdef __ISAPNP__
 > +	struct pnp_dev *dev=0, *pnpdev[2] = {0, 0};
 > +#endif
 > +
 > +	if ( setup_count ) {
 > +		printk(KERN_INFO "aha152x: processing commandline: ");
 > +
 > +		for (i = 0; i<setup_count; i++) {
 > +			if (!checksetup(&setup[i])) {
 > +				printk(KERN_ERR "\naha152x: %s\n", setup[i].conf);
 > +				printk(KERN_ERR "aha152x: invalid line\n");
 > +			}
 > +		}
 > +		printk("ok\n");
 > +	}
 > +
 > +#if defined(SETUP0)
 > +	if (setup_count < ARRAY_SIZE(setup)) {
 > +		struct aha152x_setup override = SETUP0;
 > +
 > +		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
 > +			if (!checksetup(&override)) {
 > +				printk(KERN_ERR "\naha152x: invalid override SETUP0={0x%x,%d,%d,%d,%d,%d,%d,%d}\n",
 > +				       override.io_port,
 > +				       override.irq,
 > +				       override.scsiid,
 > +				       override.reconnect,
 > +				       override.parity,
 > +				       override.synchronous,
 > +				       override.delay,
 > +				       override.ext_trans);
 > +			} else
 > +				setup[setup_count++] = override;
 > +		}
 > +	}
 > +#endif
 > +
 > +#if defined(SETUP1)
 > +	if (setup_count < ARRAY_SIZE(setup)) {
 > +		struct aha152x_setup override = SETUP1;
 > +
 > +		if (setup_count == 0 || (override.io_port != setup[0].io_port)) {
 > +			if (!checksetup(&override)) {
 > +				printk(KERN_ERR "\naha152x: invalid override SETUP1={0x%x,%d,%d,%d,%d,%d,%d,%d}\n",
 > +				       override.io_port,
 > +				       override.irq,
 > +				       override.scsiid,
 > +				       override.reconnect,
 > +				       override.parity,
 > +				       override.synchronous,
 > +				       override.delay,
 > +				       override.ext_trans);
 > +			} else
 > +				setup[setup_count++] = override;
 > +		}
 > +	}
 > +#endif
 > +
 > +#if defined(MODULE)
 > +	if (setup_count<ARRAY_SIZE(setup) && (aha152x[0]!=0 || io[0]!=0 || irq[0]!=0)) {
 > +		if(aha152x[0]!=0) {
 > +			setup[setup_count].conf        = "";
 > +			setup[setup_count].io_port     = aha152x[0];
 > +			setup[setup_count].irq         = aha152x[1];
 > +			setup[setup_count].scsiid      = aha152x[2];
 > +			setup[setup_count].reconnect   = aha152x[3];
 > +			setup[setup_count].parity      = aha152x[4];
 > +			setup[setup_count].synchronous = aha152x[5];
 > +			setup[setup_count].delay       = aha152x[6];
 > +			setup[setup_count].ext_trans   = aha152x[7];
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug       = aha152x[8];
 > +#endif
 > +	  	} else if(io[0]!=0 || irq[0]!=0) {
 > +			if(io[0]!=0)  setup[setup_count].io_port = io[0];
 > +			if(irq[0]!=0) setup[setup_count].irq     = irq[0];
 > +
 > +	    		setup[setup_count].scsiid      = scsiid[0];
 > +	    		setup[setup_count].reconnect   = reconnect[0];
 > +	    		setup[setup_count].parity      = parity[0];
 > +	    		setup[setup_count].synchronous = sync[0];
 > +	    		setup[setup_count].delay       = delay[0];
 > +	    		setup[setup_count].ext_trans   = exttrans[0];
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug       = debug[0];
 > +#endif
 > +		}
 > +
 > +          	if (checksetup(&setup[setup_count]))
 > +			setup_count++;
 > +		else
 > +			printk(KERN_ERR "aha152x: invalid module params io=0x%x, irq=%d,scsiid=%d,reconnect=%d,parity=%d,sync=%d,delay=%d,exttrans=%d\n",
 > +			       setup[setup_count].io_port,
 > +			       setup[setup_count].irq,
 > +			       setup[setup_count].scsiid,
 > +			       setup[setup_count].reconnect,
 > +			       setup[setup_count].parity,
 > +			       setup[setup_count].synchronous,
 > +			       setup[setup_count].delay,
 > +			       setup[setup_count].ext_trans);
 > +	}
 > +
 > +	if (setup_count<ARRAY_SIZE(setup) && (aha152x1[0]!=0 || io[1]!=0 || irq[1]!=0)) {
 > +		if(aha152x1[0]!=0) {
 > +			setup[setup_count].conf        = "";
 > +			setup[setup_count].io_port     = aha152x1[0];
 > +			setup[setup_count].irq         = aha152x1[1];
 > +			setup[setup_count].scsiid      = aha152x1[2];
 > +			setup[setup_count].reconnect   = aha152x1[3];
 > +			setup[setup_count].parity      = aha152x1[4];
 > +			setup[setup_count].synchronous = aha152x1[5];
 > +			setup[setup_count].delay       = aha152x1[6];
 > +			setup[setup_count].ext_trans   = aha152x1[7];
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug       = aha152x1[8];
 > +#endif
 > +	  	} else if(io[1]!=0 || irq[1]!=0) {
 > +			if(io[1]!=0)  setup[setup_count].io_port = io[1];
 > +			if(irq[1]!=0) setup[setup_count].irq     = irq[1];
 > +
 > +	    		setup[setup_count].scsiid      = scsiid[1];
 > +	    		setup[setup_count].reconnect   = reconnect[1];
 > +	    		setup[setup_count].parity      = parity[1];
 > +	    		setup[setup_count].synchronous = sync[1];
 > +	    		setup[setup_count].delay       = delay[1];
 > +	    		setup[setup_count].ext_trans   = exttrans[1];
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug       = debug[1];
 > +#endif
 > +		}
 > +		if (checksetup(&setup[setup_count]))
 > +			setup_count++;
 > +		else
 > +			printk(KERN_ERR "aha152x: invalid module params io=0x%x, irq=%d,scsiid=%d,reconnect=%d,parity=%d,sync=%d,delay=%d,exttrans=%d\n",
 > +			       setup[setup_count].io_port,
 > +			       setup[setup_count].irq,
 > +			       setup[setup_count].scsiid,
 > +			       setup[setup_count].reconnect,
 > +			       setup[setup_count].parity,
 > +			       setup[setup_count].synchronous,
 > +			       setup[setup_count].delay,
 > +			       setup[setup_count].ext_trans);
 > +	}
 > +#endif
 > +
 > +#ifdef __ISAPNP__
 > +	for(i=0; setup_count<ARRAY_SIZE(setup) && id_table[i].vendor; i++) {
 > +		while ( setup_count<ARRAY_SIZE(setup) &&
 > +			(dev=pnp_find_dev(NULL, id_table[i].vendor, id_table[i].function, dev)) ) {
 > +			if (pnp_device_attach(dev) < 0)
 > +				continue;
 > +
 > +			if (pnp_activate_dev(dev) < 0) {
 > +				pnp_device_detach(dev);
 > +				continue;
 > +			}
 > +
 > +			if (!pnp_port_valid(dev, 0)) {
 > +				pnp_device_detach(dev);
 > +				continue;
 > +			}
 > +
 > +			if (setup_count==1 && pnp_port_start(dev, 0)==setup[0].io_port) {
 > +				pnp_device_detach(dev);
 > +				continue;
 > +			}
 > +
 > +			setup[setup_count].io_port     = pnp_port_start(dev, 0);
 > +			setup[setup_count].irq         = pnp_irq(dev, 0);
 > +			setup[setup_count].scsiid      = 7;
 > +			setup[setup_count].reconnect   = 1;
 > +			setup[setup_count].parity      = 1;
 > +			setup[setup_count].synchronous = 1;
 > +			setup[setup_count].delay       = DELAY_DEFAULT;
 > +			setup[setup_count].ext_trans   = 0;
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug       = DEBUG_DEFAULT;
 > +#endif
 > +#if defined(__ISAPNP__)
 > +			pnpdev[setup_count]            = dev;
 > +#endif
 > +			printk (KERN_INFO
 > +				"aha152x: found ISAPnP adapter at io=0x%03x, irq=%d\n",
 > +				setup[setup_count].io_port, setup[setup_count].irq);
 > +			setup_count++;
 > +		}
 > +	}
 > +#endif
 > +
 > +#if defined(AUTOCONF)
 > +	if (setup_count<ARRAY_SIZE(setup)) {
 > +#if !defined(SKIP_BIOSTEST)
 > +		ok = 0;
 > +		for (i = 0; i < ARRAY_SIZE(addresses) && !ok; i++)
 > +			for (j = 0; j<ARRAY_SIZE(signatures) && !ok; j++)
 > +				ok = isa_check_signature(addresses[i] + signatures[j].sig_offset,
 > +								signatures[j].signature, signatures[j].sig_length);
 > +		if (!ok && setup_count == 0)
 > +			return 0;
 > +
 > +		printk(KERN_INFO "aha152x: BIOS test: passed, ");
 > +#else
 > +		printk(KERN_INFO "aha152x: ");
 > +#endif				/* !SKIP_BIOSTEST */
 > +
 > +		ok = 0;
 > +		for (i = 0; i < ARRAY_SIZE(ports) && setup_count < 2; i++) {
 > +			if ((setup_count == 1) && (setup[0].io_port == ports[i]))
 > +				continue;
 > +
 > +			if ( request_region(ports[i], IO_RANGE, "aha152x")==0 ) {
 > +				printk(KERN_ERR "aha152x: io port 0x%x busy.\n", ports[i]);
 > +				continue;
 > +			}
 > +
 > +			if (aha152x_porttest(ports[i])) {
 > +				setup[setup_count].tc1550  = 0;
 > +
 > +				conf.cf_port =
 > +				    (GETPORT(ports[i] + O_PORTA) << 8) + GETPORT(ports[i] + O_PORTB);
 > +			} else if (tc1550_porttest(ports[i])) {
 > +				setup[setup_count].tc1550  = 1;
 > +
 > +				conf.cf_port =
 > +				    (GETPORT(ports[i] + O_TC_PORTA) << 8) + GETPORT(ports[i] + O_TC_PORTB);
 > +			} else {
 > +				release_region(ports[i], IO_RANGE);
 > +				continue;
 > +			}
 > +
 > +			release_region(ports[i], IO_RANGE);
 > +
 > +			ok++;
 > +			setup[setup_count].io_port = ports[i];
 > +			setup[setup_count].irq = IRQ_MIN + conf.cf_irq;
 > +			setup[setup_count].scsiid = conf.cf_id;
 > +			setup[setup_count].reconnect = conf.cf_tardisc;
 > +			setup[setup_count].parity = !conf.cf_parity;
 > +			setup[setup_count].synchronous = conf.cf_syncneg;
 > +			setup[setup_count].delay = DELAY_DEFAULT;
 > +			setup[setup_count].ext_trans = 0;
 > +#if defined(AHA152X_DEBUG)
 > +			setup[setup_count].debug = DEBUG_DEFAULT;
 > +#endif
 > +			setup_count++;
 > +
 > +		}
 > +
 > +		if (ok)
 > +			printk("auto configuration: ok, ");
 > +	}
 > +#endif
 > +
 > +	printk("%d controller(s) configured\n", setup_count);
 > +
 > +	for (i=0; i<setup_count; i++) {
 > +		if ( request_region(setup[i].io_port, IO_RANGE, "aha152x") ) {
 > +			struct Scsi_Host *shpnt = aha152x_probe_one(&setup[i]);
 > +
 > +			if( !shpnt ) {
 > +				release_region(setup[i].io_port, IO_RANGE);
 > +#if defined(__ISAPNP__)
 > +			} else if( pnpdev[i] ) {
 > +				HOSTDATA(shpnt)->pnpdev=pnpdev[i];
 > +				pnpdev[i]=0;
 > +#endif
 > +			}
 > +		} else {
 > +			printk(KERN_ERR "aha152x: io port 0x%x busy.\n", setup[i].io_port);
 > +		}
 > +
 > +#if defined(__ISAPNP__)
 > +		if( pnpdev[i] )
 > +			pnp_device_detach(pnpdev[i]);
 > +#endif
 > +	}
 > +
 > +	return registered_count>0;
 > +}
 > +
 > +static void __exit aha152x_exit(void)
 > +{
 > +	int i;
 > +
 > +	for(i=0; i<ARRAY_SIZE(setup); i++) {
 > +		aha152x_release(aha152x_host[i]);
 > +		aha152x_host[i]=0;
 > +	}
 > +}
 > +
 >  module_init(aha152x_init);
 >  module_exit(aha152x_exit);
 > +
 > +#if !defined(MODULE)
 > +static int __init aha152x_setup(char *str)
 > +{
 > +#if defined(AHA152X_DEBUG)
 > +	int ints[11];
 > +#else
 > +	int ints[10];
 > +#endif
 > +	get_options(str, ARRAY_SIZE(ints), ints);
 > +
 > +	if(setup_count>=ARRAY_SIZE(setup)) {
 > +		printk(KERN_ERR "aha152x: you can only configure up to two controllers\n");
 > +		return 1;
 > +	}
 > +
 > +	setup[setup_count].conf        = str;
 > +	setup[setup_count].io_port     = ints[0] >= 1 ? ints[1] : 0x340;
 > +	setup[setup_count].irq         = ints[0] >= 2 ? ints[2] : 11;
 > +	setup[setup_count].scsiid      = ints[0] >= 3 ? ints[3] : 7;
 > +	setup[setup_count].reconnect   = ints[0] >= 4 ? ints[4] : 1;
 > +	setup[setup_count].parity      = ints[0] >= 5 ? ints[5] : 1;
 > +	setup[setup_count].synchronous = ints[0] >= 6 ? ints[6] : 1;
 > +	setup[setup_count].delay       = ints[0] >= 7 ? ints[7] : DELAY_DEFAULT;
 > +	setup[setup_count].ext_trans   = ints[0] >= 8 ? ints[8] : 0;
 > +#if defined(AHA152X_DEBUG)
 > +	setup[setup_count].debug       = ints[0] >= 9 ? ints[9] : DEBUG_DEFAULT;
 > +	if (ints[0] > 9) {
 > +		printk(KERN_NOTICE "aha152x: usage: aha152x=<IOBASE>[,<IRQ>[,<SCSI ID>"
 > +		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>[,<DEBUG>]]]]]]]]\n");
 > +#else
 > +	if (ints[0] > 8) {                                                /*}*/
 > +		printk(KERN_NOTICE "aha152x: usage: aha152x=<IOBASE>[,<IRQ>[,<SCSI ID>"
 > +		       "[,<RECONNECT>[,<PARITY>[,<SYNCHRONOUS>[,<DELAY>[,<EXT_TRANS>]]]]]]]\n");
 >  #endif
 > +	} else {
 > +		setup_count++;
 > +		return 0;
 > +	}
 > +
 > +	return 1;
 > +}
 > +__setup("aha152x=", aha152x_setup);
 > +#endif
 > +
 > +#endif /* !PCMCIA */
 > diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/aha152x.h linux-2.6.2-rc2/drivers/scsi/aha152x.h
 > --- orig/linux-2.6.2-rc2/drivers/scsi/aha152x.h	2003-12-18 03:59:05.000000000 +0100
 > +++ linux-2.6.2-rc2/drivers/scsi/aha152x.h	2004-01-24 12:45:17.000000000 +0100
 > @@ -2,14 +2,14 @@
 >  #define _AHA152X_H
 >  
 >  /*
 > - * $Id: aha152x.h,v 2.5 2002/04/14 11:24:12 fischer Exp $
 > + * $Id: aha152x.h,v 2.7 2004/01/24 11:39:03 fischer Exp $
 >   */
 >  
 >  /* number of queueable commands
 >     (unless we support more than 1 cmd_per_lun this should do) */
 >  #define AHA152X_MAXQUEUE 7
 >  
 > -#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.5 $"
 > +#define AHA152X_REVID "Adaptec 152x SCSI driver; $Revision: 2.7 $"
 >  
 >  /* port addresses */
 >  #define SCSISEQ      (HOSTIOPORT0+0x00)    /* SCSI sequence control */
 > @@ -331,6 +331,7 @@ struct aha152x_setup {
 >  };
 >  
 >  struct Scsi_Host *aha152x_probe_one(struct aha152x_setup *);
 > -int aha152x_host_reset(struct scsi_cmnd *);
 > +void aha152x_release(struct Scsi_Host *);
 > +int aha152x_host_reset(Scsi_Cmnd *);
 >  
 >  #endif /* _AHA152X_H */
 > diff -uprd orig/linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c
 > --- orig/linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c	2004-01-24 11:54:43.000000000 +0100
 > +++ linux-2.6.2-rc2/drivers/scsi/pcmcia/aha152x_stub.c	2004-01-24 12:06:31.000000000 +0100
 > @@ -78,7 +78,7 @@ static int irq_list[4] = { -1 };
 >  static int host_id = 7;
 >  static int reconnect = 1;
 >  static int parity = 1;
 > -static int synchronous = 0;
 > +static int synchronous = 1;
 >  static int reset_delay = 100;
 >  static int ext_trans = 0;
 >  
 > @@ -244,9 +244,6 @@ static void aha152x_config_cs(dev_link_t
 >      CS_CHECK(RequestIRQ, pcmcia_request_irq(handle, &link->irq));
 >      CS_CHECK(RequestConfiguration, pcmcia_request_configuration(handle, &link->conf));
 >      
 > -    /* A bad hack... */
 > -    release_region(link->io.BasePort1, link->io.NumPorts1);
 > -
 >      /* Set configuration options for the aha152x driver */
 >      memset(&s, 0, sizeof(s));
 >      s.conf        = "PCMCIA setup";
 > @@ -266,9 +263,6 @@ static void aha152x_config_cs(dev_link_t
 >  	goto cs_failed;
 >      }
 >  
 > -    scsi_add_host(host, NULL); /* XXX handle failure */
 > -    scsi_scan_host(host);
 > -
 >      sprintf(info->node.dev_name, "scsi%d", host->host_no);
 >      link->dev = &info->node;
 >      info->host = host;
 > @@ -286,7 +280,7 @@ static void aha152x_release_cs(dev_link_
 >  {
 >  	scsi_info_t *info = link->priv;
 >  
 > -	scsi_remove_host(info->host);
 > +	aha152x_release(info->host);
 >  	link->dev = NULL;
 >      
 >  	pcmcia_release_configuration(link->handle);
 > @@ -294,7 +288,6 @@ static void aha152x_release_cs(dev_link_
 >  	pcmcia_release_irq(link->handle, &link->irq);
 >      
 >  	link->state &= ~DEV_CONFIG;
 > -	scsi_unregister(info->host);
 >  }
 >  
 >  static int aha152x_event(event_t event, int priority,
