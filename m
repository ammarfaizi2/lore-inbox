Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275973AbRJGCOB>; Sat, 6 Oct 2001 22:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276028AbRJGCNu>; Sat, 6 Oct 2001 22:13:50 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:49676 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S275973AbRJGCNd>;
	Sat, 6 Oct 2001 22:13:33 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15295.47686.932418.81948@cargo.ozlabs.ibm.com>
Date: Sun, 7 Oct 2001 12:13:26 +1000 (EST)
To: Jes Sorensen <jes@sunsite.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get virtual address from dma address
In-Reply-To: <d3adz4u1gx.fsf@lxplus014.cern.ch>
In-Reply-To: <200110032244.f93MiI103485@localhost.localdomain>
	<d3n136tc48.fsf@lxplus014.cern.ch>
	<15294.47999.501719.858693@cargo.ozlabs.ibm.com>
	<20011006.013819.17864926.davem@redhat.com>
	<15294.63138.941581.771248@cargo.ozlabs.ibm.com>
	<d3adz4u1gx.fsf@lxplus014.cern.ch>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen writes:

> I haven't looked at the ohci driver at all, however doesn't it return
> anything but the dma address? No index, no offset, no nothing? If
> thats the case, someone really needs to go visit the designers with a
> large bat ;-(

The OHCI hardware works with linked lists of transfer descriptors,
using bus addresses for the pointers of course.  When a transfer
descriptor is completed, it gets linked onto a done-list by the
hardware (on to the front of the list, so you get the completed
descriptors in reverse order).

There is no way to predict the completion order in general because you
can have transfers in progress to several different devices, and to
several endpoints on each device, at the same time, which can each
supply or accept data at different rates.

I don't think the OHCI designers considered the possibility that it
might be less than straightforward for the CPU to access some memory
given its bus address.  And I would have a hard time arguing against
someone who claimed that a platform where that was difficult was
just terminally broken. :)

Paul.
