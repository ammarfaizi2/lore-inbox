Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTI2GyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 02:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262782AbTI2GyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 02:54:05 -0400
Received: from smtp2.BelWue.DE ([129.143.2.15]:18928 "EHLO smtp2.BelWue.DE")
	by vger.kernel.org with ESMTP id S261812AbTI2GyC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 02:54:02 -0400
Date: Mon, 29 Sep 2003 08:53:59 +0200 (CEST)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org
Subject: Why Sysrq+k does not offer a trusted path
Message-ID: <Pine.LNX.4.44.0309290836460.16991-100000@picard.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

the Sysrq documentation states that the sequence Sysrq + k is not supposed
to constitute a SAK as specified for a C2 system.

Although I do not quite know what excatly in the author's view is missing
for Sysrq + k to really offer a C2 compliant trusted path for logging in,
at least I know of one thing which in a trivial way constitutes a security
leak:

As "/proc/sys/kernel/sysrq" is writable for any privileged process,
writing a "0" into it leads to switching off sys requests altogether. A
malicious program can then do just that and otherwise simulate the
functionality of sys requests its own way. Forging a secure login path is
then a trivial task.

My question is: why not eliminate "/proc/sys/kernel/sysrq" altogether, and
decide at boot time if sysrq functionality is wished or not?

Setting the variable sysrq_enabled at a very early stage of the kernel
setup based on a command line parameter "sysrq" would be a very convenient
way to decide if sys requests are to be enabled, and moreover this
procedure cannot be overridden once the kernel has booted.

Thus it is a more secure way to offer a real SAK.

Or am I missing a very important point?

Best regards

Oliver Tennert

--
________________________________________creating IT solutions

Dr. Oliver Tennert			science + computing ag
phone   +49(0)7071 9457-598		Hagellocher Weg 71-75
fax     +49(0)7071 9457-411		D-72070 Tuebingen, Germany
O.Tennert@science-computing.de		www.science-computing.de



