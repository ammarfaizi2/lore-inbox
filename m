Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267982AbTBMHXK>; Thu, 13 Feb 2003 02:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTBMHXK>; Thu, 13 Feb 2003 02:23:10 -0500
Received: from fmr01.intel.com ([192.55.52.18]:14591 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267982AbTBMHXI>;
	Thu, 13 Feb 2003 02:23:08 -0500
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: wingel@nano-systems.com, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <87n0l0olel.fsf@enki.rimspace.net>
References: <1045106216.1089.16.camel@vmhack> 
	<87n0l0olel.fsf@enki.rimspace.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Feb 2003 23:32:38 -0800
Message-Id: <1045121561.2326.27.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-02-12 at 20:27, Daniel Pittman wrote:
> On 12 Feb 2003, Rusty Lynch wrote:
> > The following is a proposal for a new sysfs based watchdog interface
> > to be used as a replacement for the current char device w/ ioctl api
> > as described in Documentation/watchdog-api.txt.
> 
> [...]
> 
> > Where each these files to the following ==>
> > 
> > start (RO)
> >   - show: starts watchdog count
> 
> This would be much better as a store -- that way 'cat /.../watchdog0/*'
> will not activate the watchdog. A more deliberate action is safer for
> forgetful admins, such as me.
> 

Sounds logical.  My reasoning was more of a coin toss.

> [...]
> 
> > status (RO)
> >   - show: prints the current status value
> > 
> > bootstatus (RO)
> >   - show: same as 'status', but valid for just after the last reboot.
> 
> [...]
> 
> > enable (RW)
> >   - show: prints 0 or 1 to indicate if the wdt is enabled
> >   - store: expects 0 or 1 to disable or enable the wdt
> 
> Isn't this the same information as the 'status' and 'start' members?
> 
>       Daniel

Now that think about it, enable really is the same as start/stop, but
the status is still something different.  I didn't really talk about it,
but my intent was to provide the information currently available from
the WDIOC_GETSTATUS ioctl, which is a value composed of the following
flags:

#define	WDIOF_OVERHEAT		0x0001	/* Reset due to CPU overheat */
#define	WDIOF_FANFAULT		0x0002	/* Fan failed */
#define	WDIOF_EXTERN1		0x0004	/* External relay 1 */
#define	WDIOF_EXTERN2		0x0008	/* External relay 2 */
#define	WDIOF_POWERUNDER	0x0010	/* Power bad/power fault */
#define	WDIOF_CARDRESET		0x0020	/* Card previously reset the CPU */
#define WDIOF_POWEROVER		0x0040	/* Power over voltage */
#define WDIOF_SETTIMEOUT	0x0080  /* Set timeout (in seconds) */
#define WDIOF_MAGICCLOSE	0x0100	/* Supports magic close char */
#define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */

I debated with myself if each of these flags should be broke out into
their own file, and I'm still not sure if it is better to keep the
status as a single file.

> 
> -- 
> A cathedral, a wave of a storm, a dancer's leap,
> never turn out to be as high as we had hoped.
>         -- Marcel Proust
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


