Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbUBXWeJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 17:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262504AbUBXWdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 17:33:42 -0500
Received: from mail.kroah.org ([65.200.24.183]:14789 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262503AbUBXWb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 17:31:29 -0500
Date: Tue, 24 Feb 2004 14:30:43 -0800
From: Greg KH <greg@kroah.com>
To: marcel cotta <mc123@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3 - Badness in pci_find_subsys at drivers/pci/search.c:167
Message-ID: <20040224223043.GA2455@kroah.com>
References: <403B7627.6080805@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403B7627.6080805@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 24, 2004 at 05:04:55PM +0100, marcel cotta wrote:
> i came across this while playing with hdparm
> 
> Call Trace:
>  [<c0264128>] pci_find_subsys+0xe8/0xf0
>  [<c026415f>] pci_find_device+0x2f/0x40
>  [<c02e5d89>] ide_system_bus_speed+0x69/0x90
>  [<c02e528e>] ali15x3_tune_drive+0x1e/0x250

Ugh, this is due to calling system_bus_clock() from within an interrupt.
Is there any good reason to do this?  Can't we just cache the bus speed
in the local device structure if we really have to do this from within
an interrupt?

thanks,

greg k-h
