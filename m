Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284727AbRLJVaA>; Mon, 10 Dec 2001 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbRLJV3u>; Mon, 10 Dec 2001 16:29:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:55053 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284704AbRLJV3l>; Mon, 10 Dec 2001 16:29:41 -0500
Subject: Re: [PATCH] 2.4.17-pre7: fdomain_16x0_release undeclared
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Mon, 10 Dec 2001 21:38:43 +0000 (GMT)
Cc: proski@gnu.org (Pavel Roskin), linux-kernel@vger.kernel.org,
        alan@redhat.com (Alan Cox)
In-Reply-To: <Pine.LNX.4.21.0112101800380.25397-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Dec 10, 2001 06:01:03 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16DY8J-0003Z7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Another partly related problem is a warning in fdomain.c:
> > 
> > fdomain.c: In function `fdomain_16x0_release':
> > fdomain.c:2045: warning: control reaches end of non-void function
> > 
> > I wonder if the patches that introduce warnings should be allowed in the 
> > stable branch?  Anyway, comparing with other SCSI drivers I see that 0 
> > should be returned and scsi_unregister(shpnt) should be called before 
> > that.

All the drivers I looked at return 1 and don't call scsi_unregister(shpnt).
Inspecting the core code shows that 

	1.	The return code is ignored (see I did test it worked 8))
	2.	scsi_unregister() is done by the core code for us

So I believe it simply needs a 

	return 1 

on the end
