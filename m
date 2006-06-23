Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWFWPMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWFWPMw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWFWPMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:12:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8425 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751452AbWFWPMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:12:51 -0400
Subject: Re: Fault tolerance/bad patch, [was Re: [PATCH 29/30] [PATCH] PCI
	Hotplug: fake NULL pointer dereferences in IBM Hot Plug Controller Driver]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Eric Sesterhenn <snakebyte@gmx.de>, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060623150442.GK8866@austin.ibm.com>
References: <1150753481625-git-send-email-greg@kroah.com>
	 <115075348565-git-send-email-greg@kroah.com>
	 <11507534883521-git-send-email-greg@kroah.com>
	 <11507534914002-git-send-email-greg@kroah.com>
	 <11507534953044-git-send-email-greg@kroah.com>
	 <11507534983982-git-send-email-greg@kroah.com>
	 <11507535021937-git-send-email-greg@kroah.com>
	 <11507535054091-git-send-email-greg@kroah.com>
	 <11507535082418-git-send-email-greg@kroah.com>
	 <11507535123764-git-send-email-greg@kroah.com>
	 <20060623150442.GK8866@austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jun 2006 16:28:24 +0100
Message-Id: <1151076504.4549.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-23 am 10:04 -0500, ysgrifennodd Linas Vepstas:
> If someone in the future changes the hotplug core so that it 
> sometimes returns a null value, this code will potentially crash
> and/or do other bad things (corrupt, invalid state, etc.)
> This means that this routine will no longer be "robust" in the face of
> changes in other parts of the kernel. 

"Potentially".

But if you replaced it with

BUG_ON(value == NULL);

you'd both clean up the if and improve the reliability even more

> I can hear the objections:
> -- Performance. B.S. This routine is not performance critical, it will
>    get called once a week, once a month or less often; a few extra
>    cycles are utterly irrelevant.

(and half the time gcc eliminates the test itself)


