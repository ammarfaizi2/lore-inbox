Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132502AbRDWWwR>; Mon, 23 Apr 2001 18:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132520AbRDWWus>; Mon, 23 Apr 2001 18:50:48 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:990 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S132511AbRDWWtZ>; Mon, 23 Apr 2001 18:49:25 -0400
Date: Mon, 23 Apr 2001 16:49:18 -0600
Message-Id: <200104232249.f3NMnI126351@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        viro@math.psu.edu (Alexander Viro), cr@sap.com (Christoph Rohland),
        parsley@linuxjedi.org (David L. Parsley), linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints?
In-Reply-To: <200104232242.f3NMgej516228@saturn.cs.uml.edu>
In-Reply-To: <200104232119.f3NLJZT24922@vindaloo.ras.ucalgary.ca>
	<200104232242.f3NMgej516228@saturn.cs.uml.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan writes:
> Richard Gooch writes:
> 
> > We want to take out that union because it sucks for virtual
> > filesystems. Besides, it's ugly.
> 
> I hope you won't mind if people trash this with benchmarks.

But they can't. At least, not for a well designed patch. If there is a
real issue of fragmentation, then there are ways to fix that without
using a bloated union structure. Don't punish some filesystems just
because others have a problem.

Solutions to avoid fragmentation:

- keep a separate VFSinode and FSinode slab cache
- allocate an enlarged VFSinode that contains the FSinode at the end,
  with the generic pointer in the VFSinode part pointing to FSinode
  part.

It's simply wrong to bloat everyone because some random FS found it
easier to thow in a union.

Besides, for every benchmark that shows how fragmentation hurts, I can
generate a benchmark showing how inode bloat hurts. Lies, damn lies
and benchmarks.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
