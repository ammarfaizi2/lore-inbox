Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVLSQjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVLSQjA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 11:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVLSQjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 11:39:00 -0500
Received: from posthamster.phnxsoft.com ([195.227.45.4]:39688 "EHLO
	posthamster.phnxsoft.com") by vger.kernel.org with ESMTP
	id S964828AbVLSQi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 11:38:59 -0500
Message-ID: <43A6E209.5030406@imap.cc>
Date: Mon, 19 Dec 2005 17:38:33 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; de-AT; rv:1.7.8) Gecko/20050511
X-Accept-Language: de, en, fr
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Hansjoerg Lipp <hjlipp@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] isdn4linux: add drivers for Siemens Gigaset ISDN
 DECT PABX
References: <20051212181356.GC15361@hjlipp.my-fqdn.de>
In-Reply-To: <20051212181356.GC15361@hjlipp.my-fqdn.de>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigED018F3738785C75CC14C4C7"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED018F3738785C75CC14C4C7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit

Hello Stephen,

thank you very much for your review and your comments.

On Mon, 12 Dec 2005 09:41:38 -0800, you wrote:

> Networking drivers belong on the netdev@vger.kernel.org list

The Gigaset driver isn't in fact a networking driver; but if you think
it's appropriate to CC the netdev list anyway then we'll be glad to do
so when we'll resubmit it with the modifications prompted by the
comments we received so far.

> One of the principles of drivers, which is often overlooked
> is to use existing infrastructure for debugging and interfaces and not invent
> driver specific versions.

Quite so. We're happy to use existing infrastructure wherever
available. Thanks for pointing out some of it we had overlooked.

[Following quotes edited for brevity]

>> --- linux-2.6.14/drivers/isdn/gigaset/gigaset.h	1970-01-01 01:00:00.000000000 +0100
>> +++ linux-2.6.14-gig/drivers/isdn/gigaset/gigaset.h	2005-12-11 13:21:42.000000000 +0100

>> +enum debuglevel { /* up to 24 bits (atomic_t) */
>> +	DEBUG_REG	  = 0x0002, /* serial port I/O register operations */
>> +	DEBUG_OPEN	  = 0x0004, /* open/close serial port */
>> +	DEBUG_INTR	  = 0x0008, /* interrupt processing */
>> +	DEBUG_INTR_DUMP   = 0x0010, /* Activating hexdump debug output on interrupt
>> +				      requests, not available as run-time option */
>> +	DEBUG_CMD	  = 0x00020, /* sent/received LL commands */
>> +	DEBUG_STREAM	  = 0x00040, /* application data stream I/O events */
>> +	DEBUG_STREAM_DUMP = 0x00080, /* application data stream content */
>> +	DEBUG_LLDATA	  = 0x00100, /* sent/received LL data */
>> +	DEBUG_INTR_0	  = 0x00200, /* serial port output interrupt processing */
>> +	DEBUG_DRIVER	  = 0x00400, /* driver structure */
>> +	DEBUG_HDLC	  = 0x00800, /* M10x HDLC processing */
>> +	DEBUG_WRITE	  = 0x01000, /* M105 data write */
>> +	DEBUG_TRANSCMD    = 0x02000, /*AT-COMMANDS+RESPONSES*/
>> +	DEBUG_MCMD        = 0x04000, /*COMMANDS THAT ARE SENT VERY OFTEN*/
>> +	DEBUG_INIT	  = 0x08000, /* (de)allocation+initialization of data structures */
>> +	DEBUG_LOCK	  = 0x10000, /* semaphore operations */
>> +	DEBUG_OUTPUT	  = 0x20000, /* output to device */
>> +	DEBUG_ISO         = 0x40000, /* isochronous transfers */
>> +	DEBUG_IF	  = 0x80000, /* character device operations */
>> +	DEBUG_USBREQ	  = 0x100000, /* USB communication (except payload data) */
>> +	DEBUG_LOCKCMD     = 0x200000, /* AT commands and responses when MS_LOCKED */
>> +
>> +	DEBUG_ANY	  = 0x3fffff, /* print message if any of the others is activated */
>> +};
>
> Use existing netdevice message flag values?

