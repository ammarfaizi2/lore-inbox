Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264131AbUFPW1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264131AbUFPW1k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUFPW1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:27:40 -0400
Received: from [208.245.16.50] ([208.245.16.50]:7992 "EHLO
	central.parcplace.com") by vger.kernel.org with ESMTP
	id S264131AbUFPW1i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:27:38 -0400
Message-Id: <200406162227.PAA01216@central.parcplace.com>
From: eliot@cincom.com
Date: Wed, 16 Jun 2004 15:26:55 -0700
Subject: Re: PROBLEM: 2.6 kernels on x86 do not preserve FPU flags across context switches
To: ak@muc.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, eliot@cincom.com
X-STAMP-Fonts-Run: 2707 1 
MIME-Version: 1.0 (STAMPed mail)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,


| Funny, Linux just added fnclex to a critical path on popular request.
| But I guess it will need to be removed again, we already discussed
| that. 

Yes, this is a right royal pain.  We have problems around fnclex.  Because people can call arbitrary code from within Smalltalk we have to do an fnclex prior to an fp operation if we're to trap NaN/Inf results.  But doing so prior to each fp oiperation is becomming increasingly slower on more "modern" x86 implementations.  So we've now moved the fnclex to the return from an external language call as this tends to have lower dynamic frequency.  So from where I sit (a mushroom-like position) the issue feels like a design flaw in the x87 fpu...

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

OK, I'm working on it.  I have to get one of our customers to run the test because I don't have a 2.6 kernel handy.  As Im in release crunch mode right now there may be a couple of weeks delay.  But I should have a test program to you soon.

| On what CPUs does the failure occur? Linux uses different paths
| depending on if the CPU supports SSE or not.

This answer should be more prompt.  Say tomorrow.

| Does your program receive signals? Could it be related to them?

Could be. Yes we do have to handle signals.  But I'm pretty confident the issue is with the FPU flags because as far as fp goes the only significant change between the version that shows the problem and that that doesn't is the use of the FPU flags (via fxam, fstsw).  The version that uses fxam & fstsw doesn;t show the problem on kernels prior to 2.6.  In any case if I'm right the test proram should show it pretty clearly.

As I say, give me a couple of weeks or so.

Cheers,
---
Eliot Miranda                 ,,,^..^,,,                mailto:eliot@cincom.com
VisualWorks Engineering, Cincom  Smalltalk: scene not herd  Tel +1 408 216 4581
3350 Scott Blvd, Bldg 36 Suite B, Santa Clara, CA 95054 USA Fax +1 408 216 4500


