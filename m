Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264628AbSJVO5b>; Tue, 22 Oct 2002 10:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSJVO5b>; Tue, 22 Oct 2002 10:57:31 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:28585 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264628AbSJVO50>; Tue, 22 Oct 2002 10:57:26 -0400
From: Amon Ott <ao@rsbac.org>
To: news@securiteam.com, fyodor@insecure.org, sec@linux-sec.net,
       Achim Leitner <aleitner@linuxnewmedia.de>,
       Suse-Security <suse-security@suse.com>, linux-kernel@vger.kernel.org,
       suggestions@securityfocus.com, info@linuxsecurity.com,
       hemos@slashdot.org, avr@ix.heise.de
Subject: Announce: RSBAC v1.2.1 released
Date: Tue, 22 Oct 2002 17:06:21 +0200
X-Mailer: KMail [version 1.3.1]
Content-Type: text/plain;
  charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <1840Yr-2G3OOeC@fmrl11.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Rule Set Based Access Control (RSBAC) version 1.2.1 has been released.
Full information and downloads are available from http://www.rsbac.org

RSBAC is a flexible, powerful and fast open source access control framework
for current Linux kernels, which has been in stable production use since
January 2000 (version 1.0.9a). All development is independent of governments
and big companies, and no existing access control code has been reused.

This version comes with many smaller improvements against 1.2.0 and some new 
features, e.g.:

- New JAIL module, similar to the FreeBSD Jails functionality, but with 
extensions like individual IPC compartments.

- Support for all architectures (not all of them tested, feedback is welcome).

Amon Ott.

---------------------------------------
rsbac.desc:

Name:          rsbac
Version:       1.2.1
Kernelver:     2.2.21, 2.4.19
Status:        9 (UP), 8 (SMP)
Author:        Amon Ott <ao@rsbac.org>
Maintainer:    Amon Ott <ao@rsbac.org>
Description:   Rule Set Based Access Control (RSBAC)
Date:          23-Sep-2002
Descfile-URL:  http://www.rsbac.org/rsbac.desc
Download-URL:  http://www.rsbac.org/download.htm
Homepage-URL:  http://www.rsbac.org/
Manual-URL:    http://www.rsbac.org/instadm.htm

What is RSBAC?
--------------

Key features:

<ul>
  <li>Open Source (GPL)</li>
  <li>Independent of governments and big companies</li>
  <li>Several well-known and new security models, e.g. MAC, ACL and RC</li>
  <li>Control over individual user and program network accesses</li>
  <li>Any combination of models possible</li>
  <li>Easily extensible: write your own model for runtime registration</li>
  <li>Support for current kernels</li>
  <li>Stable for production use</li>
</ul>

RSBAC is a flexible, powerful and fast open source access control framework
for current Linux kernels, which has been in stable production use since
January 2000 (version 1.0.9a). All development is independent of governments
and big companies, and no existing access control code has been reused.

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
individual modules, e.g. the privacy module (PM). All attributes are stored
in fully protected directories, one on each mounted device. Thus changes to
attributes require special system calls provided.

>From version 1.2.0, all types of network accesses can be controlled
individually for all users and programs. This gives you full control over
their network behaviour and makes unintended network accesses easier to
prevent and detect.

As all types of access decisions are based on general decision requests,
many different security policies can be implemented as a decision module.
Apart from the builtin models shown below, the optional Module Registration
(REG) allows for registration of additional, individual decision modules at
runtime.

In the RSBAC version 1.2.1, the following modules are included. Please note
that all modules are optional. They are described in detail in an extra
text.

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
      secure_delete (files), no_execute (files), add_inherited (files and
      dirs), no_rename_or_delete(files and dirs, no inheritance) and
      append_only (files). Only FF security officers may modify these flags.

RC:   Role Compatibility. Defines roles and types for each target type
      (file, dir, dev, ipc, scd, process etc.). For each role, compatibility
      to all types and to other roles can be set individually and with
      request granularity. For administration there is a fine grained
      separation-of-duty. Granted rights can also have a time limit. 

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
      version 1.0.9a. Granted rights and group memberships can have a time
      limit. 

CAP:  Linux Capabilities (new in 1.2.0). For all users and programs you can
      define a minimum and a maximum Linux capability set ("set of root
      special rights"). This lets you e.g. run server programs as normal
      user, or restrict rights of root programs in the standard Linux way.

JAIL:
      Process Jails (new in 1.2.1). This module adds a new system call
      rsbac_jail, which is basically a superset of the FreeBSD jail system
      call. It encapsulates the calling process and all subprocesses in a
      chroot environment with a fixed IP address and a lot of further
      restrictions.

A general goal of RSBAC design has been to some day reach (obsolete) Orange
Book (TCSEC) B1 level. Now it is mostly targeting to be useful as secure and
multi-purposed networked system, with special interest in firewalls.

Amon Ott <ao@rsbac.org>

--
http://www.rsbac.org
