Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbTCJXwW>; Mon, 10 Mar 2003 18:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262327AbTCJXwV>; Mon, 10 Mar 2003 18:52:21 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:51643 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S262078AbTCJXwM>;
	Mon, 10 Mar 2003 18:52:12 -0500
Date: Tue, 11 Mar 2003 01:02:30 +0100 (MET)
From: Mikael Pettersson <mikpe@user.it.uu.se>
Message-Id: <200303110002.h2B02Uxa025848@harpo.it.uu.se>
To: perfctr-devel@lists.sourceforge.net
Subject: perfctr-2.5.0 released
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2.5.0 of perfctr, the Linux/x86 performance
monitoring counters driver, is now available at the usual
place: http://www.csd.uu.se/~mikpe/linux/perfctr/

Quick guide to porting source code from perfctr-2.4 to perfctr-2.5:
1. 'evntsel_aux[]' in the x86 struct perfctr_cpu_control is
   now 'p4.escr[]' (moved to sub-struct and renamed).
2. 'nrcpus' is gone from the perfctr info struct. It can be
   computed from the 'cpus' bitmask.
3. 'version[]' in perfctr info is now 'driver_version[]'.
4. The VPERFCTR_STOP ioctl is gone. Use VPERFCTR_CONTROL instead.
   The library's vperfctr_stop() procedure still works.
5. The API to global-mode performance counters has changed.
   The target CPU number is now included in the per-cpu
   control and state arrays. See examples/global/global.c.

Other noteworthy changes from perfctr-2.4:
1. The patch kit supports aliases, which allows kernels to share
   patch files. The 'update-kernel' script handles this.
2. 'make install' will now install the library, include files,
   and the 'perfex' example program at user-specified locations.
3. The library will now check that the ABI the library was
   compiled for is compatible with the kernel driver.
4. A preliminary library API for remote access to other processes'
   virtual performance counters has been added.
5. The library now contains proper data structures with event set
   and unit mask descriptions. This handles all supported CPUs
   except for P4 (mostly done, but some tricky details remain).
6. A perfctr-patched kernel can now be compiled on non-x86 archs
   without causing compilation errors.
7. Global-mode (non pre-process) counters now work in 2.5 kernels,
   and on hyper-threaded P4s. Several API changes were needed for this.

Version 2.5.0, 2003-03-10
- Added a simple user-space library API for accessing other
  processes' virtual performance counters. This uses a new
  type and a new set of operations since remote access has
  different requirements than accessing one's own counters.
  Following Mike Marty's suggestion, I left out the process
  control calls needed around these operations (ptrace() and
  wait()), so applications must handle that themselves.
- Added 'make install' support for the user-space components.
- Driver API cleanups. The 'eventsel_aux[]' array in 'struct
  perfctr_cpu_control' has been renamed as 'escr[]' and has been
  moved into the 'p4' sub-structure. (The change highlights the
  fact that this field was and is P4-only.) The 'version[]' string
  in 'struct perfctr_info' has been renamed to 'driver_version[]',
  since perfctr_info now also contains an 'abi_version' field.
  Some changes in the driver ABI: while not strictly necessary,
  they clean things up and make room for future changes. The ABI
  changed anyway from perfctr-2.4, so this shouldn't be a problem.
- Added a perfctr_cpu_control_print() procedure to the library,
  and updated the example programs to use it.
- Updated the perfex example program's help text to describe the
  syntax and meaning of event specifiers.
- Patch kit updates for 2.2.24/2.4.18-26(RedHat)/2.5.64 kernels.

/ Mikael Pettersson
