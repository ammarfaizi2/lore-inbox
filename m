Return-Path: <linux-kernel-owner+w=401wt.eu-S965040AbWLTMxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWLTMxe (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWLTMxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:53:34 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:41848 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965024AbWLTMxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:53:33 -0500
Date: Wed, 20 Dec 2006 12:53:14 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20061220125314.GA24188@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191959.43019.david-b@pacbell.net> <20061220042648.GA19814@srcf.ucam.org> <200612192114.49920.david-b@pacbell.net> <20061220053417.GA29877@suse.de> <20061220055209.GA20483@srcf.ucam.org> <1166601025.3365.1345.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166601025.3365.1345.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 08:50:24AM +0100, Arjan van de Ven wrote:

(Adding netdev - context is the altering of the runtime power 
management interface, with the effect that it's no longer possible for 
userspace to request that drivers suspend a device, so Arjan has 
suggested that we do it via other existing interfaces)

> > Seriously. How many pieces of userspace-visible functionality have 
> > recently been removed without there being any sort of alternative?
> 
> There IS an alternative, you're using it for networking:
>  
> You *down the interface*.
> 
> If there's a NIC that doesn't support that let us (or preferably netdev)
> know and it'll get fixed quickly I'm sure.

As far as I can tell, the following network devices don't put the 
hardware into D3 on interface down:

3c59x
8139too
acenic
amd8111e
b44
cassini
defxx
dl2k
e100
e1000
epic100
fealnx
forcedeth
hamachi
hp100
ioc3-eth
natsemi
ne2k-pci
ns83820
pcnet32
qla3xxx
rtl8169
rrunner
s2io
saa9730
sis190
sis900
skge
sky2
spider_net
starfire
sundance
sungem
sunhme
tc35815
tlan
via-rhine
yellowfin

while these ones do:

bnx2
tg3
typhoon
via-velocity

tulip is somewhere in between - it puts the chip in a lower power state, 
but not D3. It's possible that some of the other drivers do something 
similar, but nothing leapt out at me.

The situation is more complicated for wireless. Userspace expects to be 
able to get scan results from the card even if the interface is down. In 
that case, I'm pretty sure we need a third state rather than just "up" 
or "down".
-- 
Matthew Garrett | mjg59@srcf.ucam.org
