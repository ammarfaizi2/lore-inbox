Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264740AbSJPBuo>; Tue, 15 Oct 2002 21:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbSJPBuo>; Tue, 15 Oct 2002 21:50:44 -0400
Received: from services.cam.org ([198.73.180.252]:50048 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S264740AbSJPBug>;
	Tue, 15 Oct 2002 21:50:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.x opps stopping serial
Date: Tue, 15 Oct 2002 21:50:39 -0400
User-Agent: KMail/1.4.3
References: <3DA683F4.944DFC11@digeo.com> <200210110845.24687.tomlins@cam.org> <20021015230733.E7702@flint.arm.linux.org.uk>
In-Reply-To: <20021015230733.E7702@flint.arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Paul Larson <plars@linuxtestproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210152150.39162.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 15, 2002 06:07 pm, Russell King wrote:
> On Fri, Oct 11, 2002 at 08:45:24AM -0400, Ed Tomlinson wrote:
> > I have been seeing this during shutdown ever since I started using 2.5.
> > Figured I really should report it...   There are three serial ports.
> > One for a serial console, the second for a backUPS ups, the third for
> > a (real) modem.  Dist is debian sid.
>
> Can you try this patch please?  It prevents the hangup code from
> setting info->tty to NULL while we're trying to open the port.

This fails to fix the problem (2.5.42-mm2) patch applied...

Oct 15 21:15:39 oscar -- MARK --
Oct 15 21:26:32 oscar kernel:  printing eip:
Oct 15 21:26:32 oscar kernel: c0192b23
Oct 15 21:26:32 oscar kernel: Oops: 0000
Oct 15 21:26:32 oscar kernel: af_packet snd-seq-midi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss sn
d-cs46xx snd-pcm snd-timer snd-rawmidi snd-seq-device snd-ac97-codec snd soundcore gameport softdog matroxfb_base matrox
fb_g450 matroxfb_DAC1064 g450_pll matroxfb_accel matroxfb_misc fbcon-cfb16 fbcon-cfb8 fbcon-cfb24 fbcon-cfb32 mga agpgar
t pppoe pppox ipchains msdos fat sd_mod floppy dummy bsd_comp ppp_generic slhc parport_pc lp parport ipip smbfs nls_cp85
0 nls_cp437 binfmt_aout autofs4 cdrom via-rhine mii tulip crc32 usb-storage scsi_mod pl2303 usbserial hid
Oct 15 21:26:32 oscar kernel: CPU:    0
Oct 15 21:26:32 oscar kernel: EIP:    0060:[uart_open+147/544]    Not tainted
Oct 15 21:26:32 oscar kernel: EFLAGS: 00010246
Oct 15 21:26:32 oscar kernel: EIP is at uart_block_til_ready+0x15b/0x1a4
Oct 15 21:26:32 oscar kernel: eax: 00000000   ebx: da040000   ecx: dffe381c   edx: c15da294
Oct 15 21:26:32 oscar kernel: esi: da041e84   edi: 00000202   ebp: c15da240   esp: da041e58
Oct 15 21:26:32 oscar kernel: ds: 0068   es: 0068   ss: 0068
Oct 15 21:26:32 oscar kernel: Process bkupsd (pid: 897, threadinfo=da040000 task=da316dc0)
Oct 15 21:26:32 oscar kernel: Stack: c02863c0 da084000 c15da240 00000000 c0358724 dffe381c 00000000 da316dc0
Oct 15 21:26:32 oscar kernel:        c0110ea8 00000000 00000000 00000000 da316dc0 c0110ea8 c15da294 c15da294
Oct 15 21:26:32 oscar kernel:        c0192e19 da3018c0 c15da240 00000000 00000100 00000000 deffd214 da040000
Oct 15 21:26:32 oscar kernel: Call Trace:
Oct 15 21:26:32 oscar kernel:  [default_wake_function+0/44] default_wake_function+0x0/0x2c
Oct 15 21:26:32 oscar kernel:  [default_wake_function+0/44] default_wake_function+0x0/0x2c
Oct 15 21:26:32 oscar kernel:  [uart_line_info+325/804] uart_open+0x1d9/0x220
Oct 15 21:26:32 oscar kernel:  [tty_open+918/924] tty_open+0x1e6/0x39c
Oct 15 21:26:32 oscar kernel:  [tty_release+43/92] tty_open+0x217/0x39c
Oct 15 21:26:32 oscar kernel:  [unregister_chrdev+1/176] get_chrfops+0xa1/0x164
Oct 15 21:26:32 oscar kernel:  [get_empty_filp+83/420] chrdev_open+0x5b/0x94
Oct 15 21:26:32 oscar kernel:  [get_unused_fd+237/392] dentry_open+0xb9/0x16c
Oct 15 21:26:32 oscar kernel:  [get_unused_fd+43/392] filp_open+0x43/0x4c
Oct 15 21:26:32 oscar kernel:  [sys_vhangup+40/48] sys_open+0x34/0x70
Oct 15 21:26:32 oscar kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 15 21:26:32 oscar kernel:
Oct 15 21:26:32 oscar kernel: Code: f6 80 14 01 00 00 02 75 34 8b 44 24 44 50 e8 aa 6b 00 00 83
Oct 15 21:26:38 oscar pppd[646]: Terminating on signal 15.

Ideas?
Ed Tomlinson

>
> --- orig/drivers/serial/core.c	Sat Oct 12 10:01:59 2002
> +++ linux/drivers/serial/core.c	Tue Oct 15 23:00:50 2002
> @@ -22,7 +22,7 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 
> USA *
> - *  $Id: core.c,v 1.100 2002/07/28 10:03:28 rmk Exp $
> + *  $Id: core.c,v 1.106 2002/08/02 12:55:07 rmk Exp $
>   *
>   */
>  #include <linux/config.h>
> @@ -207,7 +207,7 @@
>  			 * Setup the RTS and DTR signals once the
>  			 * port is open and ready to respond.
>  			 */
> -			if (info->tty->termios->c_cflag & CBAUD)
> +			if (info->tty && info->tty->termios->c_cflag & CBAUD)
>  				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
>  		}
>
> @@ -1196,13 +1271,13 @@
>  	}
>  	down(&port_sem);
>  	uart_shutdown(info);
> -	up(&port_sem);
>  	uart_flush_buffer(tty);
>  	if (tty->ldisc.flush_buffer)
>  		tty->ldisc.flush_buffer(tty);
>  	tty->closing = 0;
>  	info->event = 0;
>  	info->tty = NULL;
> +	up(&port_sem);
>  	if (info->blocked_open) {
>  		if (info->state->close_delay) {
>  			set_current_state(TASK_INTERRUPTIBLE);
> @@ -1357,6 +1432,10 @@
>  	}
>  }
>
> +/*
> + * Block the open until the port is ready.  We must be called with
> + * port_sem held.
> + */
>  static int
>  uart_block_til_ready(struct file *filp, struct uart_info *info)
>  {
> @@ -1374,7 +1453,7 @@
>  		/*
>  		 * If we have been hung up, tell userspace/restart open.
>  		 */
> -		if (tty_hung_up_p(filp))
> +		if (tty_hung_up_p(filp) || info->tty == NULL)
>  			break;
>
>  		/*
> @@ -1422,7 +1501,9 @@
>  			break;
>
>  	 wait:
> +		up(&port_sem);
>  		schedule();
> +		down(&port_sem);
>
>  		if (signal_pending(current))
>  			break;
> @@ -1436,10 +1517,7 @@
>  	if (signal_pending(current))
>  		return -ERESTARTSYS;
>
> -	if (info->tty->flags & (1 << TTY_IO_ERROR))
> -		return 0;
> -
> -	if (tty_hung_up_p(filp) || !(info->flags & UIF_INITIALIZED))
> +	if (!info->tty || tty_hung_up_p(filp))
>  		return (port->flags & UPF_HUP_NOTIFY) ?
>  			-EAGAIN : -ERESTARTSYS;
>
> @@ -1451,7 +1529,6 @@
>  	struct uart_state *state = drv->state + line;
>  	struct uart_info *info = NULL;
>
> -	down(&port_sem);
>  	if (!state->port)
>  		goto out;
>
> @@ -1480,7 +1557,6 @@
>  	}
>
>   out:
> -	up(&port_sem);
>  	return info;
>  }
>
> @@ -1527,10 +1603,18 @@
>  	/*
>  	 * FIXME: This one isn't fun.  We can't guarantee that the tty isn't
>  	 * already in open, nor can we guarantee the state of tty->driver_data
> +	 *
> +	 * We take the semaphore here to guarantee that we won't be re-entered
> +	 * while allocating the info structure, or while we request any IRQs
> +	 * that the driver may need.  This also has the nice side-effect that
> +	 * it delays the action of uart_hangup, so we can guarantee that
> +	 * info->tty will always contain something reasonable.
>  	 */
> +	down(&port_sem);
>  	info = uart_get(drv, line);
>  	retval = -ENOMEM;
>  	if (!info) {
> +		up(&port_sem);
>  		if (tty->driver_data)
>  			goto fail;
>  		else
> @@ -1543,6 +1627,7 @@
>  	 * Any failures from here onwards should not touch the count.
>  	 */
>  	tty->driver_data = info;
> +	tty->alt_speed = 0;
>  	info->tty = tty;
>  	info->tty->low_latency = (info->port->flags & UPF_LOW_LATENCY) ? 1 : 0;
>
> @@ -1550,6 +1635,7 @@
>  	 * If the port is in the middle of closing, bail out now.
>  	 */
>  	if (tty_hung_up_p(filp) || (info->flags & UIF_CLOSING)) {
> +		up(&port_sem);
>  	    	wait_event_interruptible(info->open_wait,
>  					 !(info->flags & UIF_CLOSING));
>  		retval = (info->port->flags & UPF_HUP_NOTIFY) ?
> @@ -1571,20 +1657,16 @@
>  	}
>
>  	/*
> -	 * Start up the serial port.  We have this semaphore here to
> -	 * prevent uart_startup or uart_shutdown being re-entered if
> -	 * we sleep while requesting an IRQ.
> +	 * Start up the serial port.
>  	 */
> -	down(&port_sem);
>  	retval = uart_startup(info, 0);
> -	up(&port_sem);
> -	if (retval)
> -		goto fail;
>
>  	/*
> -	 * Wait until the port is ready.
> +	 * If we succeeded, wait until the port is ready.
>  	 */
> -	retval = uart_block_til_ready(filp, info);
> +	if (retval == 0)
> +		retval = uart_block_til_ready(filp, info);
> +	up(&port_sem);
>
>  	/*
>  	 * If this is the first open to succeed, adjust things to suit.

