Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263300AbVCKDBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263300AbVCKDBZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 22:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbVCKCzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 21:55:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60879 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263337AbVCKCt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 21:49:58 -0500
Date: Thu, 10 Mar 2005 21:49:53 -0500
From: Dave Jones <davej@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: AGP bogosities
Message-ID: <20050311024953.GE20697@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <20050311021248.GA20697@redhat.com> <16944.65532.632559.277927@cargo.ozlabs.ibm.com> <20050311022332.GB20697@redhat.com> <1110508824.32556.320.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110508824.32556.320.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 01:40:24PM +1100, Benjamin Herrenschmidt wrote:
 > 
 > > After it does that pci_dev_put on the from, it does another pci_dev_get
 > > on 'dev', which is what my put was releasing.
 > > 
 > > Or am I terribly confused ?
 > 
 > Well, pci_get_class() put's the passed-in device and get's() the
 > returned one. So if you run it in a loop, you should never have to
 > either get or put. When you exit the loop with a valid pci_dev, though,
 > you should definitely put() it after you're done with it, but this is
 > something that should be done only for that specific instance and after
 > you are finished with it...

Yeah. Makes perfect sense now I've had it spelled out for me :-)
I think Linus is right though that some extra bullet-proofing in kref_put
to BUG() if it goes negative would've caught this.  I wonder if anyone
else has fallen into this trap.

		Dave
