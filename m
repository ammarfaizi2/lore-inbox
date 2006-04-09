Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDIL2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDIL2v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 07:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbWDIL2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 07:28:51 -0400
Received: from mail.charite.de ([160.45.207.131]:6027 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1750726AbWDIL2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 07:28:50 -0400
Date: Sun, 9 Apr 2006 13:28:48 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: Linux 2.6.17-rc1
Message-ID: <20060409112847.GA30909@charite.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Jacob Shin <jacob.shin@amd.com>,
	Dave Jones <davej@codemonkey.org.uk>
References: <20060404080205.C8B29E007A12@knarzkiste.dyndns.org> <20060403180207.E849EE007A12@knarzkiste.dyndns.org> <Pine.LNX.4.64.0604022037380.3781@g5.osdl.org> <20060403190915.GA10584@charite.de> <20060403202539.65cf6e33.akpm@osdl.org> <20060404080529.GM7849@charite.de> <20060404014421.635b2c51.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060404014421.635b2c51.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org>:

> OK, thanks.  That indicates that we did install a
> acpi_processor_performance structure, but something must have later on
> zeroed it.
> 
> Hopefully the cpufreq guys will be able to reproduce this.
> 
> <tries it>
> 
> Actually, I cannot even rmmod the thing:
> 
> Module                  Size  Used by
> p4_clockmod             6980  1 
> speedstep_lib           5376  1 p4_clockmod
> 
> It looks like either it has a refcounting problem or it has been changed so
> that it is deliberately pinned.

I tried 2.6.17-rc1-mm2 today and got better (?) output when modprobing
the module:

powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.60.2)
ACPI Warning (acpi_utils-0065): Invalid package argument [20060310]
ACPI Exception (acpi_processor-0275): AE_BAD_PARAMETER, Invalid _PSS data [20060310]
powernow-k8:    0 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x4 (1450 mV)
cpu_init done, current fid 0x8, vid 0x4

-- 
_________________________________________________

  Charité - Universitätsmedizin Berlin
_________________________________________________

  Ralf Hildebrandt
   i.A. Geschäftsbereich Informationsmanagement
   Campus Benjamin Franklin
   Hindenburgdamm 30 | Berlin
   Tel. +49 30 450 570155 | Fax +49 30 450 570962
   Ralf.Hildebrandt@charite.de
   http://www.charite.de
