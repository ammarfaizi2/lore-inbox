Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWD2Kdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWD2Kdg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 06:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWD2Kdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 06:33:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:39951 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751864AbWD2Kdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 06:33:35 -0400
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Simple header cleanups
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261917270.3701@g5.osdl.org>
	<1146105458.2885.37.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604261954480.3701@g5.osdl.org>
	<1146107871.2885.60.camel@hades.cambridge.redhat.com>
	<Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
	<20060427213754.GU3570@stusta.de>
	<Pine.LNX.4.64.0604271439100.3701@g5.osdl.org>
	<20060427231200.GW3570@stusta.de>
	<Pine.LNX.4.64.0604271656390.3701@g5.osdl.org>
	<Pine.LNX.4.61.0604281729250.9011@yvahk01.tjqt.qr>
	<1146238623.11909.524.camel@pmac.infradead.org>
	<BEF524DD-84E8-4579-ABFC-0AFB9EAC1982@mac.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 29 Apr 2006 12:33:32 +0200
In-Reply-To: <BEF524DD-84E8-4579-ABFC-0AFB9EAC1982@mac.com> (Kyle Moffett's message of "Fri, 28 Apr 2006 12:01:49 -0400")
Message-ID: <m3y7xosmbn.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> writes:

> This is
> _exactly_ the way things work now, except there is no outside llh
> project, it's all stored in the kernel tree.

Precisely. I also think we don't have to worry about namespace
contamination and non-compliance to random "standards". It is the
userland _using_ the kernel headers at its discretion, we don't force
anyone to include anything. If something includes, say, kabi/hdlc.h
(just to make sure I know the details) then it has to be prepared
for hdlc_device struct to be defined, even if System 5 3/4 R 1.2.3.4
says nothing about it.

If glibc (as opposed to kernel utils) wants to use the kabi headers
(and I presume it should) then it has to build its own files based
on ours and/or should do other necessary steps to prevent namespace
problems (such as carefully picking files to include instead of
#include <kabi/*>). It will be easier than now anyway and I think
we're all open for suggestions.

If it turns out that we need a separate kabi/*.h file for every kernel
API structure or a set of #defines then let it be.
-- 
Krzysztof Halasa
