Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUIOWod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUIOWod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267739AbUIOWnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:43:08 -0400
Received: from hqemgate00.nvidia.com ([216.228.112.144]:36363 "EHLO
	hqemgate00.nvidia.com") by vger.kernel.org with ESMTP
	id S267721AbUIOWmh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:42:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Date: Wed, 15 Sep 2004 15:42:19 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B03F96E2@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Thread-Index: AcSbc27pm3lSQbAiQQOmUQyxWTcFCAAATW7g
From: "Andrew Chew" <AChew@nvidia.com>
To: "Ingo Molnar" <mingo@elte.hu>, "Andrew Morton" <akpm@osdl.org>
Cc: "Zwane Mwaikambo" <zwane@fsmlabs.com>, <linux-kernel@vger.kernel.org>,
       <ak@suse.de>, <wli@holomorphy.com>
X-OriginalArrivalTime: 15 Sep 2004 22:42:22.0666 (UTC) FILETIME=[43F27AA0:01C49B75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If you enable profiling and frame pointers, profile_pc() goes splat 
> > dereferencing the `regs' argument when it decides that the 
> pc refers 
> > to a lock section.  Ingo said `regs' had a value of 0x2, iirc.  
> > Consider this a bug report ;)

I've been seeing this as well, although I'm pretty sure I have profiling
disabled.  Are you sure it isn't the combination of SMP support and
frame pointers that causes this bug to occur? (It looks like
profile_pc() takes on a different implementation only if both CONFIG_SMP
and CONFIG_FRAME_POINTER is defined.)
