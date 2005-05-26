Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVEZHqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEZHqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 03:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVEZHqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 03:46:19 -0400
Received: from imf23aec.mail.bellsouth.net ([205.152.59.71]:128 "EHLO
	imf23aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261251AbVEZHqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 03:46:08 -0400
Message-ID: <009501c561ce$610b3990$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
References: <1117044875.9510.2.camel@localhost> <Pine.LNX.4.60.0505252208120.25834@hermes-1.csi.cam.ac.uk> <courier.42956AFA.00002502@courier.cs.helsinki.fi> <20050526070437.GY29811@parcelfarce.linux.theplanet.co.uk>
Subject: Re: ntfs: remove redundant assignments
Date: Thu, 26 May 2005 04:39:00 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

---- Original Message ----- 
From: "Al Viro" <viro@parcelfarce.linux.theplanet.co.uk>
To: "Pekka J Enberg" <penberg@cs.helsinki.fi>
Cc: "Anton Altaparmakov" <aia21@cam.ac.uk>;
<linux-ntfs-dev@lists.sourceforge.net>; <linux-kernel@vger.kernel.org>
Sent: Thursday, May 26, 2005 03:04
Subject: Re: ntfs: remove redundant assignments


> On Thu, May 26, 2005 at 09:21:46AM +0300, Pekka J Enberg wrote:
> > On Wed, 2005-05-25 at 22:10 +0100, Anton Altaparmakov wrote:
> > >This is not.  memset(0) is not the same as = NULL IMO.  I don't care if
> > >the compiler thinks it is the same.  NULL does not have to be 0 so I
> > >prefer to initialize pointers explicitly to NULL.  Even more so since
this
> > >code is not performance critical at all so I prefer clarity here.

FWIW, a series of explicit assignments to zero puffs up the code on x86.
Several GCC releases using the default kernel -O2 build are too dumb to zero
EAX, or some other reg, and assign using it, so you're looking at 4 bytes of
immediate zero plus opcode ModRm/SIB.  If the locations being assigned
happened to be statics you can often wind up with a 10 byte instruction to
zero a single dword somewhere.

I have tried a few tricks trying to get GCC to not use this 4 byte immediate
0 in non speed critical areas all to no avail (ex. foo &= 0;  the AND
instruction can use a one byte sign extended operand, but GCC morphs
something like " &= 0" into a straight up "MOV thing,imm32" instruction)



