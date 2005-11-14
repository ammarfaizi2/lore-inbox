Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbVKNUVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbVKNUVA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 15:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVKNUUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 15:20:42 -0500
Received: from mail-par.bigfish.com ([217.117.146.230]:59230 "EHLO
	mail4-par-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932101AbVKNUUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 15:20:35 -0500
X-BigFish: V
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [Question] PCI device memory management
Date: Mon, 14 Nov 2005 15:20:28 -0500
Message-ID: <18860D00A1C724419B900535DB985FB40161457E@torcaexmb2.atitech.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Question] PCI device memory management
Thread-Index: AcXnI925dXnlcNm9RVim0YHoROD0nQCMCwaw
From: "Alex Song" <asong@ati.com>
To: <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 14 Nov 2005 20:20:27.0107 (UTC) FILETIME=[D9D70B30:01C5E958]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The PCI device memory is shared by several hardware blocks, say, the
DSP, the video decoder, video overlay, etc. And these hardware blocks
are also on this PCI device. So I need to do some memory management over
the PCI device memory based on the hardware needs. A function like what
kmalloc does for system memory but must simpler, I think.

So, for example, the video decoder needs some memory to put its decoded
picture. Its driver calls this function to allocate some PCI device
memory, tells the decoder where the memory is and starts the decoder.
The decoder will decode MPEG2 stream and put the decoded picture in this
piece of PCI device memory. Other drivers are similar.

I guess request/release_region don't apply here cause the caller of
these functions knows exactly where the memory/io is.
Mapping to user space may also be necessary in our driver but I think
that's after we allocate a chunk of memory from this PCI device memory
space.

Hope this is clear.

Thanks a lot,

Alex




> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Deepak Saxena
> Sent: Friday, November 11, 2005 7:56 PM
> To: Alex Song
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [Question] PCI device memory management
> 
> On Nov 11 2005, at 16:53, Alex Song was caught saying:
> > Hi,
> > 
> > Our PCI device has a lot of memory and we have to provide memory 
> > management function for it.
> > 
> > Does kernel already have this mechanism in place?
> > 
> > Or we have to manage it on our own?
> 
> I'm guessing what you mean is that there is more memory on 
> the device then can be mapped in via the outbound window?  
> You will have to carve it up into chunks and map/unmap 
> regions as needed.
> Can you provide a bit more detail on what exactly you need to do?
> 
> ~Deepak
> 
> --
> Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net
> 
> When law and duty are one, united by religion, you never 
> become fully conscious, fully aware of yourself. You are 
> always a little less than an individual. - Frank Herbert
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

