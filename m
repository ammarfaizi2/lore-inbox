Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270332AbTHLNtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270338AbTHLNtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:49:09 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:12784 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S270332AbTHLNtH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:49:07 -0400
Date: Tue, 12 Aug 2003 15:48:48 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Dave Jones <davej@codemonkey.org.uk>, torvalds@transmeta.com,
       fxkuehl@gmx.de, linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: [PATCH][2.6.0-test3] Disable APIC on reboot.
In-Reply-To: <16184.10167.743824.668791@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.3.96.1030812154705.7029B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003, Mikael Pettersson wrote:

> @@ -249,6 +250,14 @@
>  	 * other OSs see a clean IRQ state.
>  	 */
>  	smp_send_stop();
> +#elif CONFIG_X86_LOCAL_APIC
> +	if (cpu_has_apic) {
> +		local_irq_disable();
> +		disable_local_APIC();
> +		local_irq_enable();
> +	}
> +#endif
> +#ifdef CONFIG_X86_IO_APIC
>  	disable_IO_APIC();
>  #endif

 You obviously want to disable I/O APICs first.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

