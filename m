Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131563AbRDCICJ>; Tue, 3 Apr 2001 04:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDCICA>; Tue, 3 Apr 2001 04:02:00 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:56593 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131587AbRDCIBy>; Tue, 3 Apr 2001 04:01:54 -0400
From: Amon Ott <ao@rsbac.org>
To: linux-kernel@vger.kernel.org
Subject: Announce: RSBAC v1.1.1 released
Date: Tue, 3 Apr 2001 09:57:47 +0200
X-Mailer: KMail [version 1.0.29.2]
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <01033009555302.00919@marvin>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rule Set Based Access Control (RSBAC) version 1.1.1 has been released.
Information and downloads are available from
http://www.rsbac.org

Amon Ott.

---------------------------------------

Name:          rsbac
Version:       1.1.1
Kernelver:     2.2.18-19, 2.4.2-3
Status:        9 (UP), 8 (SMP)
Author:        Amon Ott <ao@rsbac.org>
Maintainer:    Amon Ott <ao@rsbac.org>
Description:   Rule Set Based Access Control (RSBAC)
Date:          28-March-2001
Descfile-URL:  http://www.rsbac.org/rsbac.desc
Download-URL:  http://www.rsbac.org/download.htm
Homepage-URL:  http://www.rsbac.org/
Manual-URL:    http://www.rsbac.org/instadm.htm

What is RSBAC?
--------------

RSBAC is a flexible, powerful and fast open source access control framework
for current Linux kernels, which has been in stable production use for over
a year (since version 1.0.9a).

The standard package includes a range of access control models like MAC, RC,
ACL (see below). Furthermore, the runtime registration facility (REG) makes
it easy to implement your own access control model as a kernel module and
get it registered at runtime.

The RSBAC framework is based on the Generalized Framework for Access Control
(GFAC) by Abrams and LaPadula. All security relevant system calls are
extended by security enforcement code. This code calls the central decision
component, which in turn calls all active decision modules and generates a
combined decision. This decision is then enforced by the system call
extensions.

Decisions are based on the type of access (request type), the access target
and on the values of attributes attached to the subject calling and to the
target to be accessed. Additional independent attributes can be used by
individual modules, e.g. the privacy module (PM). All attributes are stored in
fully protected directories, one on each mounted device. Thus changes to
attributes require special system calls provided.

As all types of access decisions are based on general decision requests,
many different security policies can be implemented as a decision module.
Apart from the builtin models shown below, the optional Module Registration
(REG) allows for registration of additional, individual decision modules at
runtime.

In RSBAC version 1.1.1, the following modules are included. Please note that
all modules are optional. They are described in detail in an extra text.

MAC:  Bell-LaPadula Mandatory Access Control (compartments limited to a number
      of 64)

FC:   Functional Control. A simple role based model, restricting access to
      security information to security officers and access to system
      information to administrators.

SIM:  Security Information Modification. Only security administrators are
      allowed to modify data labeled as security information

PM:   Privacy Model. Simone Fischer-Hübner's Privacy Model in its first
      implementation. See our paper on PM implementation (43K) for the
      National Information Systems Security Conference (NISSC 98)

MS:   Malware Scan. Scan all files for malware on execution (optionally on all
      file read accesses or on all TCP/UDP read accesses), deny access if
      infected. Currently the Linux viruses Bliss.A and Bliss.B and a handfull
      of others are detected. See our paper on Approaches to Integrated
      Malware Detection and Avoidance (34K) for The Third Nordic Workshop on
      Secure IT Systems (Nordsec'98)

FF:   File Flags. Provide and use flags for dirs and files, currently
      execute_only (files), read_only (files and dirs), search_only (dirs),
      secure_delete (files), no_execute (files), add_inherited (files and dirs)
      and no_rename_or_delete(files and dirs, no inheritance). Only security
      officers may modify these flags.

RC:   Role Compatibility. Defines 64 roles and 64 types for each target type
      (file, dir, dev, ipc, scd, process). For each role, compatibility to all
      types and to other roles can be set individually and with request
      granularity. For administration there is a fine grained
      separation-of-duty.

AUTH: Authorization enforcement. Controls all CHANGE_OWNER requests for
      process targets, only programs/processes with general setuid allowance
      and those with a capability for the target user ID may setuid.
      Capabilities can be controlled by other programs/processes, e.g.
      authentication daemons.

ACL:  Access Control Lists. For every object there is an Access Control List,
      defining which subjects may access this object with which request types.
      Subjects can be of type user, RC role and ACL group. Objects are grouped
      by their target type, but have individual ACLs. If there is no ACL entry
      for a subject at an object, rights are inherited from parent objects,
      restricted by an inheritance mask. Direct (user) and indirect (role,
      group) rights are accumulated. For each object type there is a default
      ACL on top of the normal hierarchy. Group management has been added in
      version 1.0.9a.

A general goal of RSBAC design has been to some day reach (obsolete) Orange
Book (TCSEC) B1 level. Now it is mostly targeting to be useful as secure and
multi-purposed networked system, with special interest in firewalls.


RSBAC Changes
-------------
1.1.1: - New target type FIFO, with a lot of cleanup, e.g. IPC type fifo
         removed
       - MAC module reworked, including MAC-Light option
       - Several bugfixes
       - Port to 2.4.0, 2.4.1 and 2.4.2
       - New Makefiles with lists for 2.4 and without for 2.2 kernels
         (Thanks to Edward Brocklesby for samples)
       - init process default ACI now partly depends on root's ACI
       - Optional interception of sys_read and sys_write.
         Attention: you might have to add READ and WRITE rights to files,
         fifos, dirs and sockets first, if upgrading from an older version
       - REG overhaul. Now you can register syscall functions, everything is
         kept in unlimited lists instead of arrays and registering is
         versioned to allow for binary module shipping with REG version
         checks.
       - Inheritance is now fixed, except for MAC model
       - MAC: optional inheritance, new option Smart Inheritance that tries
         to avoid new attribute objects (see config help)
       - New soft mode option: all decisions and logging are performed, but
         DO_NOT_CARE is returned to enforcement. Off by default. See config
         help for details.
       - Optional initialization in extra rsbac_initd thread.
