Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283312AbRK2QYa>; Thu, 29 Nov 2001 11:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283310AbRK2QYW>; Thu, 29 Nov 2001 11:24:22 -0500
Received: from mhub-w2.tc.umn.edu ([160.94.160.45]:61160 "EHLO
	mhub-w2.tc.umn.edu") by vger.kernel.org with ESMTP
	id <S283305AbRK2QYK>; Thu, 29 Nov 2001 11:24:10 -0500
Date: Thu, 29 Nov 2001 10:24:08 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: Daniel Stodden <stodden@in.tum.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: where the hell is pci_read_config_xyz defined
Message-Id: <Pine.SOL.4.20.0111291022420.21308-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Nov 2001, Daniel Stodden wrote:
> i hope this question is not too stupid, but i think i've grepped all
> through it now.
> 
> i see the prototype in linux/pci.h
> i looked at i386/kernel/pci-pc.c. 
> i see the bios/direct access diversion. i don't see (*pci_config_read)()
> referenced elsewhere except within the acpi stuff.
> i looked at drivers/pci/*
> i even consulted lxr. nyet. nada.
> 
> giving up now. any hint would be greatly appreciated. am i blind?

This is a common question I think. Try looking for the following in
drivers/pci/pci.c:

#define PCI_OP(rw,size,type) \
int pci_##rw##_config_##size (struct pci_dev *dev, int pos, type value) \
{                                                                       \
	[ ... ]
}

PCI_OP(read, byte, u8 *)
PCI_OP(read, word, u16 *)
PCI_OP(read, dword, u32 *)
PCI_OP(write, byte, u8)
PCI_OP(write, word, u16)
PCI_OP(write, dword, u32)


Regards,

Grant Erickson


-- 
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

