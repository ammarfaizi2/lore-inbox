Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUHIQ6g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUHIQ6g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 12:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266740AbUHIQ6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 12:58:36 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40111 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S266749AbUHIQ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 12:56:54 -0400
Date: Mon, 9 Aug 2004 09:56:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Greg Weeks <greg.weeks@timesys.com>
Cc: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
Message-ID: <20040809165650.GA22109@smtp.west.cox.net>
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com> <410A67EA.80705@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <410A67EA.80705@timesys.com>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2004 at 11:23:22AM -0400, Greg Weeks wrote:

> Greg Weeks wrote:
> 
> >Dan Malek wrote:
> >
> >>
> >>On Jul 29, 2004, at 10:06 AM, Kumar Gala wrote:
> >>
> >>>
> >>>On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:
> >>>
> >>>>I'm seeing what appears to be a bug in the ppc kernel trap math
> >>>>emulator. An extreme case for multiplies isn't working the way gcc
> >>>>soft-float or hardware floating point is.
> >>>
> >>>
> >>
> >>I'm not surprised.  I lifted this code from Sparc, glibc, and adapted
> >>it as best I could for PPC years ago for the 8xx.  I was happy when
> >>it appeared to work for the general cases. :-)
> >>
> >>Due to its overhead, I never expected it to be _the_ solution for
> >>processors that don't have floating point hardware.  Recompiling
> >>the libraries with soft-float and using that option when compiling
> >>is the way to go.
> >
> >
> >OK, this patch fixes my multiply problem with the LSB test. I still 
> >need to test to make sure I didn't break anything else, but it appears 
> >the rounding is only used when converting back to IEEE format. Is 
> >there some reason this is something really dumb to do?
> >
> When I actually built a kernel rather than just my test code the 
> FP_ROUNDMODE is picked up from the linux/math-emu/soft-fp.h. I don't 
> want to change the common definition unless I'm sure this is the correct 
> solution.
> 
> Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0087

Has anyone had a problem with this?  If not, I'll go and pass it
along...

-- 
Tom Rini
http://gate.crashing.org/~trini/
