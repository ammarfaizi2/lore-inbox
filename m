Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263279AbSJaS6s>; Thu, 31 Oct 2002 13:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263283AbSJaS6r>; Thu, 31 Oct 2002 13:58:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:45025 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263279AbSJaS6q>; Thu, 31 Oct 2002 13:58:46 -0500
Subject: Re: Reiser vs EXT3
From: "David C. Hansen" <haveblue@us.ibm.com>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021031141950.GM3420@rdlg.net>
References: <20021031141950.GM3420@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 31 Oct 2002 11:02:49 -0800
Message-Id: <1036090969.4272.59.camel@nighthawk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 06:19, Robert L. Harris wrote:
> 
>   Still working on that replacement mail server and a new rumor has hit
> the mix.  It follows that reiserfs is much faster than ext3 (made ext3,
> not converted from ext2 if it matters) and this is causing some
> problems.  On a 200Gig filesystem is this truely an issue?

ext3 has some SMP scalability problems.  The BKL is used to protect many
journal operations, and we see huge amounts of CPU spent spinning on it
on 4/8/16 proc machines.  So much CPU, that it masks anything else we're
doing on the system.  But, on a single-proc or just a 2-way, you
probably won't see much of this to be significant.  

We haven't tested reiser extensively here, but from what I've seen it
scales much, much better than ext3 (as does jfs and probably xfs too).
-- 
Dave Hansen
haveblue@us.ibm.com

