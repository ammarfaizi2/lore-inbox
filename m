Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbVCXPit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbVCXPit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263097AbVCXPet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:34:49 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9156 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262571AbVCXPdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:33:20 -0500
Subject: Re: [RFC] Obtaining memory information for kexec/kdump
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hariprasad Nellitheertha [imap]" <hari@in.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fastboot <fastboot@lists.osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4242941A.3050501@in.ibm.com>
References: <424254E0.6060003@in.ibm.com>
	 <1111650644.9881.43.camel@localhost>  <4242941A.3050501@in.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Mar 2005 07:32:51 -0800
Message-Id: <1111678371.9881.46.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 15:49 +0530, Hariprasad Nellitheertha wrote:
> Dave Hansen wrote:
> > I think there's likely a lot of commonality with the needs of memory
> > hotplug systems here.  We effectively dump out the physical layout of
> > the system, but in sysfs.  We do this mostly because any memory hotplug
> > changes generate hotplug events, just like all other hardware.  If you
> > do this in /proc, it's another thing that memory hotplug will have to
> > update.  
> 
> We put it in /proc primarily because what we wanted was 
> similar in many ways to /proc/iomem and so we (re)use a bit 
> of the code.

The code reuse is nice, but the expanded use of /proc is not.  

> Also, we were wondering if it is appropriate to 
> put in multiple values in a single file in sysfs.

Why would you need to do that?
>   I've attached a document I started writing a couple days ago
> > about the sysfs layout and the call paths for hotplug.  It's horribly
> > incomplete, but not a bad start.
> > 
> > If you want to see some more details of the layout, please check out
> > this patch set:
> > 
> > http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/patch-2.6.12-rc1-mhp1.gz
> 
> This does not have the sysfs related code. Is there a 
> separate patch for adding the sysfs entries?

Hmmm.  I think my rollup script broke.  Try this:

http://www.sr71.net/patches/2.6.12/2.6.12-rc1-mhp1/broken-out/L0-sysfs-memory-class.patch

> > block_size_bytes:  The size of each memory section (in hex)
> 
> This value is per memoryXXXX directory, right?

No, it's global.  However, we have discussed doing it per-section in the
future to collapse some of the contiguous areas into a single directory.

-- Dave

