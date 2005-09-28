Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVI1UYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVI1UYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 16:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVI1UYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 16:24:22 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:64726 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1750786AbVI1UYV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 16:24:21 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Date: Wed, 28 Sep 2005 22:24:42 +0200
User-Agent: KMail/1.8.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
References: <200509281624.29256.rjw@sisk.pl> <200509282118.54670.ak@suse.de>
In-Reply-To: <200509282118.54670.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200509282224.43397.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 28 of September 2005 21:18, Andi Kleen wrote:
> On Wednesday 28 September 2005 16:24, Rafael J. Wysocki wrote:
> > Hi,
> >
> > The following patch fixes Bug #4959.  For this purpose it creates temporary
> > page translation tables including the kernel mapping (reused) and the
> > direct mapping (created from scratch) and makes swsusp switch to these
> > tables right before the image is restored.
> >
> > The code that generates the direct mapping is based on the code in
> > arch/x86_64/mm/init.c.
> 
> Looks much better than before, but is there any reason you cannot
> share the code with the mm/init.c code?

I think so.  I have to make the temporary page tables nosavedata or set
PG_nosave on them, so that swsusp doesn't overwrite them.  I'm not
sure if I could do this cleanly if I used the code from mm/init.c directly.

> Also Suresh S. has a patch out to turn the initial page tables
> into initdata. It'll probably conflict with that. Needs to be coordinated
> with him.

Do you mean the patch at:
http://www.x86-64.org/lists/discuss/msg07297.html ?
Unfortunately it interferes with the current swsusp code, which uses
init_level4_pgt anyway.

Could we please treat my patch as a (very much needed) urgent bugfix
and make the whole swsusp code in line with the Suresh's patch later on?

Suresh, could you please say what you think of it?

Greetings,
Rafael
