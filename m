Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264748AbUFPXCR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264748AbUFPXCR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 19:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUFPXCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 19:02:17 -0400
Received: from [208.245.16.50] ([208.245.16.50]:62518 "EHLO
	central.parcplace.com") by vger.kernel.org with ESMTP
	id S264748AbUFPXCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 19:02:15 -0400
Message-Id: <200406162302.QAA01806@central.parcplace.com>
From: eliot@cincom.com
Date: Wed, 16 Jun 2004 16:01:46 -0700
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org, tgriggs@key.net
X-STAMP-Fonts-Run: 500 1 6 2 32 1 2 1 6 2 23 1 2 1 9 2 82 1 1982 1 
MIME-Version: 1.0 (STAMPed mail)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

	you asked:
| On what CPUs does the failure occur? Linux uses different paths
| depending on if the CPU supports SSE or not.

Travis responded:

| We run on both AMDs (Durons and Athlons) as well as PII, PIII, and 
| PIV's. Our kernels are all compiled as generic 586+. Though when we were 
| testing for this, we did try the more generic 486+ option, as well as 
| exact processor matches for the AMD at least. I don't remember it making 
| a difference.

+-----------------------------
| Date:	Wed, 16 Jun 2004 23:40:18 +0200
| From:	Andi Kleen <ak@muc.de>
| Subject:	Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches



| eliot@cincom.com writes:

| > 	I am the team lead and chief VM developer for a Smaltalk
| > 	implementation based on a JIT execution engine.  Our customers
| > 	have been seeing rare incorrect floating-point results in
| > 	intensive fp applications on 2.6 kernels using various x86
| > 	compatible processors.  These problems do not occur on
| > 	previous kernel versons.  We recently had occasion to
| > 	reimplement our fp primitives to avoid severe performance
| > 	problems on Xeon processors that were traced to Xeon's
| > 	relatively slow implementation of fnclex and fstsw.  The older

| Funny, Linux just added fnclex to a critical path on popular request.
| But I guess it will need to be removed again, we already discussed
| that. 


| > I don't know whether any action on your part is appropriate.  The
| > use of the FPU status flags is presumably rare on linux (I believe
| > that neither gcc nor glibc make use of them).  But "exotic"
| > execution machinery such as runtimes for dynamic or functional
| > languages (language implementations that may not use IEEE arithmetic
| > and instead flag Infs and NaNs as an error) may fall foul of this
| > issue.  Since previous versions of the kernel on x86 apparently do
| > preserve the FPU status flags perhaps its simple to preserve the old
| > behaviour.  At the very least let me suggest you document the
| > limitation.

| This sounds like a serious kernel bug that should be fixed if
| true. Can you perhaps create a simple demo program that shows the
| problem and post it?

| On what CPUs does the failure occur? Linux uses different paths
| depending on if the CPU supports SSE or not.

| Does your program receive signals? Could it be related to them?

| -Andi
---
Eliot Miranda                 ,,,^..^,,,                mailto:eliot@cincom.com
VisualWorks Engineering, Cincom  Smalltalk: scene not herd  Tel +1 408 216 4581
3350 Scott Blvd, Bldg 36 Suite B, Santa Clara, CA 95054 USA Fax +1 408 216 4500


