Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbUCESbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 13:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUCESbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 13:31:21 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:26605 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262653AbUCESbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 13:31:16 -0500
To: linux-kernel@vger.kernel.org
Subject: ANNOUCE: OpenIB InfiniBand software
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 05 Mar 2004 10:31:15 -0800
Message-ID: <52znavp2mk.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Mar 2004 18:31:15.0430 (UTC) FILETIME=[0B093860:01C402E0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OPENIB.ORG INFINIBAND DRIVERS RELEASE -- 2004-03-05

  We are proud to announce the initial availability of the OpenIB.org
  InfiniBand stack.  This is a fully open source[1] InfiniBand stack
  that includes a low-level driver for Mellanox HCA hardware, a
  midlayer, and a number of useful upper-layer protocols including
  IP-over-InfiniBand, SCSI RDMA Protocol, Sockets Direct Protocol,
  uDAPL and MPI.  In addition userspace utilities are available,
  including the OpenSM subnet manager.

  [1]  See the section on SDP intellectual property for some important
       information, though.

  An initial drop of this source is available from
  <http://openib.org>.  Additional protocols and further enhancements
  will be added in upcoming releases.  In the next few days, we will
  also be bringing up mailing lists, source code control, and so on.

  We look forward to working with the entire Linux community to
  continue to develop these drivers.

TODO

  We are fully aware that our code is far from being acceptable for
  inclusion in the Linux kernel, and we are very committed to doing
  the hard work required to clean up the source.  We believe that in
  addition to the benefits of being in the standard kernel, we will
  find huge improvements in the quality, performance and robustness of
  our drivers.

  As a starting point, here is a list of some of the tasks we believe
  must be completed before these drivers can be seriously considered
  for inclusion in the kernel.  We would welcome any suggestions of
  tasks that we have forgotten.  Of course patches would be even
  better!

    * Use a more standard naming convention (tTS_IB_TYPE_NAME ->
      ib_type_name, tsIbFunctionName -> ib_function_name, etc)
    * Get rid of bizarro types such as tUINT32 -- replace with Linux
      standard u32 etc.
    * Run source through scripts/Lindent (and then fix by hand, since
      lots of things will no longer line up)
    * Get rid of XXX_exports.c files and move EXPORT_SYMBOL next to
      definition in source.
    * Change MODULE_PARM -> module_param
    * Use DMA mapping API so we work properly with non-coherent
      caches, IOMMUs etc. Add a function to get struct device * for an
      IB device so ULPs can call sync functions (embed struct device
      in struct ib_device?). (How do we handle systems with limited
      DMA mapping capacity?)
    * Fix up ioctls, userspace interface so that 32-bit userspace
      works with a 64-bit kernel.
    * Get rid of ib_poll module; move all timers to standard Linux
      timers (CM can use a work queue plus schedule_delayed_work).
    * Get rid of ib_services module (move TS_TRACE etc. to dev_printk)
    * Add missing pieces of API for currently unused IB features: deal
      with RD (EECs, etc -- including CM support), verbs extensions.
    * Get rid of IPoIB address hash and just use native 20-byte
      addresses (keep 6-byte hash as an option for compatibility
      with existing applications?)
    * Rewrite client query support (SA and DM) to be more extensible,
      simpler, deal with component mask.
    * Add sysfs support.
    * In Mellanox HCA driver, clean up mosal. Some obvious
      targets (there's lots more though):
          o Grunging through kernel code to find the mlock/munlock
            pointers especially has to go (mosal_mlock.c). We need to
            get VM experts from LKML to tell us how to handle memory
            translation and locking.
          o Turn MT_KERNEL back to __KERNEL__
          o Use native spinlocks.
          o Turn driver into a real PCI driver (rather than
            reimplementing a worse version of PCI bus scan).

SDP intellectual property

  Microsoft believes that they own certain intellectual property
  relating to the Sockets Direct Protocol (SDP)[2].  Therefore, we are
  including the following disclaimer required by Microsoft's license
  in SDP source that relates to the implementation of the protocol:

    "This source code may incorporate intellectual property owned by
    Microsoft Corporation. Our provision of this source code does not
    include any licenses or any other rights to you under any
    Microsoft intellectual property. If you would like a license from
    Microsoft (e.g., to rebrand, redistribute), you need to contact
    Microsoft directly."

  We realize that this is incompatible with open source licensing, and
  we are working to find a more satisfactory solution, but for the
  time being we are forced to comply with Microsoft's license.

  Please make sure you have fully understood the implications of
  Microsoft's claims before you redistribute any of the SDP source
  that contains the above disclaimer.

  [2]  <http://www.microsoft.com/mscorp/ip/standards/>
