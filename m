Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVG2TBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVG2TBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVG2TBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:01:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3511 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262680AbVG2S7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:59:07 -0400
Date: Fri, 29 Jul 2005 14:58:48 -0400
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: adaplas@gmail.com, adaplas@pol.net, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: vesafb-fix-mtrr-bugs.patch added to -mm tree
Message-ID: <20050729185848.GP17003@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, adaplas@gmail.com, adaplas@pol.net,
	ak@suse.de
References: <200507291825.j6TIParH012406@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507291825.j6TIParH012406@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2005 at 11:24:37AM -0700, Andrew Morton wrote:

 > From: "Antonino A. Daplas" <adaplas@gmail.com>
 > 
 > >> vesafb: mode is 800x600x16, linelength=1600, pages=16
 > >> vesafb: scrolling: redraw
 > >> vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
 > >> mtrr: type mismatch for fc000000,1000000 old: write-back new: write-
 > >> combining
 > 
 > Range is already set to write-back, vesafb attempts to add a write-combining
 > mtrr (default for vesafb).
 > 
 > >> mtrr: size and base must be multiples of 4 kiB
 > 
 > This is a bug, vesafb attempts to add a size < PAGE_SIZE triggering
 > the messages below.

I fixed this a few weeks back. It's this line which your patch removes..

-        while (temp_size > PAGE_SIZE &&

 > To eliminate the warning messages, you can add the option mtrr:2 to add a
 > write-back mtrr for vesafb.  Or just use nomtrr option.

If we need users to pass extra command line args to make warnings go
away, we may as well not bother. Because 99% of users will be completely
unaware that option even exists.  They'll still see the same message,
and still report the same bugs.

The pains of MTRR strike again. This stuff is just screaming for
a usable PAT implementation. Andi, you were working on that, any news ?
Or should I resurrect Terrence's patch again ?

		Dave

