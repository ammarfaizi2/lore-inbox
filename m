Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWFBWrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWFBWrw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 18:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbWFBWrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 18:47:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27063 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932581AbWFBWrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 18:47:51 -0400
Date: Fri, 2 Jun 2006 15:47:23 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: rmk@arm.linux.org.uk, gregkh@suse.de, linux-kernel@vger.kernel.org,
       lcapitulino@mandriva.com.br, linux-usb-devel@lists.sourceforge.net,
       zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-Id: <20060602154723.54704081.zaitcev@redhat.com>
In-Reply-To: <1149242609.4695.0.camel@pmac.infradead.org>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
	<1149242609.4695.0.camel@pmac.infradead.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 11:03:29 +0100, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2006-06-01 at 23:48 -0700, Pete Zaitcev wrote:
> > 
> > >  The tests I've done so far weren't anything serious: as the mobile supports a
> > > AT command set, I have used the ones (with minicom) which transfers more data.
> > > Of course that I also did module load/unload tests, tried to disconnect the
> > > device while it's transfering data and so on.
> > 
> > Next, it would be nice to test if PPP works, and if getty and shell work
> > (with getty driving the USB-to-serial adapter).
> 
> xmodem is a good test -- better than PPP because it stresses the
> buffering in a way which PPP won't. Log into a remote system, try
> sending and receiving files with xmodem.

I understand. My intent was different, however. One of the bigger sticking
points for usb-serial was its interaction with line disciplines, which are
notorious for looping back and requesting writes from callbacks
(e.g. h_hdlc.c). They are also sensitive to drivers lying about the
amount of free space in their FIFOs. This is something you never test
when driving a serial port from an application, no matter how cleverly
written.

-- Pete
