Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967159AbWKYUmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967159AbWKYUmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967174AbWKYUmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:42:20 -0500
Received: from nz-out-0102.google.com ([64.233.162.205]:6214 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S967159AbWKYUmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:42:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NvpQl78fIsF/t5fnZq/vdCPgzsWeR9IT01sOl0IHStlu5Z9xZRu4qqYn1sRAd4C1sl+UwcOTg4kC6B2nkQv8HvC7JSEaOiktddiKAAExe0u7JY/pil59lKBS/YtXeJomLqP0gTVk5+kDbH3vczUrWNfsfr4hysN+A6ajwy5vNN4=
Message-ID: <234fa2210611251242g2497f9bby2a3bf867324b73b3@mail.gmail.com>
Date: Sat, 25 Nov 2006 21:42:18 +0100
From: "Ilyes Gouta" <ilyes.gouta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [USB] urb->number_of_packets = 256 !
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm working on a driver for my USB 2.0 high-speed webcam under Linux
and I'm using a tool
called usbsnoop, which was designed for Windows, to get an idea on the exchanged
information between the host and the webcam. By examining the produced
trace file, I found
that my PC is sending a bunch of isochronous URBs to the webcam where
each one contains
256 isochronous packets and each packet is 3072 bytes wide. This means
that every URB
points to a 256 * 3072 bytes sized buffer.

Here is an excerpt of the trace file:

[21303 ms]  >>>  URB 1640 going down  >>>
-- URB_FUNCTION_ISOCH_TRANSFER:
  PipeHandle           = ff27dd8c [endpoint 0x00000081]
  TransferFlags        = 00000005 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK,
USBD_START_ISO_TRANSFER_ASAP
  TransferBufferLength = 000c0000
  TransferBuffer       = fd319100
  TransferBufferMDL    = 00000000
  StartFrame           = 00000000
  NumberOfPackets      = 00000100 // in hex
  IsoPacket[0].Offset = 0
  IsoPacket[0].Length = 0
  IsoPacket[1].Offset = 3072
  IsoPacket[1].Length = 0
  IsoPacket[2].Offset = 6144
  IsoPacket[2].Length = 0

I tried to program this behavior in my custom, alpha stage, kernel
driver, however I was
disappointed since Linux fails to allocate, using kmalloc(), such a
huge buffer (which is
quite normal actually) to associated to the URB through the
transfer_buffer field. I also
tried __get_free_pages(GFP_KERNEL, 10) without any success whatsoever.

Splitting the transfer across multiple URB doesn't seem to work (I didn't really
investigate in depth this possibility).

Any ideas?

Thanks for your time!

P.S: Is it possible to CC me since I didn't subscribe to the mailing
list? Thanks!

Best regards,
Ilyes Gouta.
