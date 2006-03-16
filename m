Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWCPTzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWCPTzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 14:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWCPTzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 14:55:18 -0500
Received: from rwcrmhc11.comcast.net ([216.148.227.151]:53438 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750861AbWCPTzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 14:55:16 -0500
Subject: Re: [patch 1/1] consolidate TRUE and FALSE
From: Nicholas Miell <nmiell@comcast.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
In-Reply-To: <20060316024234.103d37dc.akpm@osdl.org>
References: <200603161004.k2GA46Fc029649@shell0.pdx.osdl.net>
	 <Pine.LNX.4.64.0603161015130.31173@hermes-2.csi.cam.ac.uk>
	 <20060316024234.103d37dc.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 11:55:13 -0800
Message-Id: <1142538913.2994.6.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 02:42 -0800, Andrew Morton wrote:
> Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> >
> > > Various places are doing things like
> >  > 
> >  > typedef {
> >  > 	FALSE,
> >  > 	TRUE
> >  > } my_fave_name_for_a_bool;
> >  > 
> >  > These are converted to
> >  > 
> >  > typedef int my_fave_name_for_a_bool;
> > 
> >  Given that the kernel now requires gcc 3.2 or later, that already includes 
> >  a native boolean type (_Bool)?
> 
> It does?
> 
> Is it any good?
> 
> bix:/home/akpm> cat t.c
> void foo()
> {
> 	_Bool b = 1;
> 
> 	b += 2;
> }
> bix:/home/akpm> gcc -O -Wall -c t.c
> bix:/home/akpm> 
> 
> Sigh.
> 

If you were to read the value of b after "b += 2", you'd find that b is
still 1.

Also note that _Bool is a byte, so anything that exposed its own custom
boolean type to userspace needs to be carefully updated.

-- 
Nicholas Miell <nmiell@comcast.net>

