Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWGCTCN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWGCTCN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWGCTCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:02:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49541 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750862AbWGCTCM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:02:12 -0400
Date: Mon, 3 Jul 2006 12:01:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: vsu@altlinux.ru, reuben-lkml@reub.net, linux-kernel@vger.kernel.org,
       greg@kroah.com, brice@myri.com
Subject: Re: 2.6.17-mm6
Message-Id: <20060703120148.c5990ed0.akpm@osdl.org>
In-Reply-To: <44A95319.1010705@goop.org>
References: <20060703030355.420c7155.akpm@osdl.org>
	<44A8F8D2.1030101@reub.net>
	<20060703162958.d980ee6e.vsu@altlinux.ru>
	<44A95319.1010705@goop.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 10:25:45 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Sergey Vlasov wrote:
> > These names are truncated - they should end with two hex digits:
> >
> > 	snprintf(device->bus_id, sizeof(device->bus_id), "%s:pcie%02x",
> > 		 pci_name(parent), get_descriptor_id(port_type, service_type));
> >
> > Names were truncated at 18 characters, but sizeof(device->bus_id) is 20
> > currently, so these names should just fit there.  I see that snprintf()
> > was changed recently - maybe there is some off-by-one bug there?
> >   

Darnit, I was staring at the wrong code so much that I never even noticed that.

> There was for a while, but it should be OK in -mm6.  Perhaps there's a 
> stray patch hanging around in this kernel?
> 

No, it's still wrong.

	end = buf + size - 1;
	...
	end[-1] = '\0';


