Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265522AbSKABEX>; Thu, 31 Oct 2002 20:04:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265535AbSKABEX>; Thu, 31 Oct 2002 20:04:23 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30192 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265522AbSKABEX>;
	Thu, 31 Oct 2002 20:04:23 -0500
Date: Thu, 31 Oct 2002 20:10:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andries.Brouwer@cwi.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: mount
In-Reply-To: <UTC200211010053.gA10rk619405.aeb@smtp.cwi.nl>
Message-ID: <Pine.GSO.4.21.0210312000420.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Nov 2002 Andries.Brouwer@cwi.nl wrote:

> (i) I just tried 2.5.45 - CLONE_NEWNS is indeed wrong,
> and the indicated patch fixes this. Will submit it to
> Linus one of these centuries unless you object -
> assuming that I can convince myself of the correctness.

Proposed fix is, indeed, correct.  I'll feed it to Linus.
 
> (ii) The reason I write is that it will soon be time
> for util-linux 2.12. Mount still lacked syntax for
> MS_REC, and a moment ago I made it --rbind
> (for MS_REC|MS_BIND).
> Please complain if MS_REC should remain undocumented
> and inaccessible.

No problem with me.  While we are at it, mount(8) detection of loop
is, er, odd:
        return (loopmajor && stat(device, &statbuf) == 0 &&
                S_ISBLK(statbuf.st_mode) &&
                (statbuf.st_rdev>>8) == loopmajor);
                                ^^^
Tsk, tsk...  Seriously, switching to major(statbuf.st_rdev) would probably
be a good idea.

