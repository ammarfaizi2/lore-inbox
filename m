Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161108AbVIBXDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161108AbVIBXDi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161112AbVIBXDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:03:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:8350 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161108AbVIBXDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:03:37 -0400
In-Reply-To: <p73fysnqiej.fsf@verdi.suse.de>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux clustering <linux-cluster@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: GFS, what's remaining
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFC7B937B5.B0B2BC62-ON88257070.007B3980-88257070.007EAB21@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Fri, 2 Sep 2005 16:03:33 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_08142005|August 14, 2005) at
 09/02/2005 19:03:34,
	Serialize complete at 09/02/2005 19:03:34
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have to correct an error in perspective, or at least in the wording of 
it, in the following, because it affects how people see the big picture in 
trying to decide how the filesystem types in question fit into the world:

>Shared storage can be more efficient than network file
>systems like NFS because the storage access is often more efficient
>than network access

The shared storage access _is_ network access.  In most cases, it's a 
fibre channel/FCP network.  Nowadays, it's more and more common for it to 
be a TCP/IP network just like the one folks use for NFS (but carrying 
ISCSI instead of NFS).  It's also been done with a handful of other 
TCP/IP-based block storage protocols.

The reason the storage access is expected to be more efficient than the 
NFS access is because the block access network protocols are supposed to 
be more efficient than the file access network protocols.

In reality, I'm not sure there really is such a difference in efficiency 
between the protocols.  The demonstrated differences in efficiency, or at 
least in speed, are due to other things that are different between a given 
new shared block implementation and a given old shared file 
implementation.

But there's another advantage to shared block over shared file that hasn't 
been mentioned yet:  some people find it easier to manage a pool of blocks 
than a pool of filesystems.

>it is more reliable because it doesn't have a
>single point of failure in form of the NFS server.

This advantage isn't because it's shared (block) storage, but because it's 
a distributed filesystem.  There are shared storage filesystems (e.g. IBM 
SANFS, ADIC StorNext) that have a centralized metadata or locking server 
that makes them unreliable (or unscalable) in the same ways as an NFS 
server.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

