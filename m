Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUJNKwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUJNKwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 06:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUJNKwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 06:52:24 -0400
Received: from aun.it.uu.se ([130.238.12.36]:15507 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266650AbUJNKwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 06:52:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16750.23132.41441.649851@alkaid.it.uu.se>
Date: Thu, 14 Oct 2004 12:52:12 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "mobil@wodkahexe.de" <mobil@wodkahexe.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 No local APIC present or hardware disabled
In-Reply-To: <Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
References: <20041012195448.2eaabcea.mobil@wodkahexe.de>
	<Pine.LNX.4.58L.0410132311190.17462@blysk.ds.pg.gda.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej W. Rozycki writes:
 > On Tue, 12 Oct 2004, mobil@wodkahexe.de wrote:
 > 
 > > after upgrading to 2.6.9-rc4 I'm getting the following message in dmesg:
 > > 
 > > No local APIC present or hardware disabled
 > > 
 > > 2.6.9-rc3 and older kernels did not show this message. They showed:
 > >  Local APIC disabled by BIOS -- reenabling.
 > >  Found and enabled local APIC!
 > 
 >  As you've already been told, the local APIC is not being enabled by
 > default anymore.  I think this change may be unfortunate for users, so
 > I've proposed the change to be applied for systems using ACPI and then
 > verbosely, so that the reason for the APIC being kept disabled is clear.  

There are systems, such as the P3-based Dell Inspirons and Latitutes
that caused the dmi blacklist to be implemented, that fail whether
they're using APM or ACPI. So in the interest of consistency, we should
either always automatically override the BIOS, requiring "nolapic" on
broken systems, or never automatically override the BIOS, requiring
"lapic" on systems that work but have stupid BIOSen.

None of this is ACPI-specific, so I don't like the idea of tying
auto-enable/disable to ACPI.

/Mikael
