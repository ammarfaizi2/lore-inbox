Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbVHWGEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbVHWGEo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 02:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVHWGEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 02:04:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6539 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751155AbVHWGEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 02:04:44 -0400
Date: Tue, 23 Aug 2005 07:07:40 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Janak Desai <janak@us.ibm.com>, sds@tycho.nsa.gov, linuxram@us.ibm.com,
       ericvh@gmail.com, dwalsh@redhat.com, jmorris@redhat.com, akpm@osdl.org,
       torvalds@osdl.org, gh@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] New system call, unshare
Message-ID: <20050823060740.GD9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.WNT.4.63.0508080928480.3668@IBM-AIP3070F3AM> <1123512366.31229.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123512366.31229.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2005 at 03:46:06PM +0100, Alan Cox wrote:
> On Llu, 2005-08-08 at 09:33 -0400, Janak Desai wrote:
> > 
> > [PATCH 1/2] unshare system call: System Call handler function sys_unshare
> 
> 
> Given the complexity of the kernel code involved and the obscurity of
> the functionality why not just do another clone() in userspace to
> unshare the things you want to unshare and then _exit the parent ?

Because you want to keep children?  Because you don't want to deal with
the implications for sessions/groups/etc.?

FWIW, syscall makes sense.  It is a valid primitive and the only reason
to keep it out of clone() (i.e. not making it just another flag to clone())
is that clone() is already cluttered _and_ uses bad calling conventions
for that stuff ("I want to retain <list>" rather than "I want private <list>").
