Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314449AbSD1Skq>; Sun, 28 Apr 2002 14:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSD1Skp>; Sun, 28 Apr 2002 14:40:45 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314449AbSD1Skp>; Sun, 28 Apr 2002 14:40:45 -0400
Subject: Re: Why HZ on i386 is 100 ?
To: george@mvista.com (george anzinger)
Date: Sun, 28 Apr 2002 19:59:25 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CCC32B5.1DF5EA5A@mvista.com> from "george anzinger" at Apr 28, 2002 10:34:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E171ttN-0004YP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We do anyway
> 
> Yes, but now we do all this in the timer tick, not in schedule().  This
> occures much less often.  

Well in the timer tick code we already hold the locks needed to check
the front of the timer queue safely, we already have current and the top 
timer needing to touch cache (current for accounting stats at the least).
So thats what an extra compare and cmov - 1 clock maybe 2 ?

