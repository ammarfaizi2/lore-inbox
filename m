Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161293AbWKEPSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161293AbWKEPSf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 10:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWKEPSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 10:18:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20650 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161293AbWKEPSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 10:18:34 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061105064801.GV13381@stusta.de>
Date: Sun, 05 Nov 2006 08:17:53 -0700
In-Reply-To: <20061105064801.GV13381@stusta.de> (Adrian Bunk's message of
	"Sun, 5 Nov 2006 07:48:01 +0100")
Message-ID: <m1lkmpq5we.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> This email lists some known regressions in 2.6.19-rc4 compared to 2.6.18
> that are not yet fixed in Linus' tree.
>
> If you find your name in the Cc header, you are either submitter of one
> of the bugs, maintainer of an affectected subsystem or driver, a patch
> of you caused a breakage or I'm considering you in any other way possibly
> involved with one or more of these issues.
>
> Due to the huge amount of recipients, please trim the Cc when answering.
>
>
> Subject    : ipath driver MCEs system on load when HT chip present
> References : http://bugzilla.kernel.org/show_bug.cgi?id=7455
> Submitter  : Bryan O'Sullivan <bos@serpentine.com>
> Caused-By  : Eric W. Biederman <ebiederm@xmission.com>
> Status     : unknown

Status in problem is being debugged. I have posted some infrastructure
patches that should allow Bryan to fix his driver cleanly.  

I did not cause this. The ipath HTX card driver's irq handling has
never been anything but a hack.  It has never worked correctly even in
the instances it worked.  It only worked on i386 or x86_64 when
CONFIG_PCI_MSI was enabled but did not use MSI.  It was relying on the
implementation detail that the architecture specific vector number was
placed in the dev->irq.  dev->irq is actually meaningless on this card
as it doesn't have any ordinary pci interrupts.

So while I am happy to take credit for flushing this bug out I did not
introduce it.

Eric
