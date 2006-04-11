Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWDKQ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWDKQ33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 12:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750856AbWDKQ33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 12:29:29 -0400
Received: from service.sh.cvut.cz ([147.32.127.214]:6605 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S1750796AbWDKQ32
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 12:29:28 -0400
Message-ID: <443BD961.3050807@sh.cvut.cz>
Date: Tue, 11 Apr 2006 18:29:21 +0200
From: Rudolf Marek <r.marek@sh.cvut.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: Jean Delvare <khali@linux-fr.org>, info-linux@ldcmail.amd.com,
       BGardner@Wabtec.com, linux-kernel@vger.kernel.org,
       lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] scx200_acb: Use PCI I/O resource when appropriate
References: <20060331230309.GE17261@cosmic.amd.com>	<LYRIS-4270-45297-2006.04.11-06.08.18--jordan.crouse#amd.com@whitestar.amd.com> <20060411161942.GB13334@cosmic.amd.com>
In-Reply-To: <20060411161942.GB13334@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

> And so our dirty laundry is out... :)
> 
> We have a sad history here - back a few parts, we had less descriptors to 
> describe IO, so we opted to combine several components under the same PCI
> header to save resources.  So the bottom line is that we have at least three
> desirable devices (timers, GPIO pins and the SMBus) that all lay claim to
> the same device.  So a proper PCI header would be difficult to implement - 
> either we would have 1 device that registered with three different
> subsystems, or we would have three individual devices, the first of which
> would get the PCI resources to the ruin of the others.

Well we had the problem with i2c-viapro and vi686a. Best solution was
to fail from the probe function - like this:

         /* Always return failure here.  This is to allow other drivers to bind
          * to this pci device.  We don't really want to have control over the
          * pci device, we only wanted to read as few register values from it.
          */
         return -ENODEV;

release_region:
         release_region(vt596_smba, 8);
         return error;
}

> 
> So this is the solution I came up with, for older parts.  For newer parts,
> I sat the BIOS guys down in a room with a guy name Bruno, and they agreed
> to make a separate header for each component.

This is good ;)

Regards
Rudolf
