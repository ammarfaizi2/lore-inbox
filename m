Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265668AbUHHPyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265668AbUHHPyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 11:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHHPyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 11:54:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57092 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265668AbUHHPye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 11:54:34 -0400
Date: Sun, 8 Aug 2004 16:54:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kallsyms dependency
Message-ID: <20040808165429.A17968@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20040808123230.B7589@flint.arm.linux.org.uk> <20040808154610.GA18740@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040808154610.GA18740@mars.ravnborg.org>; from sam@ravnborg.org on Sun, Aug 08, 2004 at 05:46:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 05:46:10PM +0200, Sam Ravnborg wrote:
> On Sun, Aug 08, 2004 at 12:32:30PM +0100, Russell King wrote:
> > Hi,
> > 
> > It appears that kallsyms data is not updated if the kallsyms program is
> > changed.  The following patch adds an appropriate dependency.
> 
> Added, and implemented your suggestion in scripts/Makefile
> with a few other CONFIG selections.
> 
> Btw. any specific reason to hack kallsyms? Just curious if something
> shows up in this area.

Yes - later ARM binutils adds extra symbols like "$a" and "$d" to the
symbol table as "mapping symbols" (binutils terminology).  It's not
clear whether these will continue to be visible via normal tools or
not, and I was considering getting kallsyms to filter them out.

Depending on the outcome of the binutils side depends whether or not
I end up modifying kallsyms to ignore these symbols and whether we
end up saying "binutils earlier than <todays latest and greatest
release> can not be used for ARM."

If a release of binutils is imminent which solves both the mapping
symbol visibility problem and the undefined symbol issue, then I
suspect its just all round easier to prevent the ARM kernel being
built with older binutils versions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
