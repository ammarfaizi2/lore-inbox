Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWHRKNx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWHRKNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWHRKNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:13:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:23207 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751340AbWHRKNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:13:52 -0400
From: Andi Kleen <ak@suse.de>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: 2.6.18-rc4-mm1 - time moving at 3x speed!
Date: Fri, 18 Aug 2006 13:21:46 +0200
User-Agent: KMail/1.9.1
Cc: john stultz <johnstul@us.ibm.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060813012454.f1d52189.akpm@osdl.org> <200608181255.46999.ak@suse.de> <44E58FDC.6030007@aitel.hist.no>
In-Reply-To: <44E58FDC.6030007@aitel.hist.no>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608181321.46739.ak@suse.de>
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 12:01, Helge Hafting wrote:
> Andi Kleen wrote:
> >> I have narrowed it down.  2.6.18-rc4 does not have the 3x time
> >> problem,  while mm1 have it.  mm1 without the hotfix jiffies
> >> patch is just as bad.
> >
> > Can you narrow it down to a specific patch in -mm?
>
> How do I do that?  Is -mm available through git somehow,
> or is there some other clever way?

Get the patches directory from the ftp server and put it into the 
source tree as "patches". Install quilt.

Then select a middle patch from the series file. I would start it 
on the boundaries of the various groups Andrew comments first.

Then 

quilt push middle-patch 
compile/test 
if works select new middle in partition below, otherwise above.
repeat until you narrow it down to a single patch.
If the partition is below you have to use quilt pop ... instead of quilt push

Sometimes patches don't compile on their own, but in this case
treating them as groups is ok.

Also when you hit the last patch double check it really changes
the problem by retesting with it applied again.

-Andi
