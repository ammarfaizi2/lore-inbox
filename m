Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbUJZRhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUJZRhf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 13:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUJZRhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 13:37:34 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:56909 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S261353AbUJZRhV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 13:37:21 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: Accessing a user-mode stack from the kernel
Date: Tue, 26 Oct 2004 10:37:15 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C2051E1A3B@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Accessing a user-mode stack from the kernel
Thread-Index: AcS7gm8fODQFnBxITSykYZ0/YHG3mg==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Oct 2004 17:37:16.0597 (UTC) FILETIME=[6F9DC650:01C4BB82]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I've written a kernel module that is triggered by an IOCTL from
a user-space application. My kernel module needs to access the context
(x86, by the way) of the user process. So I have a call stack that looks
like this:

User application
        |
        V
IOCTL glibc wrapper
        |
        V
Kernel module

>From what I've been doing, I believe that I can get the context of the
IOCTL glibc wrapper without any problems. However, I need the next stack
frame up but have been unsuccessful in finding this stack frame from the
kernel's context (I stick 0xdeadcafe in EBX just before the IOCTL call
in the user application so I'll know when I see it).
	I've lifted portions on the ptrace() code into my kernel module
but that seems to return the IOCTL context when I use the getreg()
calls.
	Can anyone offer any advice? It would be much appreciated.
