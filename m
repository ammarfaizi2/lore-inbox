Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264183AbUFPQap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264183AbUFPQap (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 12:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUFPQa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 12:30:29 -0400
Received: from smtpout.azz.ru ([81.176.67.34]:52190 "HELO mailserver.azz.ru")
	by vger.kernel.org with SMTP id S264153AbUFPQ3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 12:29:46 -0400
Message-ID: <40D075DA.2000007@vlnb.net>
Date: Wed, 16 Jun 2004 20:31:22 +0400
From: Vladislav Bolkhovitin <vst@vlnb.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040512
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [ANNOUNCE] Generic SCSI Target Middle Level for Linux (SCST) with
 target drivers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to announce the first public release of a generic SCSI
target middle level subsystem for Linux (SCST) with Qlogic 2200/2300
target driver and a patch for for UNH-iSCSI Target 1.5.3 to work over
SCST.

SCST is designed to provide unified, consistent interface between SCSI
target drivers and Linux kernel and simplify target drivers development
as much as possible. It has the following features:

  - Very low overhead, fine-grained locks and simplest commands
    processing path, which allow to reach maximum possible performance
    and scalability that close to theoretical limit.

  - Incoming requests can be processed in the caller's context or in
    one of the internal SCST's tasklets, therefore no extra context
    switches required.

  - Complete SMP support.

  - Undertakes most problems, related to execution contexts, thus
    practically eliminating one of the most complicated problem in the
    kernel drivers development. For example, a target driver for Qlogic
    2200/2300 cards, which has all necessary features, is about 2000
    lines of code long, that is at least in several times less, than
    the initiator one.

  - Performs all required pre- and post- processing of incoming
    requests and all necessary error recovery functionality.

  - Emulates necessary functionality of SCSI host adapter, because from
    a remote initiator's point of view SCST acts as a SCSI host with
    its own devices. Some of the emulated functions are the following:

     o  Generation of necessary UNIT ATTENTIONs, their storage and
        delivery to all connected remote initiators (sessions).

     o  RESERVE/RELEASE functionality.

     o  CA/ACA conditions.

     o  All types of RESETs and other task management functions.

     o  REPORT LUNS command as well as SCSI address space management in
        order to have consistent address space on all remote initiators,
        since local SCSI devices could not know about each other to
        report via REPORT LUNS command. Additionally, SCST responds with
        error on all commands to non-existing devices and provides
        access control (not implemented yet), so different remote
        initiators could see different set of devices.

     o  Other necessary functionality (task attributes, etc.) as
        specified in SAM-2, SPC-2, SAM-3, SPC-3 and other SCSI
        standards.

  - Device handlers architecture provides extra reliability and security
    via verifying all incoming requests and allows to make any
    additional requests processing, which is completely independent
    from target drivers, for example, device dependent exceptional
    conditions treatment or data caching.

Interoperability between SCST and local SCSI initiators (like sd, st) is
the additional issue that SCST is going to address (it is not
implemented yet). It is necessary, because local SCSI initiators can
change the state of the device, for example RESERVE the device, or some
of its parameters and that would be done behind SCST, which could lead
to various problems. Thus, RESERVE/RELEASE commands, locally generated
UNIT ATTENTIONs, etc. should be intercepted and processed as if local
SCSI initiators act as remote SCSI initiators connected to SCST.

Interface between SCST and target drivers is based on work, done by
InterOperability Lab (IOL) of University of New Hampshier (UNH).

In addition, the project contains a target driver for Qlogic 2200/2300
Fibre Channel cards and a patch for for UNH-iSCSI Target 1.5.3 that
makes it work over SCST.

In the current version 0.9.1 SCST looks to be quite stable (for beta)
and useful. The same is for Qlogic 2200/2300 target driver. Only 2.4
kernels currently supported, but update for 2.6 is coming soon. No
kernel patches are necessary. Tested on i386 only, but should work on
any other supported by Linux platform.

More information, including the source code and detail documentation, 
could be found on http://scst.sf.net.

Any comments would be appreciated.

Vlad
