Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKLR4>; Mon, 11 Dec 2000 06:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbQLKLRq>; Mon, 11 Dec 2000 06:17:46 -0500
Received: from zeus.kernel.org ([209.10.41.242]:64264 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129183AbQLKLRk>;
	Mon, 11 Dec 2000 06:17:40 -0500
From: Amon Ott <ao@rsbac.org>
To: info@linuxsecurity.com, linux-kernel@vger.kernel.org
Subject: Announce: RSBAC v1.1.0 released
Date: Mon, 11 Dec 2000 10:46:05 +0100
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <00120812571000.00838@marvin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rule Set Based Access Control (RSBAC) for Linux version 1.1.0 has been released.
Information and downloads are available from
http://www.rsbac.org

Amon Ott.

----------------------
Name:          rsbac
Version:       1.1.0
Kernelver:     2.2.17, 2.4.0-test10,11
Status:        9 (UP), 7 (SMP)
Author:        Amon Ott <ao@rsbac.org>
Maintainer:    Amon Ott <ao@rsbac.org>
Description:   Rule Set Based Access Control (RSBAC)
Date:          30-November-2000
Descfile-URL:  http://www.rsbac.org/rsbac.desc
Download-URL:  http://www.rsbac.org/download.htm
Homepage-URL:  http://www.rsbac.org/
Manual-URL:    http://www.rsbac.org/instadm.htm

What is RSBAC?
--------------
RSBAC is an open source security extension for current Linux kernels.
It is based on the Generalized Framework for Access Control (GFAC) by
Abrams and LaPadula and provides a flexible system of access control
based on several modules.

All security relevant system calls are extended by security
enforcement code. This code calls the central decision component, which
in turn calls all active decision modules and generates a combined decision.
This decision is then enforced by the system call extensions.

Decisions are based on the type of access (request type), the access target
and on the values
of attributes attached to the subject calling and to the target to be
accessed. Additional independent attributes can be used by individual modules,
e.g. the
privacy module (PM). All attributes are stored in fully protected
directories, one on each mounted device. Thus changes to attributes require
special system calls provided.

As all types of access decisions are based on general decision requests,
many different security policies can be implemented as a decision module. In
the current RSBAC version (1.1.0), eight modules are included:

MAC: Bell-LaPadula Mandatory Access Control (limited to 64 compartments)

FC: Functional Control. A simple role based model, restricting access
to security information to security officers and access to system
information to administrators.

SIM: Security Information Modification. Only security
administrators are allowed to modify data labeled as security information

PM: Privacy Model. Simone Fischer-Huebner's Privacy Model in its first
implementation. See our paper on PM implementation for the National
Information Systems Security Conference (NISSC 98)

MS: Malware Scan. Scan all files for malware on execution
(optionally on all file read accesses or on all TCP/UDP read accesses),
deny access if infected. Currently the Linux viruses Bliss.A and Bliss.B
and a handfull of others are detected. See our paper on malware detection
and avoidance for The Third Nordic Workshop on Secure IT Systems (Nordsec'98)

FF: File Flags. Provide and use flags for dirs and files,
currently execute_only (files), read_only (files and dirs), search_only
(dirs), secure_delete (files) and add_inherited (files and dirs).
Only security officers may modify these flags.

RC: Role Compatibility. Defines (up to) 64 roles and 64 types for each
target type (file, dir, dev, ipc, scd, process). For each role compatibility
to all types and to other roles can be set individually and with request
granularity.

AUTH: Authorization enforcement. Controls all CHANGE_OWNER
requests for process targets, only programs/processes with general setuid
allowance and those with a capability for the target user ID may setuid.
Capabilities are controlled by other programs/processes.

ACL: Access Control Lists. For every object there is an Access Control List,
defining which subjects may access this object with which request types.
Subjects can be of type user, RC role and ACL group. Objects are grouped
by their target type, but have individual ACLs. If there is no ACL entry for a
subject at an object, rights are inherited from parent objects, restricted by
an inheritance mask. Direct (user) and indirect (role, group) rights are
accumulated.
For each object type there is a default ACL on top of the normal hierarchy.
Group management has been added in version 1.0.9a.

The underlying models are described in the module description at RSBAC
homepage (http://www.rsbac.org).

A general goal of RSBAC has been to some day reach (obsolete) Orange Book
(TCSEC) B1 level. Now it is mostly targeting to be useful as secure and
multi-purposed networked system, with special interest in firewalls.


Changes against 1.0.9b:
-----------------
       - Port to 2.4.0-test11
       - Interception of sys_mmap and sys_mprotect added. Now execution of
         library code requires EXECUTE privilege on the library file, and
         setting non-mmapped memory to EXEC mode requires EXECUTE on target
         NONE.
       - MAC Light option by Stanislav Ievlev added. See kernel config help or
         modules.htm.

       - Port to 2.4.0-test{[789]|10}, this means major changes to the lookup
        and inheritance code - of course #ifdef'd
       - Change string declarations to kmalloc. On the way moved
         MAX_PATH_LEN restriction from 1999 to max_kmalloc - 256
         (>127K).
       - Renamed several PM xy.class to xy.object_class for C++
         compatibility
       - Added SCD type ST_kmem
       - Changed rc_force_role default to rc_role_inherit_parent,
         terminated at root dir with old default rc_role_inherit_mixed.
         This makes it much easier to keep a dir of force-roled binaries.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
