Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316509AbSEOWb4>; Wed, 15 May 2002 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316510AbSEOWbz>; Wed, 15 May 2002 18:31:55 -0400
Received: from waste.org ([209.173.204.2]:51340 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316509AbSEOWbx>;
	Wed, 15 May 2002 18:31:53 -0400
Date: Wed, 15 May 2002 17:31:31 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: "chen, xiangping" <chen_xiangping@emc.com>
cc: "'Jes Sorensen'" <jes@wildopensource.com>,
        "'Steve Whitehouse'" <Steve@ChyGwyn.com>,
        <linux-kernel@vger.kernel.org>
Subject: RE: Kernel deadlock using nbd over acenic driver.
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A52@srgraham.eng.emc.com>
Message-ID: <Pine.LNX.4.44.0205151723390.24102-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2002, chen, xiangping wrote:

> But how to avoid system hangs due to running out of memory?
> Is there a safe guide line? Generally slow is tolerable, but
> crash is not.

If the system runs out of memory, it may try to flush pages that are
queued to your NBD device. That will try to allocate more memory for
sending packets, which will fail, meaning the VM can never make progress
freeing pages. Now your box is dead.

The only way to deal with this is to have a scheme for per-socket memory
reservations in the network layer and have NBD reserve memory for sending
and acknowledging packets. NFS and iSCSI also need this, though it's a
bit harder to tickle for NFS. SCSI has DMA reserved memory for analogous
reasons.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

