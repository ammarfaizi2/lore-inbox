Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285453AbRLGKY4>; Fri, 7 Dec 2001 05:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLGKYr>; Fri, 7 Dec 2001 05:24:47 -0500
Received: from [195.63.194.11] ([195.63.194.11]:56850 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S285449AbRLGKYa>; Fri, 7 Dec 2001 05:24:30 -0500
Message-ID: <3C109668.E5818E11@evision-ventures.com>
Date: Fri, 07 Dec 2001 11:14:00 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <E16C3Kn-0002XC-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It's called "struct block_device" and "struct genhd". The pointers will
> > have as many bits as pointers have on the architecture. Low-level drivers
> > will not even see anything else eventually, there will be no "numbers".
> 
> For those of us who want to run a standards based operating system can
> you do the 32bit dev_t. Otherwise some slightly fundamental things don't
> work. You know boring stuff like ls, find, df, and other standard unix
> commands. Those export a dev_t cookie.

I don't think this is what Linus was talking about. The current problem
is that at many places the drivers (not the generic layer) know too
much about stuff, which should be handled entierly on the genric device
type layer. And changing this is actually a *prerequsite* to change
the type of dev_t.

For example please grep for the MINOR() macro in the scsi layer...
Most of the places where it's used should be replaced by a simple
driver instance enumerator. I did this once already, so this is for
sure.

> If you don't want to be able to run stuff like ls, just let me know and
> I'll start another kernel tree 8)
