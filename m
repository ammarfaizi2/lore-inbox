Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290062AbSBKSnT>; Mon, 11 Feb 2002 13:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290070AbSBKSnJ>; Mon, 11 Feb 2002 13:43:09 -0500
Received: from air-2.osdl.org ([65.201.151.6]:43792 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S290062AbSBKSmy>;
	Mon, 11 Feb 2002 13:42:54 -0500
Date: Mon, 11 Feb 2002 10:37:32 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Rohland <cr@sap.com>,
        <Andries.Brouwer@cwi.nl>, <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
In-Reply-To: <Pine.LNX.3.96.1020209131301.23246B-100000@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.33L2.0202111010560.10878-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Feb 2002, Bill Davidsen wrote:

| On Wed, 6 Feb 2002, Randy.Dunlap wrote:
|
| > I still prefer your suggestion to append it to the kernel image
| > as __initdata so that it's discarded from memory but can be
| > read with some tool(s).
|
| The problem is that it make the kernel image larger, which lives in /boot
| on many systems. Putting it in a module directory, even if not a module,
| would be a better place for creative boot methods, of which there are
| many.

Yes, it can add a few KB to a kernel image.
Some people could think that it's worth it...especially
if it's a build option.

I prefer this to using /proc/config.gz (which SuSE currently does),
since the config data won't be in permanent memory, and it's
attached to a kernel image on disk -- the kernel doesn't have to
be loaded in memory to view it.  (or maybe there's a way to
view config.gz in a SuSE kernel image ?)

I don't see how making it a binary module (living in
/lib/modules/version/kernel/configs.o e.g.) has any advantages
over kbuild (?) just copying the .config file to
/lib/modules/2.5.4/.config .

Does anyone recall if kbuild already does something like this?

I spent a little time this weekend making .config live in an
__initdata array, and I can see it in 'vmlinux',
but I can't see it in the (compressed) 'bzImage' file.
I expect that this is just a tools problem, due to the
compressed kernel image.  Does anyone know how to grep
for a string in 'bzImage', or how to expand 'bzImage'
so that grep can find strings in it?

-- 
~Randy

