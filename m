Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264621AbUDVSWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264621AbUDVSWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUDVSWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:22:34 -0400
Received: from h24-71-77-159.ok.shawcable.net ([24.71.77.159]:47622 "EHLO
	indygecko.com") by vger.kernel.org with ESMTP id S264621AbUDVSWU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:22:20 -0400
Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
From: Jord Tanner <jord@indygecko.com>
To: Paul Wagland <paul@wagland.net>
Cc: linux-kernel@vger.kernel.org, Atulm@lsil.com
In-Reply-To: <A1E28594-9478-11D8-B5AA-000A95CD704C@wagland.net>
References: <0E3FA95632D6D047BA649F95DAB60E57033BC53C@exa-atlanta.se.lsil.com>
	 <1082143294.11606.81.camel@gecko>
	 <A1E28594-9478-11D8-B5AA-000A95CD704C@wagland.net>
Message-Id: <1082658137.22804.1563.camel@gecko>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 22 Apr 2004 11:22:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

(I'm not subscribed to the list, so if this doesn't make it through,
please forward it for me)

After some testing, the machine works much better with the new
(2.20.0.B2) megaraid driver, but we still get the occasional postgres
corrupted data. The symptoms are somewhat different now (corrupted pages
contain mostly blanks, whereas with the 2.00.3 driver the pages were
filled with FF), so I think there may be multiple causes. We were
running XFS on LVM2 on linux RAID0 on megaraid RAID1. I switched from
XFS to JFS yesterday, and at this point have not had any more problems.
We are continuing to test, and once we have a stable configuration, I'll
post the details.

Jord Tanner
Independent Gecko Consultants

On Thu, 2004-04-22 at 09:18, Paul Wagland wrote:
> Hi Jord,
> 
> In response to this thread I seem to recall that you mentioned that you  
> would test out the new driver and see if it resolved your problem. I  
> was wondering if you had any results from this testing yet?
> 
> Thanks in advance,
> Paul
> 
> On Apr 16, 2004, at 21:21, Jord Tanner wrote:
> 
> >
> > Thanks Atul!
> >
> > After patching for 2.6.5 the 2.20.0.B2 driver compiled clean and the
> > machine in now running with that driver. We are about to run some  
> > stress
> > tests to see if we can duplicate the previous problems.
> >
> > Given that we are running a 64bit compile, and the previous attempts by
> > Brad House to make amd64 modifications were abandonded, could you
> > comment on whether you think the newest megaraid code
> > (ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-unified
> > -2.20.0.B2.04.14.2004)
> > is 64bit safe?
> >
> > TIA
> >
> > Jord Tanner
> > Independent Gecko Consultants
> >
> > On Fri, 2004-04-16 at 09:35, Mukker, Atul wrote:
> >> Please use the latest driver 2.20.0.B2, about to be released today.  
> >> Please
> >> provide a feedback if you see the same issues.
> >>
> >> -Atul Mukker
> >> LSI Logic
> >>
> >>> -----Original Message-----
> >>> From: Jord Tanner [mailto:jord@indygecko.com]
> >>> Sent: Friday, April 16, 2004 9:57 AM
> >>> To: linux-kernel@vger.kernel.org
> >>> Cc: brad_mssw@gentoo.org; Atulm@lsil.com
> >>> Subject: Re: [PATCH 2.6.0] megaraid 64bit fix/cleanup (AMD64)
> >>>
> >>>
> >>>
> >>> On Tue Dec 30 2003 - 16:11:40 EST Brad House wrote:
> >>>
> >>>         Ok, I just ported the 2.00.9 driver to 2.6.0.
> >>>         It still has these warnings during compilation as I did not
> >>>         attempt to apply my 64bit fixes from before as I've been told
> >>>         they are just plain wrong :/
> >>>
> >>>         But, I suppose this should work fine in 32bit mode, I would
> >>>         greatly appreciate any help in porting it for 64bit  
> >>> platforms.
> >>>
> >>>         The patch can be downloaded here :
> >>>
> >>> http://dev.gentoo.org/~brad_mssw/kernel_patches/megaraid/megar
> >>> aid-v2.00.9-linux2.6.patch
> >>>         And only applies to the source from ftp.lsil.com, it's not a
> >>>         kernel-patch
> >>>         per-se, but copying the result over to the drivers/scsi will
> >>>         compile inplace
> >>>         of the current versions.
> >>>
> >>>         Please CC me on any replies!
> >>>         -Brad House <brad_mssw@xxxxxxxxxx>
> >>>
> >>>
> >>>
> >>> This thread has been inactive for a while, but I've not found  
> >>> anything
> >>> more relevant to my situation.
> >>>
> >>> I'm running 2.6.3-gentoo (and 2.6.5-gentoo) with a LSILogic SATA
> >>> Megaraid 150-6 raid controller on a dual Opteron system. The entire
> >>> system is compiled in 64bit. We are seeing random database corruption
> >>> when access very large Postgres tables (more than 10 million rows).
> >>> Other than that, the system runs beautifully.
> >>>
> >>> As far as I can tell, no amd64 specific patches have been
> >>> applied to the
> >>> megaraid driver in 2.6.3 (version 2.00.3). Brad House has posted a  
> >>> 2.6
> >>> patch for megaraid 2.00.9, but his previous amd64 patches
> >>> were removed.
> >>> LSI tech support has suggested I upgrade to 2.00.9, but the LSI  
> >>> source
> >>> is for 2.4.
> >>>
> >>> So my questions are:
> >>>
> >>>         - Could the 2.00.3 driver be responsible for random data
> >>>         corruption when running on 2.6.3 in 64bit?
> >>>         - Is it safe to run Brad House's 2.6 megaraid 2.00.9
> >>> patches in
> >>>         64 bit mode on amd64?
> >>>         - Are there any patches for megaraid 2.00.9 (or higher, I see
> >>>         2.00.10-3 has just been released) that combine patches for  
> >>> 2.6
> >>>         and amd64?
> >>>
> >>> TIA,
> >>>
> >>>
> >>> -- 
> >>> Jord Tanner <jord@indygecko.com>
> >>>
> >>> -
> >>> To unsubscribe from this list: send the line "unsubscribe
> >>> linux-kernel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> Please read the FAQ at  http://www.tux.org/lkml/
> >>>
> > -- 
> > Jord Tanner <jord@indygecko.com>
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe  
> > linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
-- 
Jord Tanner <jord@indygecko.com>

