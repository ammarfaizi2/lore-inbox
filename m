Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbQLBJt1>; Sat, 2 Dec 2000 04:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129831AbQLBJtR>; Sat, 2 Dec 2000 04:49:17 -0500
Received: from adsl-151-200-27-41.dc.adsl.bellatlantic.net ([151.200.27.41]:21508
	"EHLO tatooine.casagrau.org") by vger.kernel.org with ESMTP
	id <S129764AbQLBJtG>; Sat, 2 Dec 2000 04:49:06 -0500
Date: Sat, 2 Dec 2000 04:18:33 -0500
From: Federico Grau <donfede@casagrau.org>
To: linux-kernel@vger.kernel.org
Cc: jdow@earthlink.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: rocketport pci question... it stopped working after 250 days uptime
Message-ID: <20001202041832.A1060@casagrau.org>
In-Reply-To: <20001129213933.A5309@casagrau.org> <E141KNy-0006mA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <E141KNy-0006mA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 30, 2000 at 03:27:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, 

I have another box which has had the same failure (rocketport serial ports
stoped working after 248 days and 16 hours).  I have about 2 more hours before
I need to reboot the box and get it back into production.

I have both a working and non-working example, where I have re-compiled and
re-loaded the rocketport module with the debugging info turned on.


On my working example:
    # when I load the module the init function gets called
        int rp_init(void)   

    # when I cat from the tty device the open function gets called
        static int rp_open(struct tty_struct *tty, struct file * filp) #
    
    # then somehow automagically the rp_handle_port() gets called by
    # rp_do_poll()... and data gets read
        void rp_handle_port(struct r_port *info)
        static void rp_do_poll(void)

On my non-working example:
    # the init and the open seem to hapen fine, however the rp_do_poll() never
    # gets called?!


I see that in rp_init(), rp_do_poll() gets saved to a "structure" called
"timer_table[COMTROL_TIMER].fn = rp_do_poll;", however I have yet to find what
that is.


Where else could I look to find the problem?

I am working with kernel 2.2.14 (/usr/src/linux/drivers/char/rocket.c), which
except for two lines is the same in 2.2.17.  I am not yet subscribed to the
kernel list, so please cc responses to me.

Thanks,
donfede

On Thu, Nov 30, 2000 at 03:27:49AM +0000, Alan Cox wrote:
> > These three boxes had similar uptimes (since their last kernel rebuild); 249
> > days, 248 days, 250 days.  Comparing the logs of each box, we saw that each
> > box's rocketport stopped working after aproximately 248 days 16 hours uptime.
> > So, my questions are:
> >  - has anyone heard of such a bug before?
> 
> Yes. Someone is doing signed maths on time stamps (2^31 1/100th of a second)
> 
> Ted ?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
