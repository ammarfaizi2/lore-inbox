Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUHDJOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUHDJOR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUHDJOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:14:17 -0400
Received: from fmr06.intel.com ([134.134.136.7]:27112 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261951AbUHDJOO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:14:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Wed, 4 Aug 2004 02:13:23 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR6AzoIf/fvAHBFRDiCOBJA/2fSfQ==
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>
X-OriginalArrivalTime: 04 Aug 2004 09:13:42.0786 (UTC) FILETIME=[567ED620:01C47A03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

Fusyn aims to provide primitives to solve a bunch of gaps in POSIX
compliance related to mutexes, conditional variables and semaphores,
POSIX Advanced real-time support as well as adding mutex robustness
(to dying owners) and deep deadlock checking.

All of these primitives are available to both kernel space and user
space (through a generalization of the mechanism used by futexes),
allowing for a fast path on most mutex operations.

We strive to solve the POSIX gap of scheduling-policy based
unlock/wakeup for mutexes, conditional variables, semaphores,
etc; the lacks in Advanced Real-Time support (priority inversion
protection through priority inheritance and priority protection),
robust mutexes (mutex waiters no longer deadlock when a mutex
owner dies) and deep deadlock checking for mutexes.

The full description of the gaps we solve, rationales behind the
implementation and explanations on the need for the new features
is kind of long to fully explain here, so you can find it in the
linux/Documentation/fusyn-why.txt after applying our patch or at
our website, in:

http://developer.osdl.org/dev/robustmutexes/index.html#Documentation

High level changelog since release 2.3:

- Not much, ported to 2.6.7 vanilla.

However, this showed that we weren't properly locking when
obtaining pages from an 'struct address_mapping' [function
__vl_key_page_get_shared()]...so we fixed that.

Still to-do:

- Finally finish implementing priority protection; the core is
there, only the glue to use it is needed.

- Wipe out debug stuff

- Call fuqueue_waiter_cancel() into try_to_wake_up?

The patch is split in the following parts:

1/11: documentation files
2/11: priority based O(1) lists
3/11: kernel fuqueues
4/11: kernel fulocks
5/11: user space/kernel space tracker
6/11: user space fuqueues
7/11: user space fulocks
8/11: Arch-specific support
9/11: Modifications to the core: basic
10/11: Modifications to the core: struct timeout
11/11: Modifications to the core: scheduler

We are not posting it to the list, as it has grown kind of
big. It can be obtained at out web site mentioned above, in the
Download section.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)

