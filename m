Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278661AbRJXRCr>; Wed, 24 Oct 2001 13:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278664AbRJXRCh>; Wed, 24 Oct 2001 13:02:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54970 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278661AbRJXRC3>; Wed, 24 Oct 2001 13:02:29 -0400
Date: Wed, 24 Oct 2001 10:01:28 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Patrick Mochel <mochel@osdl.org>,
        Jonathan Lundell <jlundell@pobox.com>
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011024100127.A14124@beaverton.ibm.com>
In-Reply-To: <E15wLfj-0001C8-00@the-village.bc.nu> <20011024130408.23754@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20011024130408.23754@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Wed, Oct 24, 2001 at 03:04:08PM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt [benh@kernel.crashing.org] wrote:
> Now, I'm not sure what would happen with RAID. If we need to have logical
> volumes be child of the sd "client", then we have to face the fact that
> a given child may have multiple parents... welcome to the power graph !

You do not have to add RAID to need to worry about multiple parents. If we
want to correctly represent devices that have multiple paths (i.e twin
tailed SCSI, fibre channel, multi-ported devices, etc) we should have a
solution to handle this.  Some O/S's have moved to directed graphs to
address the multiple parent issue. Exposing only one block / character
device per real physical device would reduce O/S resources (major /
minors, structs) and provide a single request queue.

The current model of a scsi_device having a single parent and being
attached to the scsi_host host_queue has made adding multi-path support
to Linux below the SCSI lower level driver difficult.

> But do we really need logical volumes to be part of the PM tree or
> can blocking of requests at the sd layer be enough ? Remember we are
> in pass2, we have already done memory allocation, we are supposed to
> no longer swap nor do any disk/storage related activity.
> 
> A tricky issue indeed...
> 
> 
> Ben.

-Mike
-- 
Michael Anderson
andmike@us.ibm.com

