Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQKBWXq>; Thu, 2 Nov 2000 17:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQKBWXg>; Thu, 2 Nov 2000 17:23:36 -0500
Received: from cr416993-a.ym1.on.wave.home.com ([24.112.193.232]:32019 "EHLO
	cr416993-a.ym1.on.wave.home.com") by vger.kernel.org with ESMTP
	id <S129716AbQKBWXb>; Thu, 2 Nov 2000 17:23:31 -0500
Date: Thu, 2 Nov 2000 17:23:07 -0500 (EST)
From: "D. Hugh Redelmeier" <hugh@mimosa.com>
Reply-To: hugh@mimosa.com
To: Tim Riker <Tim@Rikers.org>
cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: non-gcc linux?
In-Reply-To: <3A01C7CD.C5AEB5B5@Rikers.org>
Message-ID: <Pine.LNX.4.21.0011021655260.8398-100000@redshift.mimosa.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: Tim Riker <Tim@Rikers.org>

| However, it makes me a bit nervous to take this route. It assumes that
| the way gcc does things is the "best way". A more formal route of adding
| to the ANSI C standard would involve more eyes and therefore hopefully
| add to the quality of what has been done solely for gcc.
| 
| This started off with some comments from the group (hpa in particular)
| that even between gcc releases, the gcc extensions have been much less
| stable that the standard compiler features. The danger of implementing
| gcc extensions in another compiler is that these feature are solely
| under the control of the gcc team. They are to a large degree
| "documented as implemented" and as such can be difficult to determine
| the Right Way to implement. The Good Things that are in gcc, that we
| believe are implemented the Right Way should probably be added to the
| ANSI C spec. The others should be avoided, especially when there is an
| existing ANSI C way to do them.

I strongly support Tim's direction here.

I've found that code improves when you port it to different compilers
(unless you are in a hurry -- then it grows warts).

Being GCC-dependent is rather parochial.  Being GCC-version-dependent
is downright embarrassing.

Summary: spurious GCC-isms are a bad thing.

Earlier, Tim gave quite a good outline of how to address GCCisms.
My summary:

- use ISO C 89 when possible (without undue pain)

- use IOS C 99 when advantageous

- use GCCisms for the remainder of appropriate things BUT embed them
  in macros defined in header so that they can be systematically
  replaced.  Using these macros probably makes the code more readable.
  Use of any GCCism should probably be justified in commentary.

This would improve the code *and* make it more portable.

The important advantages accrue to everyone, including those who never
use a different compiler.

Hugh Redelmeier
hugh@mimosa.com  voice: +1 416 482-8253

PS: I don't agree with all that ISO SC22 WG14 does, but I think that
its work is valuable.  I attended their meeting in Toronto a couple of
weeks ago.

PPS: my own C compiler is not a toy and does not implement "packed".
I've not even thought of trying it on the linux kernel, but experience
shows that putting a program through my compiler does point to places
to improve the code.  Ask Miguel de Icaza, for example.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
