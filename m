Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S156032AbQFVQW0>; Thu, 22 Jun 2000 12:22:26 -0400
Received: by vger.rutgers.edu id <S156200AbQFVQWK>; Thu, 22 Jun 2000 12:22:10 -0400
Received: from mail-r4.shlink.de ([212.60.1.19]:3444 "HELO mail-r4.shlink.de") by vger.rutgers.edu with SMTP id <S156197AbQFVQVC>; Thu, 22 Jun 2000 12:21:02 -0400
Date: 22 Jun 2000 16:19:00 +0200
From: ao@ao.morpork.de (A. Ott)
To: linux-kernel@vger.rutgers.edu
Cc: rsbac@rsbac.org
Cc: suse-security@suse.com
Message-ID: <7gNrg-y44iB@ao.morpork.de>
Subject: [Announce]: RSBAC v1.0.9b released
X-Mailer: CrossPoint v3.11 R/A12916
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Hi to you all!

After quite a few pre's, version 1.0.9b of the Rule Set Based Access  
Control (RSBAC) package for the Linux kernel has been released.

You can find it on the RSBAC homepage at http://www.rsbac.org.

The changes against version 1.0.9a are:

 - Port to 2.3.42 - 2.3.99-pre3
 - Port to 2.2.14 - 2.2.16
 - 32 Bit Uid/Gid with new attribute versions
 - User and program based logging
 - AUTH capability ranges
 - Made write to MSDOS fs a config option, so use it on your own risk
    (see config help)
 - MAC levels 0-252 instead of 0-3
 - Added config option for ioport access (X support)


Patch Archive description:
-------------------------
Name:          rsbac
Version:       1.0.9b
Kernelver:     2.2.11 - 2.2.16, 2.3.42 - 2.3.99-pre3
Status:        8 (UP), unknown (SMP)
Author:        Amon Ott <ao@rsbac.org>
Maintainer:    Amon Ott <ao@rsbac.org>
Description:   Rule Set Based Access Control (RSBAC)
Date:          13-June-2000
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
the current RSBAC version (1.0.9b), eight modules are included:

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

--
Please remove second ao for E-Mail reply - no spam please!
## CrossPoint v3.11 ##

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
