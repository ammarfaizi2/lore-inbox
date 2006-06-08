Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965020AbWFHVRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965020AbWFHVRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 17:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWFHVRk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 17:17:40 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:28037 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S965020AbWFHVRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 17:17:39 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 8 Jun 2006 22:17:34 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.17-rc6-mm1 -- BUG: possible circular locking deadlock
 detected!
In-Reply-To: <20060608161130.GA6869@elte.hu>
Message-ID: <Pine.LNX.4.64.0606082216260.9858@hermes-1.csi.cam.ac.uk>
References: <a44ae5cd0606072127n761c64fepf388e2f9de8ca1fe@mail.gmail.com>
 <1149751953.10056.10.camel@imp.csi.cam.ac.uk> <20060608095522.GA30946@elte.hu>
 <1149764032.10056.82.camel@imp.csi.cam.ac.uk> <20060608161130.GA6869@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jun 2006, Ingo Molnar wrote:
> * Anton Altaparmakov <aia21@cam.ac.uk> wrote:
> > >   &ni->mrec_lock  - a spinlock protecting a particular inode's MFT data. 
> > >                     (finegrained lock for the MFT record) It is 
> > >                     typically taken by map_mft_record() and released by 
> > >                     unmap_mft_record().
> > 
> > Correct, except s/spinlock/semaphore/ (that really should become a 
> > mutex one day).
> 
> yeah - it's in fact a mutex already.
> 
> > No it is not as explained above.  Something has gotten confused 
> > somewhere because the order of events is the wrong way round...
> 
> did my second trace make more sense? The dependency that the validator 

Which one was that?  Could you please quote it again so we both know we 
are talking about the same thing?

> recorded can be pretty much taken as granted - it only stores 
> dependencies that truly trigger runtime. What shouldnt be taken as 
> granted is my explanation of the events :-)

Ok. (-:

> there is a wide array of methods and APIs available to express locking 
> semantics to the validator in a natural and non-intrusive way [for cases 
> where the validator gets it wrong or simply has no way of auto-learning 
> them] - but for that i'll first have to understand the locking semantics
> :-)

Indeed. (-:

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
