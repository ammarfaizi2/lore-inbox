Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265993AbUF2TWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUF2TWO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUF2TWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:22:13 -0400
Received: from gherkin.frus.com ([192.158.254.49]:25239 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S265993AbUF2TV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:21:59 -0400
Subject: kbuild and -msoft-float
To: linux-kernel@vger.kernel.org
Date: Tue, 29 Jun 2004 14:21:56 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040629192156.EA875DBE8@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Probably off-topic for this list, but of presumed general interest for
developers working on modules maintained/built outside the kernel source
tree...

The Atmelwlandriver project on Sourceforge has recently modified the
package build process for 2.6 kernels to be compatible with kbuild.
Unfortunately, when the smoke of the build process clears, the pcmcia
driver modules all contain several undefined symbols traceable to the
use of "-msoft-float" during compilation.  The undefined symbols are
	__subdf3
	__divdf3
	__fixunsdfsi
	__floatsidf
	__gtdf2

I don't know if this is specific to 2.6.7, but the behavior is not
dependent on the version of gcc for versions capable of building 2.6
kernels on i386 hardware.  If the "-msoft-float" flag is omitted,
everything builds and works as expected.  The question is "why are
floating point instructions being emitted in the first place?"  The
driver code contains nothing obvious that might cause this behavior,
although I'm sure I'm missing *something*.

Explanations, workarounds, etc. gratefully accepted.  Thanks in advance.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
