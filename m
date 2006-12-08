Return-Path: <linux-kernel-owner+w=401wt.eu-S1760748AbWLHRnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760748AbWLHRnt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 12:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbWLHRnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 12:43:49 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:39667 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760748AbWLHRns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 12:43:48 -0500
Date: Fri, 8 Dec 2006 12:43:06 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 26/35] Unionfs: Privileged operations workqueue
Message-ID: <20061208174306.GA22299@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <1165235471170-git-send-email-jsipek@cs.sunysb.edu> <Pine.LNX.4.61.0612052020420.18570@yvahk01.tjqt.qr> <20061205195013.GE2240@filer.fsl.cs.sunysb.edu> <20061206173245.GA23405@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612061939340.16042@yvahk01.tjqt.qr> <20061208021714.GA14363@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081134360.12227@yvahk01.tjqt.qr> <20061208160038.GA17707@filer.fsl.cs.sunysb.edu> <Pine.LNX.4.61.0612081801240.20988@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612081801240.20988@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 06:02:28PM +0100, Jan Engelhardt wrote:
> 
> On Dec 8 2006 11:00, Josef Sipek wrote:
> 
> +void __unionfs_mkdir(void *data)
> +{
> +	struct sioq_args *args = data;
> +	struct mkdir_args *m = &args->mkdir;
> +
> +	args->err = vfs_mkdir(m->parent, m->dentry, m->mode);
> +	complete(&args->comp);
> +}
> 
> >> The members of m (i.e. m->*) are not modified as for as __unionfs_mknod goes.
> >> vfs_mknod may only modify the members of m->parent (i.e. m->parent->*)
> > 
> >Yes they are. The return value is passed through a member of m.
> 
> Where - where do you see that m->parent, m->dentry or m->mode are modified?
> (The original submission is above.)

args->err is modified. If args is declared const, gcc complains. Sorry, the
example code I sent was a bit mis-leading (different from the actual code
above), but it triggered the same check in gcc.

Josef "Jeff" Sipek.

-- 
It used to be said [...] that AIX looks like one space alien discovered
Unix, and described it to another different space alien who then implemented
AIX. But their universal translators were broken and they'd had to gesture a
lot.
		- Paul Tomblin 
