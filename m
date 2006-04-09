Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbWDIC1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWDIC1m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 22:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbWDIC1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 22:27:42 -0400
Received: from xenotime.net ([66.160.160.81]:29617 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965060AbWDIC1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 22:27:42 -0400
Date: Sat, 8 Apr 2006 19:29:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: menuconfig search (Re: [rfc] fix Kconfig, hotplug_cpu is needed
 for swsusp)
Message-Id: <20060408192959.1fa9f401.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0604081030201.21887@yvahk01.tjqt.qr>
References: <20060329220808.GA1716@elf.ucw.cz>
	<200603300936.22757.ncunningham@cyclades.com>
	<20060329154748.A12897@unix-os.sc.intel.com>
	<200603300953.32298.ncunningham@cyclades.com>
	<Pine.LNX.4.61.0603301022400.30783@yvahk01.tjqt.qr>
	<20060403221537.79bb3af9.rdunlap@xenotime.net>
	<Pine.LNX.4.61.0604081030201.21887@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Apr 2006 10:42:46 +0200 (MEST) Jan Engelhardt wrote:

> >> I find it very confusing to use, since it returns too verbose text to skim 
> >> through. Probably the search function should be split into "only search 
> >> titles[*]" and "search description too".
> >
> >Re verbosity:  do you know that menuconfig search (/) takes regular
> >expressions?
> 
> Regexes are not mentioned in the "Help" menu.

It is mentioned in the Help text after one enters '/'.

  │ Search for CONFIG_ symbols and display their relations.                 │
  │ Regular expressions are allowed.                                        │
  │ Example: search for "^FOO"                                              │


> >That could help someone limit the amount of output
> >from it.
> >Can you give an example of being too verbose?
> 
> / UNIX
>  Symbol: UNIX [=y]
>  Prompt: Unix domain sockets
>    Defined at net/unix/Kconfig:5
>    Depends on: NET
>    Location:
>      -> Networking
>        -> Networking support (NET [=y])
>          -> Networking options
> 
>  Symbol: UNIXWARE_DISKSLICES ...
>   ...
> 
> 
> What would be more useful:
>  UNIX
>    Unix domain sockets
>    Networking > Networking Support > Networking options
> 
>  UNIXWARE_DISKSLICES
>    Unixware slices support
>    File systems > Advanced ...
> 
> I.e. strip the Defined and Depends lines and crunch the Location lines inasfar
> as that the full width of the window is used (break at col 70).

I don't see any need to limit it to 70 columns wide.  It knows how to
scroll left/right (using arrow keys).

 
>  DEEP_FS
>    Just a symbol
>    File systems > Advanced filesystems > Very advanced filesystems >\n
>    Extremely advanced filesystems > Deep filesystem
> 
> 
> >I have just modified menuconfig search to make displaying the
> >Selects: and Selected by: output be an option (actually it's a
> >different search command (\) to not see those lines.
> >Would that help any regarding verbosity?
> 
> At the moment, entering e.g. UNIX in both the / and \ menus return the very 
> same output. Bug?
> 
> The \ should include everything what the original / had, plus the symbol
> description ("Say Y here if ....").

Nope, the only thing that the "reduced" search excludes atm is SELECT info.
>From my original email, as you quoted above, the less-verbose '\' search
only eliminates the Selects: and Selected by: output, and the UNIX
config symbols don't have any SELECT info.

I don't know if we are converging any, but I made a new patch:
  http://www.xenotime.net/linux/patches/menuconfig-search2b.patch

This one changes the default '/' search to NOT be verbose and the
new, extended '\' search to be verbose.  The non-verbose search omits
Selects:, Selected by:, and Location: information.

---
~Randy
