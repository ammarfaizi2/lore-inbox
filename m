Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbULOUOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbULOUOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 15:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbULOUOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 15:14:53 -0500
Received: from alog0285.analogic.com ([208.224.222.61]:6016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262486AbULOUNo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 15:13:44 -0500
Date: Wed, 15 Dec 2004 15:12:07 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][example patch inside] return statement cleanups, get rid
 of unnecessary parentheses
In-Reply-To: <Pine.LNX.4.61.0412152036020.3864@dragon.hygekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0412151507320.4365@chaos.analogic.com>
References: <Pine.LNX.4.61.0412152036020.3864@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I agree except for the rare case where one returns the result
of a complex sequence like:

 	return -b + sqrt(-b*4.0*a*c)/2.0*a;

This should remain:

 	return (-b + sqrt(-b*4.0*a*c)/2.0*a);


...unlikely because we don't use floats in the kernel, but serves
as a readability example.


On Wed, 15 Dec 2004, Jesper Juhl wrote:

>
> Hi,
>
> I was wondering if patches to remove unnecessary parentheses from return
> statements would be accepted?
> 'return' is a statement, not a function, but still people write return(0);
> or return(i); or return(fn()); all over the place. Those parentheses are
> completely pointless (except for a few rare cases where they may make
> the code more readable, but that's the exception, not the rule).
>
> I have a bunch of files on my todo list for such cleanups and a few files
> already done and patches ready. Would they be welcome/accepted?
>
> The arguments for doing this are:
>
> 1) the parentheses are pointless.
> 2) removing the parentheses decreases source file size slightly (103
> bytes for the examle patch below).
> 3) they look odd and when reading code you don't want to be stopped
> wondering - no parentheses is simply more readable (at least to me).
> 4) When I've submitted patches for other stuff in the past I've a few
> times been asked if I couldn't fix up the return statements while I was at
> it - so it seems to be wanted.
>
>
> The arguments against doing it are:
>
> 1) it doesn't matter for the object file, the source will build to the
> exact same object file regardless of the parentheses.
> 2) poeple should be allowed to use whatever coding style they please in
> this regard.
>
>
> Just to show an example I'm submitting my patch for
> drivers/char/stallion.c below. This is one of the bigger offenders, and
> it's not even internally consistent since it uses both  return(foo);  and
> return foo;  in different places.
> If patches like this are welcome, then I'd suggest adding a small bit to
> Documentation/CodingStyle mentioning that parentheses on return statements
> are generally not wanted without a good reason (correctness or
> readabillity) - that would hopefully prevent me or someone else having to
> do this again :-)
>
>
> Comments?
>
>
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>
> diff -up linux-2.6.10-rc3-bk8-orig/drivers/char/stallion.c linux-2.6.10-rc3-bk8/drivers/char/stallion.c
> --- linux-2.6.10-rc3-bk8-orig/drivers/char/stallion.c	2004-12-06 22:24:28.000000000 +0100
> +++ linux-2.6.10-rc3-bk8/drivers/char/stallion.c	2004-12-15 20:34:06.000000000 +0100
> @@ -754,7 +754,7 @@ static int __init stallion_module_init(v
> 	stl_init();
> 	restore_flags(flags);
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -909,7 +909,7 @@ static unsigned long stl_atol(char *str)
> 		}
> 		val = (val * base) + c;
> 	}
> -	return(val);
> +	return val;
> }
>
> /*****************************************************************************/
> @@ -928,7 +928,7 @@ static int stl_parsebrd(stlconf_t *confp
> #endif
>
> 	if ((argp[0] == (char *) NULL) || (*argp[0] == 0))
> -		return(0);
> +		return 0;
>
> 	for (sp = argp[0], i = 0; ((*sp != 0) && (i < 25)); sp++, i++)
> 		*sp = TOLOWER(*sp);
> @@ -940,7 +940,7 @@ static int stl_parsebrd(stlconf_t *confp
> 	}
> 	if (i >= nrbrdnames) {
> 		printk("STALLION: unknown board name, %s?\n", argp[0]);
> -		return(0);
> +		return 0;
> 	}
>
> 	confp->brdtype = stl_brdstr[i].type;
> @@ -956,7 +956,7 @@ static int stl_parsebrd(stlconf_t *confp
> 	}
> 	if ((argp[i] != (char *) NULL) && (*argp[i] != 0))
> 		confp->irq = stl_atol(argp[i]);
> -	return(1);
> +	return 1;
> }
>
> #endif
> @@ -969,7 +969,7 @@ static int stl_parsebrd(stlconf_t *confp
>
> static void *stl_memalloc(int len)
> {
> -	return((void *) kmalloc(len, GFP_KERNEL));
> +	return (void *) kmalloc(len, GFP_KERNEL);
> }
>
> /*****************************************************************************/
> @@ -986,12 +986,12 @@ static stlbrd_t *stl_allocbrd(void)
> 	if (brdp == (stlbrd_t *) NULL) {
> 		printk("STALLION: failed to allocate memory (size=%d)\n",
> 			sizeof(stlbrd_t));
> -		return((stlbrd_t *) NULL);
> +		return (stlbrd_t *) NULL;
> 	}
>
> 	memset(brdp, 0, sizeof(stlbrd_t));
> 	brdp->magic = STL_BOARDMAGIC;
> -	return(brdp);
> +	return brdp;
> }
>
> /*****************************************************************************/
> @@ -1011,10 +1011,10 @@ static int stl_open(struct tty_struct *t
> 	minordev = tty->index;
> 	brdnr = MINOR2BRD(minordev);
> 	if (brdnr >= stl_nrbrds)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	brdp = stl_brds[brdnr];
> 	if (brdp == (stlbrd_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	minordev = MINOR2PORT(minordev);
> 	for (portnr = -1, panelnr = 0; (panelnr < STL_MAXPANELS); panelnr++) {
> 		if (brdp->panels[panelnr] == (stlpanel_t *) NULL)
> @@ -1026,11 +1026,11 @@ static int stl_open(struct tty_struct *t
> 		minordev -= brdp->panels[panelnr]->nrports;
> 	}
> 	if (portnr < 0)
> -		return(-ENODEV);
> +		return -ENODEV;
>
> 	portp = brdp->panels[panelnr]->ports[portnr];
> 	if (portp == (stlport_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
>
> /*
>  *	On the first open of the device setup the port hardware, and
> @@ -1044,7 +1044,7 @@ static int stl_open(struct tty_struct *t
> 		if (portp->tx.buf == (char *) NULL) {
> 			portp->tx.buf = (char *) stl_memalloc(STL_TXBUFSIZE);
> 			if (portp->tx.buf == (char *) NULL)
> -				return(-ENOMEM);
> +				return -ENOMEM;
> 			portp->tx.head = portp->tx.buf;
> 			portp->tx.tail = portp->tx.buf;
> 		}
> @@ -1066,8 +1066,8 @@ static int stl_open(struct tty_struct *t
> 	if (portp->flags & ASYNC_CLOSING) {
> 		interruptible_sleep_on(&portp->close_wait);
> 		if (portp->flags & ASYNC_HUP_NOTIFY)
> -			return(-EAGAIN);
> -		return(-ERESTARTSYS);
> +			return -EAGAIN;
> +		return -ERESTARTSYS;
> 	}
>
> /*
> @@ -1077,11 +1077,11 @@ static int stl_open(struct tty_struct *t
>  */
> 	if (!(filp->f_flags & O_NONBLOCK)) {
> 		if ((rc = stl_waitcarrier(portp, filp)) != 0)
> -			return(rc);
> +			return rc;
> 	}
> 	portp->flags |= ASYNC_NORMAL_ACTIVE;
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -1138,7 +1138,7 @@ static int stl_waitcarrier(stlport_t *po
> 	portp->openwaitcnt--;
> 	restore_flags(flags);
>
> -	return(rc);
> +	return rc;
> }
>
> /*****************************************************************************/
> @@ -1234,12 +1234,12 @@ static int stl_write(struct tty_struct *
>
> 	if ((tty == (struct tty_struct *) NULL) ||
> 	    (stl_tmpwritebuf == (char *) NULL))
> -		return(0);
> +		return 0;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(0);
> +		return 0;
> 	if (portp->tx.buf == (char *) NULL)
> -		return(0);
> +		return 0;
>
> /*
>  *	If copying direct from user space we must cater for page faults,
> @@ -1278,7 +1278,7 @@ static int stl_write(struct tty_struct *
> 	clear_bit(ASYI_TXLOW, &portp->istate);
> 	stl_startrxtx(portp, -1, 1);
>
> -	return(count);
> +	return count;
> }
>
> /*****************************************************************************/
> @@ -1359,16 +1359,16 @@ static int stl_writeroom(struct tty_stru
> #endif
>
> 	if (tty == (struct tty_struct *) NULL)
> -		return(0);
> +		return 0;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(0);
> +		return 0;
> 	if (portp->tx.buf == (char *) NULL)
> -		return(0);
> +		return 0;
>
> 	head = portp->tx.head;
> 	tail = portp->tx.tail;
> -	return((head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1));
> +	return ((head >= tail) ? (STL_TXBUFSIZE - (head - tail) - 1) : (tail - head - 1));
> }
>
> /*****************************************************************************/
> @@ -1393,19 +1393,19 @@ static int stl_charsinbuffer(struct tty_
> #endif
>
> 	if (tty == (struct tty_struct *) NULL)
> -		return(0);
> +		return 0;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(0);
> +		return 0;
> 	if (portp->tx.buf == (char *) NULL)
> -		return(0);
> +		return 0;
>
> 	head = portp->tx.head;
> 	tail = portp->tx.tail;
> 	size = (head >= tail) ? (head - tail) : (STL_TXBUFSIZE - (tail - head));
> 	if ((size == 0) && test_bit(ASYI_TXBUSY, &portp->istate))
> 		size = 1;
> -	return(size);
> +	return size;
> }
>
> /*****************************************************************************/
> @@ -1470,7 +1470,7 @@ static int stl_setserial(stlport_t *port
> 		    (sio.close_delay != portp->close_delay) ||
> 		    ((sio.flags & ~ASYNC_USR_MASK) !=
> 		    (portp->flags & ~ASYNC_USR_MASK)))
> -			return(-EPERM);
> +			return -EPERM;
> 	}
>
> 	portp->flags = (portp->flags & ~ASYNC_USR_MASK) |
> @@ -1480,7 +1480,7 @@ static int stl_setserial(stlport_t *port
> 	portp->closing_wait = sio.closing_wait;
> 	portp->custom_divisor = sio.custom_divisor;
> 	stl_setport(portp, portp->tty->termios);
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -1490,12 +1490,12 @@ static int stl_tiocmget(struct tty_struc
> 	stlport_t	*portp;
>
> 	if (tty == (struct tty_struct *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	if (tty->flags & (1 << TTY_IO_ERROR))
> -		return(-EIO);
> +		return -EIO;
>
> 	return stl_getsignals(portp);
> }
> @@ -1507,12 +1507,12 @@ static int stl_tiocmset(struct tty_struc
> 	int rts = -1, dtr = -1;
>
> 	if (tty == (struct tty_struct *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	if (tty->flags & (1 << TTY_IO_ERROR))
> -		return(-EIO);
> +		return -EIO;
>
> 	if (set & TIOCM_RTS)
> 		rts = 1;
> @@ -1540,15 +1540,15 @@ static int stl_ioctl(struct tty_struct *
> #endif
>
> 	if (tty == (struct tty_struct *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	portp = tty->driver_data;
> 	if (portp == (stlport_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
>
> 	if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
>  	    (cmd != COM_GETPORTSTATS) && (cmd != COM_CLRPORTSTATS)) {
> 		if (tty->flags & (1 << TTY_IO_ERROR))
> -			return(-EIO);
> +			return -EIO;
> 	}
>
> 	rc = 0;
> @@ -1589,7 +1589,7 @@ static int stl_ioctl(struct tty_struct *
> 		break;
> 	}
>
> -	return(rc);
> +	return rc;
> }
>
> /*****************************************************************************/
> @@ -1895,7 +1895,7 @@ static int stl_portinfo(stlport_t *portp
> 		pos[(MAXLINE - 2)] = '+';
> 	pos[(MAXLINE - 1)] = '\n';
>
> -	return(MAXLINE);
> +	return MAXLINE;
> }
>
> /*****************************************************************************/
> @@ -1980,7 +1980,7 @@ static int stl_readproc(char *page, char
>
> stl_readdone:
> 	*start = page;
> -	return(pos - page);
> +	return (pos - page);
> }
>
> /*****************************************************************************/
> @@ -2201,7 +2201,7 @@ static int __init stl_mapirq(int irq, ch
> 			stl_gotintrs[stl_numintrs++] = irq;
> 		}
> 	}
> -	return(rc);
> +	return rc;
> }
>
> /*****************************************************************************/
> @@ -2253,7 +2253,7 @@ static int __init stl_initports(stlbrd_t
> 		stl_portinit(brdp, panelp, portp);
> 	}
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -2296,7 +2296,7 @@ static inline int stl_initeio(stlbrd_t *
> 		    (stl_vecmap[brdp->irq] == (unsigned char) 0xff)) {
> 			printk("STALLION: invalid irq=%d for brd=%d\n",
> 				brdp->irq, brdp->brdnr);
> -			return(-EINVAL);
> +			return -EINVAL;
> 		}
> 		outb((stl_vecmap[brdp->irq] | EIO_0WS |
> 			((brdp->irqtype) ? EIO_INTLEVEL : EIO_INTEDGE)),
> @@ -2307,7 +2307,7 @@ static inline int stl_initeio(stlbrd_t *
> 		printk(KERN_WARNING "STALLION: Warning, board %d I/O address "
> 			"%x conflicts with another device\n", brdp->brdnr,
> 			brdp->ioaddr1);
> -		return(-EBUSY);
> +		return -EBUSY;
> 	}
>
> 	if (brdp->iosize2 > 0)
> @@ -2319,7 +2319,7 @@ static inline int stl_initeio(stlbrd_t *
> 				"releasing board %d I/O address %x \n",
> 				brdp->brdnr, brdp->ioaddr1);
> 			release_region(brdp->ioaddr1, brdp->iosize1);
> -        		return(-EBUSY);
> +        		return -EBUSY;
> 		}
>
> /*
> @@ -2351,11 +2351,11 @@ static inline int stl_initeio(stlbrd_t *
> 			brdp->nrports = 16;
> 			break;
> 		default:
> -			return(-ENODEV);
> +			return -ENODEV;
> 		}
> 		break;
> 	default:
> -		return(-ENODEV);
> +		return -ENODEV;
> 	}
>
> /*
> @@ -2367,7 +2367,7 @@ static inline int stl_initeio(stlbrd_t *
> 	if (panelp == (stlpanel_t *) NULL) {
> 		printk(KERN_WARNING "STALLION: failed to allocate memory "
> 			"(size=%d)\n", sizeof(stlpanel_t));
> -		return(-ENOMEM);
> +		return -ENOMEM;
> 	}
> 	memset(panelp, 0, sizeof(stlpanel_t));
>
> @@ -2390,7 +2390,7 @@ static inline int stl_initeio(stlbrd_t *
> 	brdp->state |= BRD_FOUND;
> 	brdp->hwid = status;
> 	rc = stl_mapirq(brdp->irq, name);
> -	return(rc);
> +	return rc;
> }
>
> /*****************************************************************************/
> @@ -2427,12 +2427,12 @@ static inline int stl_initech(stlbrd_t *
> 		brdp->iostatus = brdp->ioaddr1 + 1;
> 		status = inb(brdp->iostatus);
> 		if ((status & ECH_IDBITMASK) != ECH_ID)
> -			return(-ENODEV);
> +			return -ENODEV;
> 		if ((brdp->irq < 0) || (brdp->irq > 15) ||
> 		    (stl_vecmap[brdp->irq] == (unsigned char) 0xff)) {
> 			printk("STALLION: invalid irq=%d for brd=%d\n",
> 				brdp->irq, brdp->brdnr);
> -			return(-EINVAL);
> +			return -EINVAL;
> 		}
> 		status = ((brdp->ioaddr2 & ECH_ADDR2MASK) >> 1);
> 		status |= (stl_vecmap[brdp->irq] << 1);
> @@ -2453,12 +2453,12 @@ static inline int stl_initech(stlbrd_t *
> 		brdp->iostatus = brdp->ioctrl;
> 		status = inb(brdp->iostatus);
> 		if ((status & ECH_IDBITMASK) != ECH_ID)
> -			return(-ENODEV);
> +			return -ENODEV;
> 		if ((brdp->irq < 0) || (brdp->irq > 15) ||
> 		    (stl_vecmap[brdp->irq] == (unsigned char) 0xff)) {
> 			printk("STALLION: invalid irq=%d for brd=%d\n",
> 				brdp->irq, brdp->brdnr);
> -			return(-EINVAL);
> +			return -EINVAL;
> 		}
> 		outb(ECHMC_BRDRESET, brdp->ioctrl);
> 		outb(ECHMC_INTENABLE, brdp->ioctrl);
> @@ -2485,7 +2485,7 @@ static inline int stl_initech(stlbrd_t *
>
> 	default:
> 		printk("STALLION: unknown board type=%d\n", brdp->brdtype);
> -		return(-EINVAL);
> +		return -EINVAL;
> 		break;
> 	}
>
> @@ -2497,7 +2497,7 @@ static inline int stl_initech(stlbrd_t *
> 		printk(KERN_WARNING "STALLION: Warning, board %d I/O address "
> 			"%x conflicts with another device\n", brdp->brdnr,
> 			brdp->ioaddr1);
> -		return(-EBUSY);
> +		return -EBUSY;
> 	}
>
> 	if (brdp->iosize2 > 0)
> @@ -2509,7 +2509,7 @@ static inline int stl_initech(stlbrd_t *
> 				"releasing board %d I/O address %x \n",
> 				brdp->brdnr, brdp->ioaddr1);
> 			release_region(brdp->ioaddr1, brdp->iosize1);
> -			return(-EBUSY);
> +			return -EBUSY;
> 		}
>
> /*
> @@ -2595,7 +2595,7 @@ static inline int stl_initech(stlbrd_t *
>
> 	brdp->state |= BRD_FOUND;
> 	i = stl_mapirq(brdp->irq, name);
> -	return(i);
> +	return i;
> }
>
> /*****************************************************************************/
> @@ -2629,7 +2629,7 @@ static int __init stl_brdinit(stlbrd_t *
> 	default:
> 		printk("STALLION: board=%d is unknown board type=%d\n",
> 			brdp->brdnr, brdp->brdtype);
> -		return(ENODEV);
> +		return ENODEV;
> 	}
>
> 	stl_brds[brdp->brdnr] = brdp;
> @@ -2637,7 +2637,7 @@ static int __init stl_brdinit(stlbrd_t *
> 		printk("STALLION: %s board not found, board=%d io=%x irq=%d\n",
> 			stl_brdnames[brdp->brdtype], brdp->brdnr,
> 			brdp->ioaddr1, brdp->irq);
> -		return(ENODEV);
> +		return ENODEV;
> 	}
>
> 	for (i = 0; (i < STL_MAXPANELS); i++)
> @@ -2648,7 +2648,7 @@ static int __init stl_brdinit(stlbrd_t *
> 		"nrpanels=%d nrports=%d\n", stl_brdnames[brdp->brdtype],
> 		brdp->brdnr, brdp->ioaddr1, brdp->irq, brdp->nrpanels,
> 		brdp->nrports);
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -2665,10 +2665,10 @@ static inline int stl_getbrdnr(void)
> 		if (stl_brds[i] == (stlbrd_t *) NULL) {
> 			if (i >= stl_nrbrds)
> 				stl_nrbrds = i + 1;
> -			return(i);
> +			return i;
> 		}
> 	}
> -	return(-1);
> +	return -1;
> }
>
> /*****************************************************************************/
> @@ -2691,13 +2691,13 @@ static inline int stl_initpcibrd(int brd
> #endif
>
> 	if (pci_enable_device(devp))
> -		return(-EIO);
> +		return -EIO;
> 	if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
> -		return(-ENOMEM);
> +		return -ENOMEM;
> 	if ((brdp->brdnr = stl_getbrdnr()) < 0) {
> 		printk("STALLION: too many boards found, "
> 			"maximum supported %d\n", STL_MAXBRDS);
> -		return(0);
> +		return 0;
> 	}
> 	brdp->brdtype = brdtype;
>
> @@ -2736,7 +2736,7 @@ static inline int stl_initpcibrd(int brd
> 	brdp->irq = devp->irq;
> 	stl_brdinit(brdp);
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -2769,10 +2769,10 @@ static inline int stl_findpcibrds(void)
>
> 			rc = stl_initpcibrd(stl_pcibrds[i].brdtype, dev);
> 			if (rc)
> -				return(rc);
> +				return rc;
> 		}
>
> -	return(0);
> +	return 0;
> }
>
> #endif
> @@ -2811,7 +2811,7 @@ static inline int stl_initbrds(void)
> 		stl_parsebrd(confp, stl_brdsp[i]);
> #endif
> 		if ((brdp = stl_allocbrd()) == (stlbrd_t *) NULL)
> -			return(-ENOMEM);
> +			return -ENOMEM;
> 		brdp->brdnr = i;
> 		brdp->brdtype = confp->brdtype;
> 		brdp->ioaddr1 = confp->ioaddr1;
> @@ -2832,7 +2832,7 @@ static inline int stl_initbrds(void)
> 	stl_findpcibrds();
> #endif
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -2850,10 +2850,10 @@ static int stl_getbrdstats(combrd_t __us
> 	if (copy_from_user(&stl_brdstats, bp, sizeof(combrd_t)))
> 		return -EFAULT;
> 	if (stl_brdstats.brd >= STL_MAXBRDS)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	brdp = stl_brds[stl_brdstats.brd];
> 	if (brdp == (stlbrd_t *) NULL)
> -		return(-ENODEV);
> +		return -ENODEV;
>
> 	memset(&stl_brdstats, 0, sizeof(combrd_t));
> 	stl_brdstats.brd = brdp->brdnr;
> @@ -2887,18 +2887,18 @@ static stlport_t *stl_getport(int brdnr,
> 	stlpanel_t	*panelp;
>
> 	if ((brdnr < 0) || (brdnr >= STL_MAXBRDS))
> -		return((stlport_t *) NULL);
> +		return (stlport_t *) NULL;
> 	brdp = stl_brds[brdnr];
> 	if (brdp == (stlbrd_t *) NULL)
> -		return((stlport_t *) NULL);
> +		return (stlport_t *) NULL;
> 	if ((panelnr < 0) || (panelnr >= brdp->nrpanels))
> -		return((stlport_t *) NULL);
> +		return (stlport_t *) NULL;
> 	panelp = brdp->panels[panelnr];
> 	if (panelp == (stlpanel_t *) NULL)
> -		return((stlport_t *) NULL);
> +		return (stlport_t *) NULL;
> 	if ((portnr < 0) || (portnr >= panelp->nrports))
> -		return((stlport_t *) NULL);
> -	return(panelp->ports[portnr]);
> +		return (stlport_t *) NULL;
> +	return panelp->ports[portnr];
> }
>
> /*****************************************************************************/
> @@ -2920,7 +2920,7 @@ static int stl_getportstats(stlport_t *p
> 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
> 			stl_comstats.port);
> 		if (portp == (stlport_t *) NULL)
> -			return(-ENODEV);
> +			return -ENODEV;
> 	}
>
> 	portp->stats.state = portp->istate;
> @@ -2975,7 +2975,7 @@ static int stl_clrportstats(stlport_t *p
> 		portp = stl_getport(stl_comstats.brd, stl_comstats.panel,
> 			stl_comstats.port);
> 		if (portp == (stlport_t *) NULL)
> -			return(-ENODEV);
> +			return -ENODEV;
> 	}
>
> 	memset(&portp->stats, 0, sizeof(comstats_t));
> @@ -3021,7 +3021,7 @@ static int stl_getbrdstruct(stlbrd_t __u
> 		return -ENODEV;
> 	brdp = stl_brds[stl_dummybrd.brdnr];
> 	if (!brdp)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	return copy_to_user(arg, brdp, sizeof(stlbrd_t)) ? -EFAULT : 0;
> }
>
> @@ -3045,7 +3045,7 @@ static int stl_memioctl(struct inode *ip
>
> 	brdnr = iminor(ip);
> 	if (brdnr >= STL_MAXBRDS)
> -		return(-ENODEV);
> +		return -ENODEV;
> 	rc = 0;
>
> 	switch (cmd) {
> @@ -3069,7 +3069,7 @@ static int stl_memioctl(struct inode *ip
> 		break;
> 	}
>
> -	return(rc);
> +	return rc;
> }
>
> static struct tty_operations stl_ops = {
> @@ -3151,7 +3151,7 @@ int __init stl_init(void)
> 		return -1;
> 	}
>
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -3167,7 +3167,7 @@ int __init stl_init(void)
> static int stl_cd1400getreg(stlport_t *portp, int regnr)
> {
> 	outb((regnr + portp->uartaddr), portp->ioaddr);
> -	return(inb(portp->ioaddr + EREG_DATA));
> +	return inb(portp->ioaddr + EREG_DATA);
> }
>
> static void stl_cd1400setreg(stlport_t *portp, int regnr, int value)
> @@ -3181,9 +3181,9 @@ static int stl_cd1400updatereg(stlport_t
> 	outb((regnr + portp->uartaddr), portp->ioaddr);
> 	if (inb(portp->ioaddr + EREG_DATA) != value) {
> 		outb(value, portp->ioaddr + EREG_DATA);
> -		return(1);
> +		return 1;
> 	}
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -3241,7 +3241,7 @@ static int stl_cd1400panelinit(stlbrd_t
> 	}
>
> 	BRDDISABLE(panelp->brdnr);
> -	return(chipmask);
> +	return chipmask;
> }
>
> /*****************************************************************************/
> @@ -3592,7 +3592,7 @@ static int stl_cd1400getsignals(stlport_
> #else
> 	sigs |= TIOCM_DSR;
> #endif
> -	return(sigs);
> +	return sigs;
> }
>
> /*****************************************************************************/
> @@ -3865,9 +3865,9 @@ static int stl_cd1400datastate(stlport_t
> #endif
>
> 	if (portp == (stlport_t *) NULL)
> -		return(0);
> +		return 0;
>
> -	return(test_bit(ASYI_TXBUSY, &portp->istate) ? 1 : 0);
> +	return test_bit(ASYI_TXBUSY, &portp->istate) ? 1 : 0;
> }
>
> /*****************************************************************************/
> @@ -3947,20 +3947,20 @@ static inline int stl_cd1400breakisr(stl
> 		outb((SRER + portp->uartaddr), ioaddr);
> 		outb((inb(ioaddr + EREG_DATA) & ~(SRER_TXDATA | SRER_TXEMPTY)),
> 			(ioaddr + EREG_DATA));
> -		return(1);
> +		return 1;
> 	} else if (portp->brklen > 1) {
> 		outb((TDR + portp->uartaddr), ioaddr);
> 		outb(ETC_CMD, (ioaddr + EREG_DATA));
> 		outb(ETC_STOPBREAK, (ioaddr + EREG_DATA));
> 		portp->brklen = -1;
> -		return(1);
> +		return 1;
> 	} else {
> 		outb((COR2 + portp->uartaddr), ioaddr);
> 		outb((inb(ioaddr + EREG_DATA) & ~COR2_ETC),
> 			(ioaddr + EREG_DATA));
> 		portp->brklen = 0;
> 	}
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -4212,7 +4212,7 @@ static void stl_cd1400mdmisr(stlpanel_t
> static int stl_sc26198getreg(stlport_t *portp, int regnr)
> {
> 	outb((regnr | portp->uartaddr), (portp->ioaddr + XP_ADDR));
> -	return(inb(portp->ioaddr + XP_DATA));
> +	return inb(portp->ioaddr + XP_DATA);
> }
>
> static void stl_sc26198setreg(stlport_t *portp, int regnr, int value)
> @@ -4226,9 +4226,9 @@ static int stl_sc26198updatereg(stlport_
> 	outb((regnr | portp->uartaddr), (portp->ioaddr + XP_ADDR));
> 	if (inb(portp->ioaddr + XP_DATA) != value) {
> 		outb(value, (portp->ioaddr + XP_DATA));
> -		return(1);
> +		return 1;
> 	}
> -	return(0);
> +	return 0;
> }
>
> /*****************************************************************************/
> @@ -4240,7 +4240,7 @@ static int stl_sc26198updatereg(stlport_
> static int stl_sc26198getglobreg(stlport_t *portp, int regnr)
> {
> 	outb(regnr, (portp->ioaddr + XP_ADDR));
> -	return(inb(portp->ioaddr + XP_DATA));
> +	return inb(portp->ioaddr + XP_DATA);
> }
>
> #if 0
> @@ -4298,7 +4298,7 @@ static int stl_sc26198panelinit(stlbrd_t
> 	}
>
> 	BRDDISABLE(panelp->brdnr);
> -	return(chipmask);
> +	return chipmask;
> }
>
> /*****************************************************************************/
> @@ -4592,7 +4592,7 @@ static int stl_sc26198getsignals(stlport
> 	sigs |= (ipr & IPR_DTR) ? 0: TIOCM_DTR;
> 	sigs |= (ipr & IPR_RTS) ? 0: TIOCM_RTS;
> 	sigs |= TIOCM_DSR;
> -	return(sigs);
> +	return sigs;
> }
>
> /*****************************************************************************/
> @@ -4874,9 +4874,9 @@ static int stl_sc26198datastate(stlport_
> #endif
>
> 	if (portp == (stlport_t *) NULL)
> -		return(0);
> +		return 0;
> 	if (test_bit(ASYI_TXBUSY, &portp->istate))
> -		return(1);
> +		return 1;
>
> 	save_flags(flags);
> 	cli();
> @@ -4885,7 +4885,7 @@ static int stl_sc26198datastate(stlport_
> 	BRDDISABLE(portp->brdnr);
> 	restore_flags(flags);
>
> -	return((sr & SR_TXEMPTY) ? 0 : 1);
> +	return (sr & SR_TXEMPTY) ? 0 : 1;
> }
>
> /*****************************************************************************/
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
