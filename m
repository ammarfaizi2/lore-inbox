Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272050AbTG2UMH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272051AbTG2UMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:12:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:18124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272050AbTG2UMC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:12:02 -0400
Date: Tue, 29 Jul 2003 12:59:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: sa@xmission.com, pavel@xal.co.uk, linux-kernel@vger.kernel.org,
       adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-Id: <20030729125944.74af01dc.akpm@osdl.org>
In-Reply-To: <1059479872.2921.7.camel@dhcp22.swansea.linux.org.uk>
References: <20030728171806.GA1860@xal.co.uk>
	<20030728201954.A16103@xmission.xmission.com>
	<20030728202600.18338fa9.akpm@osdl.org>
	<20030728231812.A20738@xmission.xmission.com>
	<20030728225914.4f299586.akpm@osdl.org>
	<20030729012417.A18449@xmission.xmission.com>
	<20030729005456.495c89c4.akpm@osdl.org>
	<1059479872.2921.7.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Maw, 2003-07-29 at 08:54, Andrew Morton wrote:
> > wtf?  So the memory at d094ee7c (which contains i810fb's pci table) became
> > unmapped from kernel virtual address space as a result of you inserting
> > your carbus card.
> > 
> > I am impressed.
> 
> This makes complete sense actually - its marked __initdata. Remove the
> __initdata and try again or mark it __devinitdata ?

hmm, that's a bug if the driver is statically linked, but afaik we're not
dropping the __init sections from modules yet.  Or did that change?

Still.  A grep finds forty-odd instances of "pci_device_id.*__initdata".  I
think I'll go convert them all to __devinitdata.

