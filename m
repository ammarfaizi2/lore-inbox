Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVCIAJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVCIAJk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 19:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262414AbVCIAE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 19:04:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:63121 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262415AbVCIACN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 19:02:13 -0500
Date: Tue, 8 Mar 2005 16:02:02 -0800
From: Greg KH <greg@kroah.com>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309000202.GB11807@kroah.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E2@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E2@minimail.digi.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:47:45PM -0600, Kilau, Scott wrote:
> > Who needs to know if a port is open or not?
> >
> <snipped some code> 
> >
> > +static ssize_t jsm_tty_baud_show(struct class_device *class_dev, char *buf)
> 
> > No, please delete these, and the other sysfs files that duplicate the
> > same info that you can get by using the standard Linux termios calls.
> > There is no need for them here.
> 
> Our serial port monitoring tools need to know these things, and to
> find them out *without* opening up the serial port to do an ioctl().
> 
> For example, lets say a customer has a modem connected to a serial port.
> 
> If you were to open up the port with an "stty -a" to get the current 
> settings and signals, you would unintentionally raise RTS and DTR.

Why not fix the driver to not change the current line settings if it is
not being opened for the first time?  That seems like a much simpler way
to solve this, and probably the saner way, as you don't want any user to
be able to mess up your modem...

thanks,

greg k-h
