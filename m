Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268326AbUJMEKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268326AbUJMEKY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 00:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268333AbUJMEKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 00:10:24 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:17611 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S268326AbUJMEKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 00:10:16 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Getting a process' EIP address (and other registers)
Date: Tue, 12 Oct 2004 21:10:13 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C204FB456A@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Getting a process' EIP address (and other registers)
Thread-Index: AcSw2onYQ+ojQX3hRg6cgMaHFZrqfg==
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 13 Oct 2004 04:10:14.0808 (UTC) FILETIME=[8A9C6180:01C4B0DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I have written a 2.4 kernel module that is triggered upon an
IOCTL from a user application. Once triggered the kernel module dumps
out the contents of the system memory and the x86 CPU architecture state
to separate files.
	I'm writing to the list because my method for getting registers
from the user process before it entered the kernel is producing
incorrect results. I've looked all through the kernel code and searched
all over the web for an answer to this specific question and found
nothing relevant.
	In my research how to do this I've found that the stack pointer
for the user process before it entered the kernel is stored in
current->thread.esp0. From there the registers for the user process are
stored at offsets from that location (for example, EIP is supposed to be
0x28 unsigned char bytes from esp0). I have code to get the EIP as
follows:

unsigned char *stack_address, *eip;

stack_address = (unsigned char *)(current->thread.esp0);
eip = stack_address + 0x28;
printk("eip = %08lx\n", *(unsigned long *)eip);

Like I mentioned this is producing incorrect results. How do I access
the user process' general purpose registers contents as they were before
the kernel was entered (or correct my code above if I'm accessing
something wrong)?
	Thanks in advance for any help offered.
