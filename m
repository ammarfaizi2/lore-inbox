Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267990AbTAIWSw>; Thu, 9 Jan 2003 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTAIWSw>; Thu, 9 Jan 2003 17:18:52 -0500
Received: from AMarseille-201-1-1-176.abo.wanadoo.fr ([193.252.38.176]:46448
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267990AbTAIWSt>; Thu, 9 Jan 2003 17:18:49 -0500
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
In-Reply-To: <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>
References: <Pine.LNX.4.44.0301091413520.1436-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042151210.523.34.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Jan 2003 23:26:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-09 at 23:16, Linus Torvalds wrote:
> On Fri, 10 Jan 2003, Ivan Kokshaysky wrote:
> >
> > Note that in most cases PCI-PCI bridges can be safely excluded from
> > pci_read_bases() simply because they have neither regular BARs nor
> > ROM BAR (even though PCI spec allows that).
> 
> This might be a good approach to take regardless - don't read pci-pci 
> bridge BAR (or host-bridge BAR's for that matter), simply because 
> 
>  (a) bridges are more "interesting" than regular devices, and disabling 
>      part of them might be a stupid thing.
>  (b) we're generally not really interested in the end result anyway

I completely agree. For example, I have already a bunch of cases where I
have to explicitely "hide" the host bridge from linux PCI layer as those
have BARs that mustn't be touched. A typical example is the 405gp
internal PCI host. It has a BAR that represents the view of system RAM
from bus mastering PCI devices. Of course, the kernel doesn't understand
that and tries to remap it away from 0 where it belongs ;)

Ben.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
