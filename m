Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTIHJdV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbTIHJdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:33:21 -0400
Received: from users.linvision.com ([62.58.92.114]:440 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id S262120AbTIHJdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:33:18 -0400
Date: Mon, 8 Sep 2003 11:33:04 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Oleg Drokin <green@namesys.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: First impressions of reiserfs4
Message-ID: <20030908113304.A28123@bitwizard.nl>
References: <slrnbl12sv.i4g.erik@bender.home.hensema.net> <3F50D986.6080707@namesys.com> <20030831191419.A23940@bitwizard.nl> <20030908081206.GA17718@namesys.com> <20030908105639.B26722@bitwizard.nl> <20030908090826.GB10487@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908090826.GB10487@namesys.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 01:08:26PM +0400, Oleg Drokin wrote:
> Hello!
> 
> On Mon, Sep 08, 2003 at 10:56:41AM +0200, Rogier Wolff wrote:
> > > > There  is no installation program that will fail with: "Sorry, 
> > > > you only have 100 million inodes free, this program will need
> > > > 132 million after installation", and it allows me a quick way 
> > > > of counting the number of actual files on the disk.... 
> > > You cannot. statfs(2) only exports "Total number of inodes on disk" and
> > > "number of free inodes on disk" values for fs. df substracts one from another one
> > > to get "number of inodes in use".
> > So, you report "oids_in_use + 100M" as total and "100M" as free inodes 
> > on disk. Voila!

> Yes, we thought about that too. Need to be careful to not overflow
> "long int".  

> And idea of filesystem with variable amount of inodes over time
> sounds confusing to me, too.  ]

SO? That's actually the case. So it's confusing. So you're confusing
people even more by telling nothing. Great. 

#define LARGE_NUMBER 100000

out->total_inodes = fs->oids_in_use + LARGE_NUMBER; 
if (out->total_inodes < fs->oids_in_use) 
   out -> total_inods = MAXINT;
out -> free_inodes = LARGE_NUMBER; 

Three lines of code fixes that. 

> Well, if current interface does not allow to see all the stuff you want to,
> time to change (introduce new one) interface, anyway.

Fine, introduce a new interface. But report as much as you can on the
old interface. Remember you can read/write/seek files using the 32bit
interface even though the new (seek-, and stat-) interface uses 64
bits.

		Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
