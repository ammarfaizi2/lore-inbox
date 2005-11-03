Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVKCJhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVKCJhZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 04:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVKCJhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 04:37:25 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:64625 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbVKCJhY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 04:37:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=guJ5mS/Idna3/tpLr94dt6+b1NlaexEkBENIuj1t3HNSmJWUFfK4C9fK2iEWApcZVpUsM7psQvQGJeoif8Qi7LqZ0R/RdyUyepR0/W5gdYxMXumNVFtA7w7rRuspCBo29PieqHl4h5vW4pF1RnP5jsp7pVE1lnRpAqgh30HAVVg=
Message-ID: <1ffb4b070511030137o345049d2o5ed5e020c96e022d@mail.gmail.com>
Date: Thu, 3 Nov 2005 17:37:21 +0800
From: Mike Lee <eemike@gmail.com>
To: stephen@streetfiresound.com
Subject: Re: [PATCH/RFC] simple SPI controller on PXA2xx SSP port, refresh
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1130870131.10324.51.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <435ec45a.j4jWbfXLISIZdYJa%stephen@streetfiresound.com>
	 <1ffb4b070510270433t2d45cd5cwe71705f7aeddb283@mail.gmail.com>
	 <1130431260.22836.19.camel@localhost.localdomain>
	 <1ffb4b070510291125j1fad2362xe40843f7719c611d@mail.gmail.com>
	 <1130870131.10324.51.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi stephen

On 11/2/05, Stephen Street <stephen@streetfiresound.com> wrote:
> On Sun, 2005-10-30 at 02:25 +0800, Mike Lee wrote:
> > Also, in your pxa_spi driver, you always read before write in the
> > interrupt handler. If rx and tx is pointing to the same buffer,
> > reading data will always overwrite the tx data. why not write before
> > read?
> See above. Must write to read.
I found that i misunderstand your coding. i got your idea.

> I never found any documentation on the net, usually the data-sheet for
> the chip you are talking to specifies the SPI requirements (master,
> slave, clocks, chip selects, etc). Can you send me a link to the chip?
>
It is too bad that no good reference document for development.
I am now using i.MX Soc which is ARM920 core and embedded 2 SPI bus.
You can download the datasheet from freescale web site.

Actually, i am now available to use your loopback driver on my SPI
controller driver. But only limited to PIO mode, and i get stuck on
DMA mode because of trigger problem of SPI module, I am now trying
very hard to solve that.

In my driver, there is a little bug that i could not rmmod the driver.
it will stop at unregistering device. Below is a debug msg dump. it
seem to stop at down_write(&device_subsys.rwsem) in device_del
------------------------------------------------------------
/mnt/tmpfs/tmp # insmod imx_spi.ko
bus platform: add driver imx-spi
CLASS: registering class device: ID = 'spi1'
imx-spi imx-spi.0: registered master spi1
 spi1.1-loopback: setup finish
DEV: registering device: ID = 'spi1.1-loopback'
bus spi: add device spi1.1-loopback
imx-spi imx-spi.0: registered child spi1.1-loopback
bound device 'imx-spi.0' to driver 'imx-spi'
CLASS: registering class device: ID = 'spi2'
imx-spi imx-spi.1: registered master spi2
bound device 'imx-spi.1' to driver 'imx-spi'
/mnt/tmpfs/tmp # rmmod imx_spi.ko
bus platform: remove driver imx-spi
DEV: Unregistering device. ID = 'spi1.1-loopback'

------------------------------------------------------------


Some question on SPI subsystem:
I really get confused on the structure on the whole system. e.g. the
platform_data and controller_data in board_info.  What are thier
purposes?
Also i found that spi_register_board_info is declared as __init, that
mean i can not register board info as a module, is it because there is
no 'real' probe on SPI bus? (this comsume me time to reflash my board
to debug)
I know that SDIO could have a SPI mode. Could SPI subsystem be used to
control SDIO device?

Sorry for my annoying questions.

Thanks for helping
Mike,Lee
