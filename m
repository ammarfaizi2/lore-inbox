Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVHDMQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVHDMQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVHDMQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:16:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:24721 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262505AbVHDMOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:14:21 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] cpqfc: fix for "Using too much stach" in 2.6 kernel
Date: Thu, 4 Aug 2005 15:13:51 +0300
User-Agent: KMail/1.5.4
Cc: "Saripalli, Venkata Ramanamurthy (STSD)" <saripalli@hp.com>,
       linux-scsi@vger.kernel.org, axboe@suse.de
References: <4221C1B21C20854291E185D1243EA8F302623BCC@bgeexc04.asiapacific.cpqcorp.net> <200508041138.38216@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508041138.38216@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041513.51692.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 August 2005 12:38, Rolf Eike Beer wrote:
> Saripalli, Venkata Ramanamurthy (STSD) wrote:
> >Patch 1 of 2
> >
> >This patch fixes the "#error this is too much stack" in 2.6 kernel.
> >Using kmalloc to allocate memory to ulFibreFrame.
> 
> Good idea.
> 
> >Please consider this for inclusion
> 
> Your patch is line-wrapped and can't be applied. Your second patch is also 
> line wrapped. And it touches this file in a different way so they can't be 
> applied cleanly over each other.
> 
> >diff -burpN old/drivers/scsi/cpqfcTScontrol.c
> >new/drivers/scsi/cpqfcTScontrol.c
> >--- old/drivers/scsi/cpqfcTScontrol.c	2005-07-12 22:52:29.000000000
> >+0530
> >+++ new/drivers/scsi/cpqfcTScontrol.c	2005-07-18 22:19:54.229947176
> >+0530
> >@@ -606,22 +606,25 @@ static int PeekIMQEntry( PTACHYON fcChip
> >         if( (fcChip->IMQ->QEntry[CI].type & 0x1FF) == 0x104 )
> >         {
> >           TachFCHDR_GCMND* fchs;
> >-#error This is too much stack
> >-          ULONG ulFibreFrame[2048/4];  // max DWORDS in incoming FC
> >Frame
> >+          ULONG *ulFibreFrame;  // max DWORDS in incoming FC Frame
> > 	  USHORT SFQpi = (USHORT)(fcChip->IMQ->QEntry[CI].word[0] &
> >0x0fffL);
> 
> Why not use a void* here as type for the buffer? Or even better: remove this 
> at all and directly use fchs as target, because this is the only place where 
> this buffer goes to?
> 
> >+	  ulFibreFrame = kmalloc((2048/4), GFP_KERNEL);
> 
> The size bug was already found by Dave Jones. This never should be written 
> this way (not your fault). The array should have been [2048/sizeof(ULONG)].

Also you need to check for NULL return.
--
vda 

