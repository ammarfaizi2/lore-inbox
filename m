Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130464AbRAXJHy>; Wed, 24 Jan 2001 04:07:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131126AbRAXJHn>; Wed, 24 Jan 2001 04:07:43 -0500
Received: from [62.172.234.2] ([62.172.234.2]:64219 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S130464AbRAXJHi>;
	Wed, 24 Jan 2001 04:07:38 -0500
Date: Wed, 24 Jan 2001 09:10:10 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: A little patch for i386/kernel/microcode.c (fwd)
Message-ID: <Pine.LNX.4.21.0101240909411.746-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jan 2001, Jo l'Indien wrote:
> With a 2.4.1-pre10 kernel, I noticed that /dev/cpu/microcode
> was created as a file, and note as a node in the devfs.
> So, I made this very little patch to correct this:
> 
[bogus patch deleted]

Hi Jocelyn,

No, that file is created as a regular file for a purpose. The design of
the Linux IA32 microcode device driver (btw, described fully in latest
Linux Magazine) is such that it uses a characted device node on misc major
_AND_ a regular file in devfs namespace, if available. The initialization
succeeds if at least one of the method succeeds. If you are wondering why
is this the case, the answer is -- ask yourself "what information can
regular files provide which device nodes do not?". The answer is "file
size" so I store an extra bit of information in the size of the regular
devfs file which cannot be stored in the device node inode. That is the
only benefit of devfs (in this case) -- just an extra integer to stash
somewhere. But this has a lot of consequences, e.g. it means you could (in
theory) just use your favourite binary editor to "edit" the microcode on
the cpu "directly". (for this to work in practice you would need to
instruct the editor of the suitable buffer sizes or to furnish the driver
with a huge amount of extra logic to accumulate the chunks received of any
size into appropriate ones).

So, in short, no, your patch is of no use, thank you.

Regards,
Tigran

PS. Also, where did you get that tigran@sco.com from? The microcode.c
plainly says "tigran@veritas.com" in recent references.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
