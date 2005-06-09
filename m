Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVFILTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVFILTn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 07:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbVFILTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 07:19:43 -0400
Received: from cavan.codon.org.uk ([213.162.118.85]:43740 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S262351AbVFILTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 07:19:41 -0400
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
In-Reply-To: <1118145393.6648.232.camel@tyrosine>
References: <1118145393.6648.232.camel@tyrosine>
Date: Thu, 09 Jun 2005 12:19:27 +0100
Message-Id: <1118315967.6648.320.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: yenta_socket: no PCI interrupts after resume if intel-agp
	loaded on HP 1105
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> If I have all of these drivers loaded at suspend, resume fails. Without
> intel-agp, I can suspend and resume happily (well, X won't start after
> resume, but that's potentially an entirely separate issue)

I've tracked this down some further. If I comment out these lines in
intel_845_configure:

        /* agpm */
        pci_read_config_byte(agp_bridge->dev, INTEL_I845_AGPM, &temp2);
        pci_write_config_byte(agp_bridge->dev, INTEL_I845_AGPM, temp2 |
(1 << 1));

then I can load intel-agp, suspend and resume and still get correct
interrupts. If I leave then uncommented, then attempting to load
yenta-socket after a suspend/resume with intel-agp loaded results in the
"no PCI interrupts. Fish" error. This is an i855PM device using nvidia
graphics. 

-- 
Matthew Garrett | mjg59@srcf.ucam.org

