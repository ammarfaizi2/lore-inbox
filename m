Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266274AbTBCVE6>; Mon, 3 Feb 2003 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266296AbTBCVE6>; Mon, 3 Feb 2003 16:04:58 -0500
Received: from fmr04.intel.com ([143.183.121.6]:38342 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S266274AbTBCVE5>; Mon, 3 Feb 2003 16:04:57 -0500
Message-ID: <F760B14C9561B941B89469F59BA3A84725A14A@orsmsx401.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: Dave Jones <davej@codemonkey.org.uk>, Valdis.Kletnieks@vt.edu
Cc: John Bradford <john@grabjohn.com>, Seamus <assembly@gofree.indigo.ie>,
       linux-kernel@vger.kernel.org
Subject: RE: CPU throttling??
Date: Mon, 3 Feb 2003 13:14:18 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@codemonkey.org.uk] 
> Valdis.Kletnieks@vt.edu wrote:
> 
>  > It's conceivable that a CPU halted at 1.2Gz takes less 
> power than one
>  > at 1.6Gz - anybody have any actual data on this?  
> Alternately phrased,
>  > does CPU throttling save power over and above what the halt does?
> 
> Given that most decent implementations scale voltage as well as
> frequency, yes, a lower speed will save more power.

You save the most power when the CPU is at the lowest voltage level, and
in the deepest CPU sleep state (aka CPU C state).

Throttling offers a linear power/perf tradeoff if your system doesn't
have C state support (or if you aren't using it) but really it is
preferable to keep the CPU at its nominal speed, get the work done
sooner, and start sleeping right away. The quote above makes it sound
like the voltage is scaled when throttling, and that isn't accurate -
voltage is scaled when sleeping (to counteract leakage current), at
least on modern Intel mobile processors.

Valdis, you may want to try compiling in ACPI and ACPI Processor support
in 2.5.latest and see what happens to your battery life (if you haven't
tried already). (A caveat - ACPI still doesn't work for everyone, but if
it does, you should see a power savings.)

Regards -- Andy
