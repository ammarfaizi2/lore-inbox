Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264744AbSJ3RLl>; Wed, 30 Oct 2002 12:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264750AbSJ3RLl>; Wed, 30 Oct 2002 12:11:41 -0500
Received: from host194.steeleye.com ([66.206.164.34]:25861 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S264744AbSJ3RLj>; Wed, 30 Oct 2002 12:11:39 -0500
Message-Id: <200210301717.g9UHHs902706@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.5 current bk fix setting scsi queue depths 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Wed, 30 Oct 2002 08:58:44 PST." <20021030085844.A11040@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 Oct 2002 11:17:52 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> This patch fixes a problem with the current linus bk tree setting scsi
> queue depths to 1. Please apply. 

This patch causes the depth specification to be retained when we release 
commandblocks.  Since releasing command blocks is supposed only to be done 
when we give up the device (and therefore, is supposed to clear everything), 
your fix looks like it's merely masking a problem, not fixing it.

Is the real problem that this controller is getting a release command blocks 
and then a reallocate of them after slave_attach is called?  If so, that's 
probably what needs to be fixed.

James


