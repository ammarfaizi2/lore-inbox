Return-Path: <linux-kernel-owner+w=401wt.eu-S965024AbXABXNR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbXABXNR (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbXABXNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:13:17 -0500
Received: from mx1.cs.washington.edu ([128.208.5.52]:54798 "EHLO
	mx1.cs.washington.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbXABXNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:13:16 -0500
Date: Tue, 2 Jan 2007 15:09:39 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Linus Torvalds <torvalds@osdl.org>
cc: Adrian Bunk <bunk@stusta.de>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: kernel + gcc 4.1 = several problems
In-Reply-To: <Pine.LNX.4.64.0701021349420.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64N.0701021500480.6449@attu4.cs.washington.edu>
References: <200612201421.03514.s0348365@sms.ed.ac.uk>
 <200612301659.35982.s0348365@sms.ed.ac.uk> <20061231162731.GK20714@stusta.de>
 <200612311655.51928.s0348365@sms.ed.ac.uk> <20070102211045.GY20714@stusta.de>
 <Pine.LNX.4.64.0701021349420.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Linus Torvalds wrote:

> Traditionally, afaik, -Os has tended to show compiler problems that 
> _could_ happen with -O2 too, but never do in practice. It may be that 
> gcc-4.1 without -Os miscompiles some very unusual code, and then with -Os 
> we just hit more cases of that.
> 

gcc optimizations were almost completely rewritten between 3.4.6 and 4.1, 
and one of the subtle changes that may have been introduced is with regard 
to the heuristics used to determine whether to inline an 'inline' function 
or not when using -Os.  This problem can show up in dynamic linking and 
break on certain architectures but should be detectable by using -Winline.

		David
