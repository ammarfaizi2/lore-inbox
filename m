Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264801AbTGBGyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264786AbTGBGyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:54:04 -0400
Received: from d12lmsgate.de.ibm.com ([194.196.100.234]:11237 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S264801AbTGBGyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:54:02 -0400
Subject: crypto API and IBM z990 hardware support
To: jmorris@intercode.com.au
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
Message-ID: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com>
From: "Thomas Spatzier" <TSPAT@de.ibm.com>
Date: Wed, 2 Jul 2003 09:07:59 +0200
X-MIMETrack: Serialize by Router on D12ML041/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 02/07/2003 09:08:06
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James,

I'm currently looking at the crypto API and considering adding support for
new hardware instructions implemented in the IBM z990 architecture. Since I
found your name in most of the files I find it appropriate to ask for your
opinion on how to integrate the new code (from a design point of view).
z990 provides hardware support for AES, DES and SHA. The problem is, that
the respective instructions might not be implemented on all z990 systems
(export restrictions etc). Hence, a check must be run to test whether the
instruction set is present, and if not, a fall-back to the current software
implementation must be taken. I basically have two solutions in mind: (1)
to integrate the new code into the current crypto files; add some #ifdef s
to prevent the code from being compiled when building a non-z990 kernel;
add some ifs for runtime check. (2) include the new code into an
arch/s390/crypto directory.
The advantage of (1) is that there are no seperate crypto directories, the
code doesn't drift apart. Furthermore, it's probably the best solution with
respect to the kernel module loader. On the other hand, the hardware
support is very arch-specific, which would fit in option (2). (2) however
has the disadvantage that there are multiple crypto modules; the user has
to select one to load -> must have different names for one algorithm.
What is your opinion on this subject?

Regards,
Thomas Spatzier
--------------------------------------------------
+49-7031-16-1219
TSPAT@de.ibm.com

