Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbTFWLVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 07:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWLVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 07:21:42 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:208
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266002AbTFWLVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 07:21:41 -0400
Subject: Re: Problems with PCMCIA Compact Flash adapter in 2.5.72
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Eivind Tagseth <eivindt@multinet.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030623102941.D23411@flint.arm.linux.org.uk>
References: <20030620081846.GB2451@tagseth-trd.consultit.no>
	 <20030620211640.B913@flint.arm.linux.org.uk>
	 <20030622114642.GB1785@tagseth-trd.consultit.no>
	 <20030622141541.B16537@flint.arm.linux.org.uk>
	 <20030622182838.GA6970@tagseth-trd.consultit.no>
	 <20030622191626.GA1811@tagseth-trd.consultit.no>
	 <20030623102941.D23411@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056368006.13529.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 12:33:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-23 at 10:29, Russell King wrote:
> On Sun, Jun 22, 2003 at 09:16:27PM +0200, Eivind Tagseth wrote:
> > However, removing the card causes a kernel panic, and everything completely
> > freezes.  This also happened with 2.5.69, so it's not caused by a recent
> > change.
> 
> ide-cs currently calls ide_unregister from interrupt context, which is
> a big nono.  Can you try the following patch please (which is completely
> untested)?
> 

This is better but still wrong in a way - ide_unregister can fail and
ide-cs in both 2.4 and 2.5 doesnt recover from that, or know about the
new "unplugged" ops it should force

