Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSEVPIF>; Wed, 22 May 2002 11:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315634AbSEVPIF>; Wed, 22 May 2002 11:08:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:13842 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315595AbSEVPID>; Wed, 22 May 2002 11:08:03 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: pavel@suse.cz (Pavel Machek)
Date: Wed, 22 May 2002 16:27:33 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        akpm@zip.com.au (Andrew Morton), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020522144236.GA2357@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at May 22, 2002 04:42:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AY1V-00021R-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > must return PAGE_SIZE on an error. What it seems to say is that it if an error
> > is reported then no data got written down the actual pipe itself. Putting
> > 4K into the pipe then reporting Esomething is not allowed. Copying 4K into
> > a buffer faulting and erroring with Efoo then throwing away the buffer is
> > allowed
> 
> So... Is copy_to_user allowed to copy more than it actually reported?
> Because if so, it might return 0/-EFAULT as well ;-).

The specification defines the API not the implementation. It only matters if
the user can't tell. 0/-EFAULT would be wrong as that is EOF. 0/0 or
-1/Efoo.
