Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSEUVYm>; Tue, 21 May 2002 17:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSEUVYl>; Tue, 21 May 2002 17:24:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23049 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316608AbSEUVYk>; Tue, 21 May 2002 17:24:40 -0400
Subject: Re: AUDIT: copy_from_user is a deathtrap.
To: pavel@suse.cz (Pavel Machek)
Date: Tue, 21 May 2002 22:44:42 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        rusty@rustcorp.com.au (Rusty Russell), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
In-Reply-To: <20020521211727.GG22878@atrey.karlin.mff.cuni.cz> from "Pavel Machek" at May 21, 2002 11:17:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17AHQw-0000Jq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So if you pass bad pointer to read(), why would you expect "number of
> bytes read" return? Its true that kernel can't simply not return

Because the standard says either you return the errorcode and no data
is transferred or for a partial I/O you return how much was done. Its
not neccessarily about accuracy either. If you do a 4k copy_from_user and
error after for some reason returning -Esomething thats fine providing you
didnt do anything that consumed data or shifted the file position etc
