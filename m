Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293603AbSDBAAl>; Mon, 1 Apr 2002 19:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312724AbSDBAAV>; Mon, 1 Apr 2002 19:00:21 -0500
Received: from air-2.osdl.org ([65.201.151.6]:39943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S293603AbSDBAAT>;
	Mon, 1 Apr 2002 19:00:19 -0500
Date: Mon, 1 Apr 2002 15:58:15 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "M. Edward (Ed) Borasky" <znmeb@aracnet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Questions about /proc/stat
In-Reply-To: <Pine.LNX.4.33.0204011532060.4450-100000@shell1.aracnet.com>
Message-ID: <Pine.LNX.4.33L2.0204011556100.13412-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, M. Edward (Ed) Borasky wrote:

| On Mon, 1 Apr 2002, Randy.Dunlap wrote:
|
| > Of course the basic answer is something like
| >   Try cscope
|
| I can't find this -- does it come with Red Hat??

it's at cscope.sf.net

| > or
| >   cd /usr/src/linux
| >   grep -r "kstat.p" * | more
|
| This worked.
|
| >
| > Using the latter one:
| >
| > | 1. Why are kstat.pgpgin and kstat.pgpgout shifted right / halved?
| >
| > I had wondered that also, so you made me look.
| >
| > pgpgin and pgpgout are maintained (counted) in units of 512-byte
| > blocks but displayed in /proc/stat in 1 KB (KiB :) blocks by shifting
| > right by 1.
|
| Yes ... that I managed to figure out. Seems strange that pgpgin/out are
| in units of kilobytes and pswpin/out are in units of pages, though. Just
| another little hole that needs plugging in the documentation.
|
| > | 2. Are the "page" and "swap" numbers mutually exclusive? That is, if a
| > | page is brought in from swap and counted in kstat.pswpin, is it also
| > | counted in kstat.pgpgin? I found the places in the code where the counts
| > | are incremented, but I couldn't tell if the swapin routine calls the
| > | block driver or not.
|
| > No, "page" and "swap" counts are not mutually exclusive.
| > Both paths call submit_bh().
| >
[snippage]
|
| Ah ... so every page to/from swap is counted in pswpin/out (as a page)
| and again in pgpgin/out as half-kilobytes :-). Incidentally, I also
| followed the third fork in this road, the one which derives the "blocks"
| read and written per device that show up in /proc/stat. Those "blocks"
| turn out to be 512 bytes long.

Do you mean this line or something else?
  disk_io: (3,0):(616296,386142,7120356,230154,3010882)

| of some high-frequency (every 15 seconds) samples of I/O data. Thanks!!

Sure, no problem.

-- 
~Randy

