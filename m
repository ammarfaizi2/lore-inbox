Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVAJIop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVAJIop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 03:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVAJIop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 03:44:45 -0500
Received: from canuck.infradead.org ([205.233.218.70]:40458 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262152AbVAJIon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 03:44:43 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjan@infradead.org>
To: Ken Preslan <kpreslan@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050110083524.GA9750@potassium.msp.redhat.com>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <20050110083524.GA9750@potassium.msp.redhat.com>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 09:44:33 +0100
Message-Id: <1105346673.4171.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-10 at 02:35 -0600, Ken Preslan wrote:
> On Sun, Jan 09, 2005 at 05:44:10PM -0500, Trond Myklebust wrote:
> > su den 09.01.2005 Klokka 19:42 (+0000) skreiv Arjan van de Ven:
> > > Hi,
> > > 
> > > the patch below makes flock_lock_file_wait static, because it is only used
> > > (once) in fs/locks.c. Making it static allows gcc to generate better code
> > > (partial or entirely inlining it, gcc 3.4 also optimizes the calling
> > > convention for static functions which are guaranteed only local to the file)
> > 
> > Veto. That function is also there for those filesystems that need to
> > mirror their locks in the VFS. I believe the GFS people are already
> > using it (they implemented all this anyway), and sooner or later, NFS is
> > going to have to do it too...
> 
> I second the veto.  GFS does use this interface.
> 

when are you going to propose GFS for inclusion? Is that next week or is
that months out? Is that really worth bloating everyones kernel until
then ?

