Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVHWGPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVHWGPQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 02:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVHWGPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 02:15:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16526 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1750764AbVHWGPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 02:15:14 -0400
Date: Tue, 23 Aug 2005 07:18:16 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Janak Desai <janak@us.ibm.com>, sds@tycho.nsa.gov, linuxram@us.ibm.com,
       ericvh@gmail.com, dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org,
       torvalds@osdl.org, gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New system call, unshare
Message-ID: <20050823061815.GE9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.WNT.4.63.0508080923470.3668@IBM-AIP3070F3AM> <878xz9dgv4.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878xz9dgv4.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 04:08:31PM +0200, Florian Weimer wrote:
> * Janak Desai:
> 
> > With unshare, namespace setup can be done using PAM session
> > management functions without patching individual commands.
> 
> I don't think it's a good idea to use security-critical code well
> without its original specification.  Clearly the current situation
> sucks, but this is mainly a lack of PAM functionality, IMHO.

Eh?  We are talking about a primitive that has far more uses than
PAM.  This is a missing piece of the stuff done by clone() and fork():
each task is a virtual machine with sharable components.  We can
get a copy of machine  with arbitrary set of components replaced with
private copies.  That's what clone() and fork() do.  The thing missing
from that set is taking a component (VM, descriptors, etc.) of process
itself and making it private.  The same thing we do on fork(), but
without creating a new process.

FWIW, I'm OK with that.  IIRC, Linus ACKed the concept some time ago.
PAM is one obvious use, but there's are other situations where the lack
of that primitive is inconvenient...
