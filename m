Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUJYGL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUJYGL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbUJYGL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:11:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:34951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261507AbUJYGL5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:11:57 -0400
Message-ID: <417C991C.2070806@pobox.com>
Date: Mon, 25 Oct 2004 02:11:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: Concerns about our pci_{save,restore}_state()
References: <1098677182.26697.21.camel@gaston>
In-Reply-To: <1098677182.26697.21.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>  - What about saving/restoring more registers ? I'm not sure wether it
> should be the responsibility of the driver to save and restore things
> above dword 15, but we should at least deal with the case of P2P bridges
> who have more "standard" registers


This is a key concern of mine.

The _driver_ is the only entity that knows really how much space to 
save/restore, and the generic versions are obviously _not_ sufficient to 
support:

* hardware errata such as S3 Trio, where _reading_ or writing certain 
registers in the standard range cause a system lockup

* saving/restoring the standard-defined capability lists, which 
certainly could extend way beyond what's stored now

* saving/restoring the new PCI-Express 4K config area

This is _clearly_ something that should be decided upon in the driver. 
The PCI layer should _only_ present standard helper functions, and maybe 
a standard storage space that works for most drivers; not force all 
drivers through a narrow funnel.

	Jeff


