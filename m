Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314475AbSFISxm>; Sun, 9 Jun 2002 14:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSFISxl>; Sun, 9 Jun 2002 14:53:41 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:48325 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S314475AbSFISxh>; Sun, 9 Jun 2002 14:53:37 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <E17H6ja-0003Ye-00@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 11:53:32 -0700
Message-Id: <1023648813.1188.19.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 10:44, Daniel Phillips wrote:

> Personally, it sounds like support for shortcuts as symlinks is a natural and 
> needed improvement, though I haven't looked at the the internal details.  
> (Shortcuts arrived in Microsoft-land at about the time I lost interest.)  I'm 
> kind of surprised the support isn't already there.  Perhaps you could briefy 
> describe how shortcuts work on vfat?
> 

Putting shortcut support into the VFAT driver is as bad a decision as
the automatic text-file CRLF->LF conversions was, for several reasons.

First of all, some programs (WINE) will actually want to use the .lnk
files, and transparently converting them to symlinks will complicate
that.

More importantly, shortcuts are a hell of a lot more complicated than
has been implied. Not only can they point to local files or UNCs (the
\\server\share\path notation), they can also point to any object in the
(Windows) shell's namespace, which includes lots of virtual objects that
don't actually exist on disk. With the release of the Windows Installer
package manager, Microsoft has also added support for shortcuts that
will either invoke the target application or prompt for that
application's installation when they're activiated, leading to much more
complexity to either deal with such a shortcut, or to recognize it and
ignore it.

Finally, I haven't seen any justification for why symlinks on VFAT are
needed, beyond some vague statements that it's useful when dual booting.
Face it, VFAT isn't a Unix filesystem and introducing ugly hacks to make
it more similar to one will only cause problems in the long run. If you
want symlinks, use a real filesystem or use umsdos on your favorite FAT
filesystem. (Assuming that umsdos still works...).

- Nicholas

P.S. As to how shortcuts actually work, they're just ordinary files on
disk in some undocumented, proprietary, and frequently changing format
that the Windows Shell knows how to interpret.

