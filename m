Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265176AbRF0AqI>; Tue, 26 Jun 2001 20:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbRF0Apr>; Tue, 26 Jun 2001 20:45:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:34320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265166AbRF0Aph>; Tue, 26 Jun 2001 20:45:37 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] User chroot
Date: 26 Jun 2001 17:45:15 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9hbaar$4ot$1@cesium.transmeta.com>
In-Reply-To: <0C01A29FBAE24448A792F5C68F5EA47D1205FB@nasdaq.ms.ensim.com> <E15F3KH-0003fd-00@pmenage-dt.ensim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E15F3KH-0003fd-00@pmenage-dt.ensim.com>
By author:    Paul Menage <pmenage@ensim.com>
In newsgroup: linux.dev.kernel
> 
> It could potentially be useful for a network daemon (e.g. a simplified
> anonymous FTP server) that wanted to be absolutely sure that neither it
> nor any of its libraries were being tricked into following a bogus
> symlink, or a "/../" in a passed filename. After initialisation, the
> daemon could chroot() into its data directory, and safely only serve
> the set of files within that directory hierarchy.
> 
> This could be regarded as the wrong way to solve such a problem, but
> this kind of bug seems to be occurring often enough on BugTraq that it
> might be useful if you don't have the resources to do a full security
> audit on your program (or if the source to some of your libraries
> isn't available).
> 

If the source to some of your libraries aren't available, you have no
clue when/why/if they will try to access other files in the
filesystem.  Since libc WILL do this, a random chroot() breaks libc
(unless you can set up a proper root environment), and therefore
pretty much anything else is pointless.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