Unfortunately these don't fit our needs, as we are not dealing with a
network device, but with an ISDN device.

>> +/* define our own syslog macros which add our module name to the message */
>> +/* The space before the comma in ", ##" is needed by gcc 2.95 */
>> +#undef info
>> +#define info(format, arg...) printk(KERN_INFO "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
>> +
>> +#undef notice
>> +#define notice(format, arg...) printk(KERN_NOTICE "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
>> +
>> +#undef warn
>> +#define warn(format, arg...) printk(KERN_WARNING "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
>> +
>> +#undef err
>> +#define err(format, arg...) printk(KERN_ERR "%s: " format "\n", THIS_MODULE ? THIS_MODULE->name : "gigaset_hw" , ## arg)
>> +
>> +#undef dbg
>
> Gack. Don't reinvent more debug infrastructure. If you still need this stuff
> use the existing macros in kernel.h

I couldn't find any existing macros of that kind in kernel.h, so I
assume you are referring to the ones in usb.h.

The usb.h versions of info(), warn() and err() macros prepend the
entire source file path to each message, which isn't appropriate for
our purpose of informing users or administrators (as opposed to kernel
hackers). The module name is much more informative for that audience.
Also, a notice() macro is missing entirely. In that situation, rather
than reinventing the whole set of macros with new names, or cluttering
our code by repeatedly writing them out in full, we decided on
modifying the existing macros as the most readable solution.

We will however rephrase the comment preceding these definitions in
order to clarify our reasons for doing this.

>> +struct proc_atomic {

This will be elliminated by the move to sysfs.

>> +struct at_state_t {
>> +	struct at_state_t       *next, *prev;
>
> Use list.h

Thanks for the hint. Will do.

>> +/* ===========================================================================
>> + *  Functions implemented in asyncdata.c
>> + */
>> +
>> +//FIXME this should not be included by the base driver
>
> Then fix it before submitting??

Um, no. As we couldn't find a fix which wasn't worse than the problem,
we've decided to just remove that FIXME note.

Generally, however, if all FIXMEs must be fixed before a driver may be
submitted then we'll have to continue maintaining our driver outside the
kernel for quite some time yet. IMHO such a requirement would clearly
contradict the spirit of Documentation/stable_api_nonsense.txt.

Of course, removing all FIXME notes would be a matter of a simple
editor command. But I do not think the community would be well served
by that. ;-)

>> --- linux-2.6.14/drivers/isdn/gigaset/interface.c	1970-01-01 01:00:00.000000000 +0100
>> +++ linux-2.6.14-gig/drivers/isdn/gigaset/interface.c	2005-12-11 13:21:42.000000000 +0100

>> +static struct tty_operations if_ops = {
>> +	.open =			if_open,
>> +	.close =		if_close,
>> +	.ioctl =		if_ioctl,
>> +	.write =		if_write,
>> +	.write_room =		if_write_room,
>> +	.chars_in_buffer =	if_chars_in_buffer,
>> +	.set_termios =		if_set_termios,
>> +	.throttle =		if_throttle,
>> +	.unthrottle =		if_unthrottle,
>> +#if 0
>> +	.break_ctl =		serial_break,
>> +#endif
>> +	.tiocmget =		if_tiocmget,
>> +	.tiocmset =		if_tiocmset,
>> +};
>
> Missing .owner = THIS_MODULE

It appears that in the kernel versions I have been working with,
struct tty_operations does not have a member "owner".

Thanks again for your time and effort. Your comments are appreciated.

Regards
Tilman

PS: Please keep me CCed on any replies.

--
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Ungeöffnet mindestens haltbar bis: (siehe Rückseite)

--------------enigED018F3738785C75CC14C4C7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDpuIXMdB4Whm86/kRAs1iAJ4pgbdoFrf8mXUaZz/mj4Cds2gpUwCeLGda
818YD9a/4w3Em07MPSsLJJs=
=0x+e
-----END PGP SIGNATURE-----

--------------enigED018F3738785C75CC14C4C7--
