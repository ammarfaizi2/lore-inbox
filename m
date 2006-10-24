Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbWJXUn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbWJXUn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 16:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbWJXUn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 16:43:29 -0400
Received: from xenotime.net ([66.160.160.81]:54170 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965186AbWJXUn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 16:43:28 -0400
Date: Tue, 24 Oct 2006 13:45:08 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [patch, rfc] kbuild: implement checksrc without building
 Cources  (was Re: CHECK without C compile?)
Message-Id: <20061024134508.adb14be6.rdunlap@xenotime.net>
In-Reply-To: <slrnejsrjq.93p.olecom@flower.upol.cz>
References: <20061023153540.4d467a88.rdunlap@xenotime.net>
	<slrnejscd5.93p.olecom@flower.upol.cz>
	<slrnejsrjq.93p.olecom@flower.upol.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006 19:43:40 +0000 (UTC) Oleg Verych wrote:

> On 2006-10-24, Oleg Verych wrote:
> > On 2006-10-23, Randy Dunlap wrote:
> >> Hi Sam,
> >
> * It seems*
> >
> > +     $(call if_changed_rule,cc_o_c) || \
> > +     { echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
> 
> This doesn't work, use ifs instead. Updated.
> I have no idea what to do with generated sources and headers.
> One may be: check target `if_changed' to be %.c or %.h and let it be
> built.

Hi Oleg,

Yes, it works for me, with the exception of host-generated
files, as you mentioned.  I ran into those with:
IKCONFIG (the one that you mentioned), ATM_FORE200E firmware,
IEEE 1394 OUI database (which I sent a patch for -- it should
not be generated when the config option is not enabled),
RAID456 tables, VIDEO_LOGO files, and CRC32 table.

Thanks for your time and effort.  Maybe Sam will have some ideas.

> ____
> From: Oleg Verych <olecom@flower.upol.cz>
> Subject: [patch, rfc] kbuild: implement checksrc without building Cources
> 
>   Implementation of configured source chacking without actual building.
> 
> Cc: Randy Dunlap <rdunlap@xenotime.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Oleg Verych <olecom@flower.upol.cz>
> ---
> 
>   Configured sources means, some config target must be run already.
>   After that
>   ,-<shell>
>   | make prepare
>   | make C=something_not_0,1,2 _target_
>   `--
>   should run _target_ with checking and without building.
> 
> -o--=O`C  /. .\
>  #oo'L O      o
> <___=E M    ^--
> 
>  scripts/Kbuild.include |    6 +++---
>  scripts/Makefile.build |   25 ++++++++++++++++---------
>  2 files changed, 19 insertions(+), 12 deletions(-)


---
~Randy
