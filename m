Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbTILDQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 23:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261653AbTILDQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 23:16:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:27782 "EHLO
	VL-MO-MR004.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S261646AbTILDQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 23:16:24 -0400
Date: Thu, 11 Sep 2003 23:16:19 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: Re: [PATCH][2.4.23-pre3] repair mpparse for default MP systems
In-reply-to: <16224.62817.533540.928220@gargle.gargle.HOWL>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: mathieu.desnoyers@polymtl.ca, linux-kernel@vger.kernel.org,
       macro@ds2.pg.gda.pl
Message-id: <20030912031619.GA1310@Krystal>
X-Info: http://krystal.dyndns.org
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.4i
X-Editor: vi
X-Operating-System: Linux/2.4.23-pre3 (i586)
X-Uptime: 23:05:22 up 5 min,  3 users,  load average: 1.21, 0.84, 0.37
References: <16224.62817.533540.928220@gargle.gargle.HOWL>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mikael Pettersson (mikpe@csd.uu.se) wrote:
> Mathieu,
> 
> This patch for 2.4.23-pre3 should fix the problems your dual
> P5 with default MP config has been having since 2.4.21-pre2.
> Please let us know if it works or not.
> 
> /Mikael
> 

Yes, I just tested this patch, and everything seems to work fine. Thank
you. :)

The only point I see, which is not triggered on my machine (because of
the absence of ACPI) is this one :

There is also an initialization of this mp_irqs variable in
mp_config_acpi_legacy_irqs from mpparse.c. It only seems to be called
from within acpi_boot_init in acpi.c. So I wonder if it's possible that
we do use default configuration and then also go into
mp_config_acpi_legacy_irqs during the acpi init, thus reserving the
memory twice and forgetting the old pointer, which could lead to an
erratic result.

If it's possible, then there is still a problem in there.

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
