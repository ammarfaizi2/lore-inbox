Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbTCYARZ>; Mon, 24 Mar 2003 19:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261302AbTCYARZ>; Mon, 24 Mar 2003 19:17:25 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:62479 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261300AbTCYARY>;
	Mon, 24 Mar 2003 19:17:24 -0500
Date: Mon, 24 Mar 2003 16:28:01 -0800
From: Greg KH <greg@kroah.com>
To: Kallol Biswas <kallol.biswas@efi.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: usb printer driver and zero length transfer
Message-ID: <20030325002801.GB10505@kroah.com>
References: <3E7F61D6.D1017E70@efi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7F61D6.D1017E70@efi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 11:51:50AM -0800, Kallol Biswas wrote:
> Hi,
>      I am new to USB world and looking for clarification on usb
> printer's
> behavior when transferring data with size  multiple of  wMaxPacketSize.
> 
> I have been running redhat 7.1 (linux kernel 2.4.2-2) on x86 PC with a
> USB 1.1 controller. There is a target mode printer driver running on the
> 
> other side.
> 
> On the host the device file is /dev/usb/lp0.
> If a data packet of 64 bytes is sent with
> 
> "cat data8 > /dev/usb/lp0" , the size of data8 is 64, a zero length
> packet
> at the end of the transfer is not sent.
> 
> Is this a correct behavior?  How do we force the printer driver send
> a zero length packet at the end of a transfer if the packet size is
> a multiple of wMAxPacketSize?

If your device requires that a zero length packet be send for this
situation, then modify the transfer flags of the urb with
URB_ZERO_PACKET to cause this to happen.

Hope this helps,

greg k-h
