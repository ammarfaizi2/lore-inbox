Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262017AbRETASn>; Sat, 19 May 2001 20:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262020AbRETASX>; Sat, 19 May 2001 20:18:23 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:22230 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262016AbRETAST>;
	Sat, 19 May 2001 20:18:19 -0400
Date: Sat, 19 May 2001 20:18:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Edgar Toernig <froese@gmx.de>
cc: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B07074B.A6964617@gmx.de>
Message-ID: <Pine.GSO.4.21.0105192008290.7162-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 20 May 2001, Edgar Toernig wrote:

> That assumption is totally bogus.  Even for regular files you have side
> effects (atime); for anything else they're unpredictable.

That means only one thing: safe backups are possible only in single-user
mode. For values of safe being "not triggering these side effects on
arbitrary files outside of the area you are trying to backup". You can't
pin an object down until you open it. You can check that it's the same
object you think it is, but that will require fstat(). I.e. opening the
thing.

If all effects of open() either disappear on close() or are something you
don't care about - fine. Otherwise you have a problem. On any UNIX.

