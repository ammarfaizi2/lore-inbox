Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWDSFG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWDSFG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 01:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbWDSFG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 01:06:27 -0400
Received: from nproxy.gmail.com ([64.233.182.189]:57132 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750815AbWDSFG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 01:06:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SRe2vp3Ev3lggL3de0NeFWmOKzmcCkN/drdwt67bWwXyZEVtV0aawyN029TqG23cLWtw4xZhBQWZd1/PqZyEXNCL0KYVLz0rqiO3j537P7ehVCsEV4KOcAwXAuKhDzXjZi/FemT6lRCeWh19Nx4z3b7BxiyexnMaXg3mU9gQHtE=
Message-ID: <38b19aa60604182206u17ad7ca3y3cd1486856d4adea@mail.gmail.com>
Date: Wed, 19 Apr 2006 00:06:25 -0500
From: "Hareesh Nagarajan" <hnagar2@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: pkMem: A transactional, zero copy, shared memory based mechanism for IPC
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

As a part of my masters project, I have written an IPC mechanism for the
Linux kernel called pkMem. The description of the mechanism follows:

<abstract>
pkMem is a shared memory space that is mapped into every process on
the system at exactly the same virtual address.  By default, a process
cannot access this space.

During transactions, parts of pkMem are made accessible to the process for
reading or writing.  The transactional semantics means that either the entire
transaction occurs or that none of the transaction occurs and moreover that
transactions appear to occur at a single instant in time without interleaving
from other transactions - in other words, the transaction is _atomic_.  The
semantics of pkMem are very clean.

The most common alternative to pkMem are threads, in which a set of threads
share the same address space, with full access rights.  In the pkMem mechanism
for Inter-Process Communication (IPC), processes share this well defined region
and unlike threads, must use the transactional mechanism to access
pkMem.

Other benefits include:
- An object in pkMem has the same address in every process.  This implies
  that pointer-based data structures such as trees, lists and graphs may be
  accessed identically from every process on the system, thus eliminating the
  need to convert pointer-based structures into linear form or to remap
  pointers.
- Because pkMem is shared memory, during IPC zero copies of the data
  are required. But, unlike traditional shared memory, processes using the
  pkMem mechanism do not need to use semaphores or any other form of
  locking, to protect concurrent access to the region.
</abstract>

The report (which takes the style of a design document/tutorial) can be
downloaded from here:
    http://cs.uic.edu/~hnagaraj/pkmem/hareesh-masters.pdf

The patches and the examples can be downloaded from here:
    http://cs.uic.edu/~hnagaraj/pkmem/

For an executive summary, the following sections might be of interest:
    Abstract, 2, 3, 5.1, 5.2, 9.1.3, 9.2

Comments and suggestions are more than welcome.

Thanks,

./hareesh
