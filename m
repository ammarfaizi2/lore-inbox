Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTBBBaX>; Sat, 1 Feb 2003 20:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTBBBaX>; Sat, 1 Feb 2003 20:30:23 -0500
Received: from maila.telia.com ([194.22.194.231]:40689 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S265096AbTBBBaW>;
	Sat, 1 Feb 2003 20:30:22 -0500
X-Original-Recipient: linux-kernel@vger.kernel.org
Message-ID: <001501c2ca5b$f4b45990$020120b0@jockeXP>
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
References: <004701c2ca03$cb467460$020120b0@jockeXP> <3E3C0684.4010806@pobox.com>
Subject: Re: NETIF_F_SG question
Date: Sun, 2 Feb 2003 02:39:41 +0100
Organization: Lumentis AB
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Joakim Tjernlund wrote:
> > I am thinking of implementing harware scatter/gatter support( NETIF_F_SG) in my 
> > ethernet driver. The network device cannot do HW checksuming.
> > 
> > Will the IP stack make use of the SG support and will there be any significant performance
> > improvement?
> 
> 
> No; you need HW checksumming for NETIF_F_SG to be useful.
> 
> If HW checksumming is not available, scatter-gather is useless, because 
> the net stack must always make a pass over the data to checksum it. 
> Since it must do that, it can linearize the skb at the same time, 
> eliminating the need for SG.
> 
> Jeff

I think HW checksumming and SG are independent. Either one of them should
not require the other one in any context.

Zero copy sendfile() does not require HW checksum to do zero copy, right?
If HW checksum is present, then you get some extra performance as a bonus.

(hmm, one could make SG mandatory and the devices that don't support it can 
 implement it in their driver. Just an idea)

   Jocke
