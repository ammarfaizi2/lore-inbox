Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131192AbRACWGS>; Wed, 3 Jan 2001 17:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131354AbRACWGJ>; Wed, 3 Jan 2001 17:06:09 -0500
Received: from dialin41.pg3-nt.dusseldorf.nikoma.de ([213.54.98.41]:18670 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130111AbRACWF4>; Wed, 3 Jan 2001 17:05:56 -0500
Date: Wed, 3 Jan 2001 23:06:36 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Gerold Jury <geroldj@grips.com>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, <dl8bcu@gmx.net>,
        <Maik.Zumstrull@gmx.de>
Subject: Re: Happy new year^H^H^H^Hkernel..
In-Reply-To: <m17l4cjzig.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.30.0101032201290.8073-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Jan 2001, Eric W. Biederman wrote:

> Kai Germaschewski <kai@thphy.uni-duesseldorf.de> writes:
>
> > I think the problem was that we relied on divert_if being initialized to
> > zero automatically, which didn't happen because it was not declared static
> > and therefore not in .bss (*is this true?*).
>
> All variables with static storage (not with static scope) if not explicitly
> initialized are placed in the bss segment.  In particular this
> means that adding/removing a static changes nothing.

The patch is right, the explanation was wrong. Sorry, I didn't CC l-k when
I found what was really going on. Other source files used a global
initialized variable "divert_if" as well, so this became the same one as
the one referenced in isdn_common.c.  That's why it wasn't zero, it was
explicitly initialized elsewhere. However, making divert_if static in
isdn_common.c fixes the problem, because now it's really local to this
file and therefore initialized to NULL.

--Kai



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
