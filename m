Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130723AbRCIVey>; Fri, 9 Mar 2001 16:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130722AbRCIVep>; Fri, 9 Mar 2001 16:34:45 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:17164 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S130704AbRCIVeZ>;
	Fri, 9 Mar 2001 16:34:25 -0500
Date: Fri, 9 Mar 2001 13:31:12 -0800
From: Greg KH <greg@kroah.com>
To: Erik DeBill <edebill@swbell.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 and ac13 breaks usb-visor
Message-ID: <20010309133112.A17792@kroah.com>
In-Reply-To: <E14aQA9-0001br-00@the-village.bc.nu> <20010307172056.A8647@austin.rr.com> <20010307173640.A14818@kroah.com> <20010308140103.A17993@austin.rr.com> <20010308160758.A16296@kroah.com> <20010309141332.A29339@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010309141332.A29339@austin.rr.com>; from edebill@swbell.net on Fri, Mar 09, 2001 at 02:13:32PM -0600
X-Operating-System: Linux 2.2.18-immunix (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2001 at 02:13:32PM -0600, Erik DeBill wrote:
> Nothing.  I've got the following in /etc/syslog.conf (which I believe
> SHOULD be correct), but I get absolutely nothing.
> 
> *.=debug;\
> 	auth,authpriv.none;\
> 	news.none;mail.none	/var/log/debug

Try adding an entry for kern.* like:
kern.*        -/var/log/kernel

> Until it's documented this is a landmine.  JE is the default USB
> driver, so you can bet that a great many people will be using it (even
> though it's described as "alternate").  Once it's fixed we just pull
> the warning from Config.help.

No, JE is _NOT_ the default USB UHCI driver, it doesn't say so in the
menu or anywhere.  It's just another option.

> This is the first time I've ever run across something like this in
> Linux that wasn't at least labelled "experimental".  Perhaps I've been
> leading a sheltered life.

Good point, I'll add something like your proposed patch for the visor
and other drivers that don't work with the JE driver.

> #
> # USB support
> #
> CONFIG_USB=y
> # CONFIG_USB_DEBUG is not set
> # CONFIG_USB_DEVICEFS is not set
> # CONFIG_USB_BANDWIDTH is not set
> CONFIG_USB_UHCI_ALT=y

This is your problem, DO NOT USE THIS DRIVER WITH THE VISOR!
set CONFIG_USB_UHCI=y and you should be fine.

Try that and let me know if you still have problems.

thanks,

greg k-h

-- 
greg@(kroah|wirex).com
