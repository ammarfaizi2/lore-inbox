Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbREZWfY>; Sat, 26 May 2001 18:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbREZWfO>; Sat, 26 May 2001 18:35:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:26891 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261230AbREZWfB>; Sat, 26 May 2001 18:35:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Sun, 27 May 2001 00:36:05 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105251300000V.06233@starship> <3B0F1DF9.238C01B9@gmx.de>
In-Reply-To: <3B0F1DF9.238C01B9@gmx.de>
MIME-Version: 1.0
Message-Id: <0105270036060Z.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 May 2001 05:07, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > Oops, oh wait, there's already another open point: your breakage
> > examples both rely on opening ".".  You're right, "." should always
> > be a directory and I believe that's enforced by the VFS.  So we
> > don't have an example of breakage yet.
>
> That's just because I did a simple "ls".  But it doesn't make a
> difference.  The magicdevs _are_ directories and
>
> 	chdir("magicdev");
> 	open(".", O_RDONLY);
>
> shouldn't open the device.

It won't, the open for "." is handled in the VFS, not the filesystem - 
it will open the directory.  (Without needing to be told it's a 
directory via O_DIRECTORY.)  If you do open("magicdev") you'll get the 
device, because that's handled by magicdevfs.

I'm not claiming there isn't breakage somewhere, just that we didn't 
find it on this attempt.

--
Daniel

