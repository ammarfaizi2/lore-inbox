Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318367AbSHKVIs>; Sun, 11 Aug 2002 17:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318369AbSHKVIs>; Sun, 11 Aug 2002 17:08:48 -0400
Received: from [143.166.83.90] ([143.166.83.90]:11525 "HELO
	AUSADMMSRR503.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318367AbSHKVIr>; Sun, 11 Aug 2002 17:08:47 -0400
X-Server-Uuid: 91331657-2068-4fb8-8b09-a4fcbc1ed29f
Message-ID: <20BF5713E14D5B48AA289F72BD372D6821CB04@AUSXMPC122.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: andersen@codepoet.org, alan@lxorguk.ukuu.org.uk
cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: RE: Linux 2.4.20-pre1
Date: Sun, 11 Aug 2002 16:12:30 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 11480CB46837791-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > <alan@irongate.swansea.linux.org.uk> (02/08/05 1.629)
> > > > 	[PATCH] PATCH: Add EFI partition support
> > > 
> > > Needs this to compile....
> > > 
> > > --- linux/include/asm-ia64/efi.h.orig	Sun Aug 11 01:41:10 2002
> > > +++ linux/include/asm-ia64/efi.h	Sun Aug 11 01:43:38 2002
> > > @@ -166,6 +166,9 @@
> > >   *  EFI Configuration Table and GUID definitions
> > >   */e
56> > >  
> > > +#define NULL_GUID    \
> > > +    ((efi_guid_t) { 0x00000000, 0x0000, 0x0000, { 0x00, 
> 0x00, 0x0, 0x00, 0x00, 0x00, 0x00, 0x00 }})
> > > +
> > 
> > Not a good plan. EFI can be used on non ia64 so NULL_GUID belongs
> > somewhere else

Two things:
1) there is an accompanying patch to the EFI patch which adds NULL_GUID and
changes the definition of GUIDs to use the helper macro EFI_GUID to solve
endianness issues.  David Mosberger has blessed my submission of this, and
it's been in the ia64 port patch for many months.  Patch or cset:

http://domsch.com/linux/patches/gpt/linux-2.4.19-rc1-efiguidt.patch
http://domsch.com/linux/patches/gpt/linux-2.4-gpt-efiguidt.cset


2) Yes, it's ugly that fs/partitions/efi.c includes asm-ia64/efi.h to pick
up the definitions.  David told me 12-18 months ago that Linus didn't want
an include/linux/efi.h because only IA64 today uses it, even though nothing
in it is IA-64 specific - it *could* be made generic.  So, I had three
choices:
a) include asm-ia64/efi.h and comment (taken)
b) Move asm-ia64/efi.h to linux/efi.h (believed rejected)
c) Duplicate typedefs.

I'd be happy to submit a patch moving asm-ia64/efi.h into include/linux/ if
it would be accepted.

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

