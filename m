Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281371AbRKZGTn>; Mon, 26 Nov 2001 01:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281474AbRKZGTd>; Mon, 26 Nov 2001 01:19:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:12293
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S281371AbRKZGTU>; Mon, 26 Nov 2001 01:19:20 -0500
Date: Sun, 25 Nov 2001 22:17:23 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: *** SPINDLE Storage model proposed *** FS/BLOCK/SPINDLE
Message-ID: <Pine.LNX.4.10.10111252130350.6072-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


*** FS/BLOCK/SPINDLE Storage model proposed, initial outline ***

First reverse the order to be SPINDLE/BLOCK/FS, that is better.

All Low-Level "Real Spindle Device" RSD, are to be require to follow a
global design model.  This is to describe three (3) primary componets and
up to three (3) additional extention.

Prime-Core-1:  LOW-LEVEL
        Direct LOW-LEVEL Comand mode access through the attached
        HOST-Controller and all associated device classes attached.
        The importance of this componet is to allow diagnostics,
        data integrity checking, extented mode, and raw benchmarks
        (plus corrections for copy_to/from_user kernel<>user-space).

Prime-Core-2:  PERSONALITY
        Each device class associated with the transport layer of any given
        storage class, shall have a unique/self-contained driver to
        internally handle and/or force up errors/failures to the top
        layer or associated extention.

Prime-Core-3:  MAIN LOOP
        Main LOOP routing of incoming requests and redirection to the
        various attached device personalities list.  It shall accept only
        request that are mapped to real-physical (loose term) LBA or
        associated BLOCK labeling scheme.  It shall have the means to
        perform direct error assertion from the personality drivers back
        through the "Virtual Spindle Device" VSD.  Ultimately back to the
        main BLOCK and driven back to the FS for handling.

        The significance of the last line above is to address media
        failures on write to media events.

Ext-Core-1:  HOST-BRIDGE plugger to LOW-LEVEL
        In all DATA Transport Layers there are various "flavors" methods
        of developing the under lining known as the physical layer or
        hardware.  Specifically the Vendor and Model of the HOST
        Controller.  A HOST(hardware) is the card or socket that one
        attached the data ribbon(s) or cable(s) to the various personality
        hardware (drive, cdr-rw, streaming, target, ip, printer, etc).
        This is the effective "scsi-template" in today's kernel, and the
        "ata-template" in the future.

Ext-Core-2:  QUEUING Operations Plugger
        Currently SCSI and all other devices capable of mapping in to this
        storage class can potentially support the desired goal of service
        disconnet.  The ATA storage class shall support such feature in the
        future.  This Extention will prove to be the most painful to
        qualify against the the prim-core-1,2 above.

        Several of the key concerns to be addressed are the potential for
        caching violation, reordering by the device, media failure
        notification to journaling FS's to intercept the down block tag
        and prevent return until the buffer in question has been
        reallocated by the FS and pushed to platter.

Ext-Core-3:  STANDARD Glue Wrappers
        Nebula -- EEK.

        The creation of a generic API to allow any storage class to export
        it self to the BLOCK or IP-Stack.

        General WAG at this point but something will fill the gap


Once this RSD layer is created and stablized one can build anything on top
and have confidence that the provide discrete entry points will allow
proper probing and isolation of bugs/errors/exceptions.  This would also
prove a means to select and correct the single problem, generalize to a
given personality class, or establish a global solution.

--------------------------

The next part will describe VSD's and needed policies for protecting/accessing
the various components.  Of course there will need to be significant
input from the various maintainers of the LVM/RAID/etc folks but failing
to describing a ruleset here means, Linux could be questioned on its
storage maturity.



Respectfully,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

