Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270817AbUKARCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270817AbUKARCy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270697AbUKARCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:02:54 -0500
Received: from mikonos.cyclades.com.br ([200.230.227.67]:44813 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S271187AbUKARBS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:01:18 -0500
From: "germano.barreiro" <germano.barreiro@cyclades.com.br>
To: Greg KH <greg@kroah.com>
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <1099328490.41866bead2525@200.246.93.2>
Date: Mon, 01 Nov 2004 14:01:30 -0300 (EST)
Cc: Germano Barreiro <germano.barreiro@cyclades.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Wanda Rosalino <wanda.rosalino@cyclades.com>
References: <1098989790.6605.3.camel@germano.cyclades.com> <20041030044056.GB1907@kroah.com>
In-Reply-To: <20041030044056.GB1907@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.5-cvs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

Firstly, very thanks again you for your comments. I think I understood them and
I will check the driver you pointed as an example.

Kind regards, 
Germano 



Cópia Greg KH <greg@kroah.com>:

> On Thu, Oct 28, 2004 at 04:56:30PM -0200, Germano Barreiro wrote:
> > Hi
> > 
> > This patch implements the sysfs support in the cyclades async driver,
> > which is needed by the Cyclades' CyMonitor application. It is based
> in
> > the last one sent (see copied message below), but implements the
> changes
> > asked for that patch by Greg (the array of attributes was eliminated
> and
> > now there is only one file for each value to be exported).
> > I hope it is ok to be applied now, but if more changes are needed I
> > would be pleased to listen about them. By the way, I'm grateful to
> > Marcelo for taking time to examining many "middle" versions of this
> > patch, and also to Greg for his comments to the last patch.
> 
> Close, it's getting better, but you still have a ways to go...
> 
> > --- linux-2.6.10rc1.orig/drivers/char/cyclades.c	2004-10-25
> 16:40:00.000000000 -0200
> > +++ linux-2.6.10rc1/drivers/char/cyclades.c	2004-10-26
> 17:13:20.000000000 -0200
> > @@ -646,6 +646,7 @@ static char rcsid[] =
> >  #include <linux/string.h>
> >  #include <linux/fcntl.h>
> >  #include <linux/ptrace.h>
> > +#include <linux/device.h>
> >  #include <linux/cyclades.h>
> >  #include <linux/mm.h>
> >  #include <linux/ioport.h>
> > @@ -700,8 +701,36 @@ static void cy_send_xchar (struct tty_st
> >  
> >  #define	JIFFIES_DIFF(n, j)	((j) - (n))
> >  
> > +static char _version[150];
> >  static struct tty_driver *cy_serial_driver;
> >  
> > +
> > +const static char
> sysufixes[18][10]={"stat","card","baud","flow","rxfl","txfl","dcd","dsr","cts",
> > +                                    
> "rts","dtr","rx","tx","bdrx","bdtx","par","stop","chlen"};
> 
> Ick, this isn't needed.
> 
> > +ssize_t (*showfunctions[])(struct device *, char *)={
> > +	show_sys_stat,
> > +	show_sys_card,
> > +	show_sys_baud,
> > +	show_sys_flow,
> > +	show_sys_rxfl,
> > +	show_sys_txfl,
> > +	show_sys_dcd,
> > +	show_sys_dsr,
> > +	show_sys_cts,
> > +	show_sys_rts,
> > +	show_sys_dtr,
> > +	show_sys_rx,
> > +	show_sys_tx,
> > +	show_sys_bdrx,
> > +	show_sys_bdtx,
> > +	show_sys_par,
> > +	show_sys_stop,
> > +	show_sys_chlen
> > +};
> 
> Why not just do as the i2c chip drivers do?  Use a macro for your
> show functions, it's much simpler.
> 
> > +        switch(whatinfo){
> > +
> > +		case STAT: //open/closed
> 
> Break this big switch statement up into the individual show functions.
> Hm, ok, you can't use a macro for them then, sorry.  But it should be
> simpler.
> 
> > +			if ( tty == 0 ) 
> > +				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_close);
> > +			else
> > +				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_open);
> 
> No, don't put the %s: stuff in there.  The user read from the "stat"
> file.  They know what the value should be, you don't have to remind
> them
> again :)
> 
> thanks,
> 
> greg k-h
> 
