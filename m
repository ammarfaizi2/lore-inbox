Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUCLM75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 07:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbUCLM75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 07:59:57 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:23179 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262071AbUCLM7x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 07:59:53 -0500
Subject: [ANNOUNCE] Umbrella - process based mandatory access control
From: Kristian Soerensen <ks@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Cc: umbrella@cs.auc.dk
Content-Type: text/plain; charset=
Message-Id: <1079096383.27177.46.camel@homer.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 12 Mar 2004 13:59:43 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am proud to announce the official launch of the Umbrella security
project for Linux on handheld devices.

Umbrella implements a combination of process based mandatory access
control and authentication of files. Umbrella relies on the efford of
developers, in order to implement a secure system. It is our philosophy
that it is not possible to make a secure Linux system without involving
the developers of the various applications used on the system!

The design of Umbrella is aimed to be very simple for developers to use
and understand. It is not possible to make an ambiguous security
configuration for Umbrella - unlike more complex security mechanisms
like e.g. Security-Enhanced Linux.

You may find more details below and on our web site:
http://umbrella.sourceforge.net

Umbrella-0.2 can be downloaded and tested from:


Any questions or comments are most welcome!


Have a nice weekend!

Cheers,
Kristian Sørensen - on behald of The Umbrella Team.


-- UMBRELLA INTRODUCTION --
In designing Umbrella for handheld devices, there are several criteria
that differ from that of regular computer systems. The most important
are the available resources and the fact that heavy change in software
do not occur. Furthermore the PDA, used for test purposes in this
project, is not a development tool only a computer intended to do
specific tasks such as organizer, email, games, communication etc.

Though resources on handhelds are limited, the devices has become
increasingly more powerful and able to run a wide range of programs from
different vendors. Umbrella is designed, such that software can be
executed in a secure manner and thereby protecting the system against
malicious code and viruses.

The overall structure of Umbrella is a mandatory access control scheme
for running processes together with an authentication of files and run
time integrity checking of the executables.


-- PROCESS BASED MAC --
The idea of processes based mandatory access control is strongly
supported by the tree structure for processes in Linux.

Umbrella gives every process in Linux a set of restrictions. The rule is
that every process must be at least as restricted as it parent. In
practice, this works as inheritance: When forking a new process, it
immediately gets the restrictions of it's parent, and if the parent have
specified more restrictions for it's child(ren) then the "child
restrictions" and the restrictions of the parent are combined (a union
of the two sets of restrictions).


-- WHAT IS RESTRICTIONS? --
A restriction is just a string, e.g. "/etc". These strings can represent
a path in the file system e.g. "/etc/passwd" or "/etc" or the
restriction can represent a special ability e.g. "net" or "fork".

A path restriction restricts the process from the specified directory
and everything below it. If the path-restriction is a file, nothing
below exists, and the process is thus restricted from that single file
only.

Ability restrictions is used to restrict from special operations, that
cannot be restricted through files. An example of this is the network,
which is only handled through the kernel. The restrictions for the
network, the ability to fork new processes and others is handled within
Umbrella.

It will be very easy to add new path restrictions to the system, as the
way they are handled within the kernel are the same. From a
user/programmer point of view, the interface will be made very simple
(not implemented yet). Adding more ability restrictions require small
modifications of the Umbrella code (hook implementations). At first we
aim to implement the general, but simple, ability restrictions (like net
and fork). However it is fairly easy to extend these to implement more
fine grained restrictions.

-- 
Kristian Soerensen <ks@cs.auc.dk>

