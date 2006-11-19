Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933284AbWKSVC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933284AbWKSVC4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 16:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933287AbWKSVC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 16:02:56 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:47463 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S933284AbWKSVCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 16:02:55 -0500
Date: Sun, 19 Nov 2006 13:02:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Jeff Mahoney <jeffm@suse.com>,
       lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com,
       sam@ravnborg.org
Subject: Re: reiserfs NET=n build error
Message-Id: <20061119130248.c7e7b181.randy.dunlap@oracle.com>
In-Reply-To: <20061119205711.GE3078@ftp.linux.org.uk>
References: <20061118202206.01bdc0e0.randy.dunlap@oracle.com>
	<200611190650.49282.ak@suse.de>
	<45608FC2.5040406@suse.com>
	<200611191959.55969.ak@suse.de>
	<4560AAC1.3000800@oracle.com>
	<20061119205711.GE3078@ftp.linux.org.uk>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2006 20:57:11 +0000 Al Viro wrote:

> On Sun, Nov 19, 2006 at 11:04:33AM -0800, Randy Dunlap wrote:
> > Andi Kleen wrote:
> > >>>I would copy a relatively simple C implementation, like 
> > >>>arch/h8300/lib/checksum.c
> > >>As long as the h8300 version has the same output as the x86 version.
> > >
> > >The trouble is that the different architecture have different output 
> > >for csum_partial. So you already got a bug when someone wants to move
> > >file systems.
> > >
> > >-Andi
> > 
> > That argues for having only one version of it (in a lib.; my preference)
> > -or- Every module having its own local copy/version of it.  :(
> 
> Wrong.  csum_partial() result is defined modulo 0xffff and it's basically
> "whatever's convenient as intermediate for this architecture".
> 
> reiserfs use of it is just plain broken.  net/* is fine, since all
> final uses are via csum_fold() or equivalents.
> 
> Note that reiserfs use is broken in another way: it takes fixed-endian value
> and feeds it to cpu_to_le32().  IOW, even if everything had literally the
> same csum_partial(), the value it shits on disk would be endian-dependent.
> 
> As for net/*, with proper types it's pretty straightforward.  See
> davem's net-2.6.20 for that...

OK.  I guessed that there was some sanity in there somewhere (either
in the provider or consumer), but apparently there's none in either place.
:(

---
~Randy
