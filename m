Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271200AbRHZBF6>; Sat, 25 Aug 2001 21:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271207AbRHZBFs>; Sat, 25 Aug 2001 21:05:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:57612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271200AbRHZBFh>; Sat, 25 Aug 2001 21:05:37 -0400
Subject: Re: [resent PATCH] Re: very slow parallel read performance
To: stoffel@casc.com (John Stoffel)
Date: Sun, 26 Aug 2001 02:07:23 +0100 (BST)
Cc: riel@conectiva.com.br (Rik van Riel), pcg@goof.com (Marc A. Lehmann),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        phillips@bonn-fries.net (Daniel Phillips),
        roger.larsson@skelleftea.mail.telia.com (Roger Larsson),
        linux-kernel@vger.kernel.org
In-Reply-To: <15240.18121.972361.669914@gargle.gargle.HOWL> from "John Stoffel" at Aug 25, 2001 08:46:01 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15aoOZ-0008Ul-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ummm... is this really more of an agreement that Daniel's used-once
> patch is a good idea on a system.  Keep a page around if it's used
> once, but drop it quickly if only used once?  But you seem to be

Is there a reason aging alone cannot do most of the work instead. When you
readahead a page you look to age a page that is a a bit over the readahead
window further back in the file if it is in memory, and has no mapped users
- ie its just cache.

That seems to cost us extra lookups in the page cache hashes but push things
in the right direction. 

Alan

