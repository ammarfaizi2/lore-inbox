Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWF0LwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWF0LwF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 07:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWF0LwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 07:52:04 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:12196 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932256AbWF0LwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 07:52:03 -0400
Subject: [RFC][PATCH 0/3] Process events biarch bug: Intro
From: Matt Helsley <matthltc@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 04:47:01 -0700
Message-Id: <1151408822.21787.1807.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The events sent by Process Events from a 64-bit kernel are not binary compatible
with what a 32-bit userspace program would expect to recieve because the timespec
struct (used to send a timestamp) is not the same. This means that fields stored
after the timestamp are offset and programs that don't take this into account
break under these circumstances.

This is a problem for 32-bit userspace programs running with 64-bit kernels on
ppc64, s390, x86-64.. any "biarch" system.

This series:

1 - Gives a name to the union of the process events structure so it may be used
	to work around the problem from userspace.
2 - Comments on the bug and describes a userspace workaround in
	Documentation/connector/process_events.txt
3 - Implements a second connector interface without the problem
	(Removing the old interface or changing the definition would break
	 binary compatibility)

Compiled, booted, and lightly tested.

Comments or suggestions on alternate approaches would be appreciated.

Cheers,
	-Matt Helsley

