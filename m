Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDDTlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDDTlc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDDTlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:41:32 -0400
Received: from ida.rowland.org ([192.131.102.52]:4868 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S261352AbVDDTkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:40:31 -0400
Date: Mon, 4 Apr 2005 15:40:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-usb-users@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.11, USB: High latency?
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231DD@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0504041531350.1270-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Apr 2005, kus Kusche Klaus wrote:

> I asked our hardware team. The hardware has two devices which are
> in use and capable of busmaster/DMA transfers: 
> The intel e100 ethernet controller and the intel PIIX4 USB 
> controller. 
> The IDE interface is also a busmaster, but there are only PIO IDE
> devices.
> 
> I suspect the latter, as USB reads were running in parallel...
> How many bytes are transferred at most by the USB controller 
> for a single request? How long may this take?

Your questions aren't very clear.  The USB controller will do intermittent
DMA (once per millisecond) even when no USB transfers are pending, so long
as a USB device is attached.  When transfers are pending it will do as
much DMA as required to complete the transfers.  The amount of time
depends on the amount of data to be transferred and the speed at which the
device can provide/accept the data.  For Bulk transfers the DMA activity
is more or less continual.

> Any experiences / opinitions / advices?

I've had plenty of experience using USB, but none in measuring bus 
utilization.  However my guess is that the controller puts a fairly large 
load on the system.

Alan Stern

