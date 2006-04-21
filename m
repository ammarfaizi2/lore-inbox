Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWDUTiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWDUTiB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 15:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWDUTiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 15:38:01 -0400
Received: from gherkin.frus.com ([192.158.254.49]:34057 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S932375AbWDUTiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 15:38:00 -0400
Subject: Re: strncpy (maybe others) broken on Alpha
In-Reply-To: <20060421182223.C19738@jurassic.park.msu.ru> "from Ivan Kokshaysky
 at Apr 21, 2006 06:22:23 pm"
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Date: Fri, 21 Apr 2006 14:37:59 -0500 (CDT)
CC: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, rth@twiddle.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20060421193759.55D55DBA1@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ivan Kokshaysky wrote:
> On Fri, Apr 21, 2006 at 01:55:56PM +0200, Mathieu Chouquet-Stringer wrote:
> > I've attached to this email a tarball of what I use to test the
> > compiler/binutils.  It's faster than recompiling the whole kernel on
> > these slow machines!
> 
> Oops. I was using a wrong copy of strncpy.S (remained from previous
> __stxncpy() debugging). What's why I wasn't able to reproduce that...
> 
> It seems that the registers $24 and $27 are mixed up in strncpy().
> This fixes your test case, please check if it fixes kernel problem
> as well.

With this patch applied, the test suite appears to work correctly with
ALL versions of gcc on the Alpha to which I have access.  The binutils
package is currently the 2.16.1cvs20060413-1 version from Debian's
"unstable" tree.

WITHOUT the patch, and everything else the same, gcc-4.0 and gcc-4.1
appear to work, but the gcc-3.3 build produces the bad behavior we've
been seeing.

I'm currently building a 2.6.17-rc2 kernel with gcc-4.1, the binutils
package mentioned above, and Ivan's patch.  Report to follow later.

Pending a knowledgable peer review of Ivan's patch (no insult intended:
I'm not qualified), I'd say we're close to putting this to rest.  If it
turns out the patch is the correct fix, I'm genuinely concerned about
how long this bug went undetected :-(.  The modification date of
arch/alpha/lib/strncpy.S is 28 Jul 2003 in my tree.  The stxncpy.S file
is not quite a year newer: 10 May 2004.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
