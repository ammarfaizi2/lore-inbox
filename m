Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262804AbSJRADr>; Thu, 17 Oct 2002 20:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJRADr>; Thu, 17 Oct 2002 20:03:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:5282 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S262804AbSJRADq>;
	Thu, 17 Oct 2002 20:03:46 -0400
Date: Thu, 17 Oct 2002 17:12:42 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Badari Pulavarty <pbadari@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.42 kernel BUG at drivers/base/core.c:251!
In-Reply-To: <200210151724.g9FHOI426577@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0210171707350.1038-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi. Sorry about the delay; I'm slowly wading through the last week's 
email.

> kernel BUG at drivers/base/core.c:251!
> invalid operand: 0000
> qla2200  
> CPU:    0
> EIP:    0060:[<c023eb24>]    Not tainted
> EFLAGS: 00010202
> EIP is at put_device+0x64/0x90
> eax: 00000000   ebx: f8a08028   ecx: f8a080c4   edx: 00000001
> esi: c3aded54   edi: f8a08000   ebp: 00000003   esp: cb007ee4
> ds: 0068   es: 0068   ss: 0068
> Process rmmod (pid: 4803, threadinfo=cb006000 task=f62c98c0)
> Stack: f8a08028 c0477a40 c02ce533 f8a08028 f8a08028 c0477b5c f8a08028 c0477b6c 
>        00000000 40153f6d 00000286 f68fc000 c0477a40 c3adec00 f4df0000 c02a7a9a 
>        c3adec00 cb007f30 00000002 00030002 00000001 08071002 c041685c 08070ffd 
> Call Trace:
>  [<c02ce533>] sg_detach+0x1e3/0x210

put_device() as a means to unregister a device should not be used any 
longer. There is a now a device_unregister() function that marks the 
device as !present, then decrements the reference count. Once the refcount 
hits 0, the device is cleaned up as before. 

The BUG() was added to catch people still using the wrong call. The SCSI 
patch that Mike Anderson posted last night should have this fixed in it.

	-pat


