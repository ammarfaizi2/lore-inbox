Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbTFOXR5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 19:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTFOXR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 19:17:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52962 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263023AbTFOXRz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 19:17:55 -0400
Date: Mon, 16 Jun 2003 00:31:46 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "David S. Miller" <davem@redhat.com>
Cc: clem@clem.clem-digital.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.71 -- Lost second 3c509 card
Message-ID: <20030615233146.GM6754@parcelfarce.linux.theplanet.co.uk>
References: <1055693991.7678.0.camel@rth.ninka.net> <200306151650.MAA05807@clem.clem-digital.net> <20030615.095201.102567075.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030615.095201.102567075.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 15, 2003 at 09:52:01AM -0700, David S. Miller wrote:
>    From: Pete Clements <clem@clem.clem-digital.net>
>    Date: Sun, 15 Jun 2003 12:50:25 -0400 (EDT)
> 
>    >From boot log:
>    
>    Kernel command line: auto BOOT_IMAGE=Linux ro root=341 ether=9,0x310,4,0x3c509,eth1
> 
> Yes, that explains why the second card isn't found.
> 
> The problem is:
> 
> 1) the we can't assign a name to the device
>    until we've registered it with the networking
> 
> 2) without a name the boot argument lookup doesn't work
> 
> 3) we have to register the device with the networking only
>    after it is initialized
> 
> Hmmm...

Crap.  AFAICS, the clean solution would be to pass these guys (blah_probe())
expected device name.  And let them do allocation, etc., themselves.

Looking into it...
