Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264157AbUDGVfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264181AbUDGVfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 17:35:44 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:47267 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264157AbUDGVfj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 17:35:39 -0400
Date: Wed, 7 Apr 2004 16:35:27 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Andy Isaacson <adi@hexapodia.org>
cc: Andrew Morton <akpm@osdl.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <20040407204341.GF2814@hexapodia.org>
Message-ID: <Pine.GSO.4.21.0404071627530.9017-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you want to add O_DIRECT support to dd then it should be implemented
> > properly, and that means implementing it for both read and write.
> > 
> > In fact the user should be able to specify the read-O_DIRECT and the
> > write-O_DIRECT independently - if for no other reason than that the source
> > and dest filesytems may not both support O_DIRECT.
> 
> Of course if both directions are supported they must be independently
> specifiable.  I just don't see a compelling use case for the input side.

Andy, since I was the one who suggested adding a conv=odirect flag to the
output side, so that we could use a standard tool (dd) to force
reallocation of bad sectors by writing to them, let me argue that it ALSO
makes sense to allow O_DIRECT (as an independent option) on the input
side.

At least one obvious use is to help FIND unreadable disk sectors (or to
verify that some sector is indeed unreadable).  One would like to be able
to do:

  dd if=/dev/hda of=/dev/null bs=512 count=1 skip=LBA conv=idirect

and see if the dd suceeds or fails.

If dd fails, then without having an O_DIRECT option (idirect) at the input
side, there is no way of telling if the failure was because of an
unreadable sector at LBA, or an unreadable sector somewhere else in the
block containing LBA. With the O_DIRECT input option, you can be sure that
if this command fails it's because the sector at LBA was unreadable, not
some nearby sector.

Cheers,
	Bruce

