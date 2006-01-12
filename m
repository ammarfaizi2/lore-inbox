Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWALPG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWALPG6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 10:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbWALPG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 10:06:58 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:4846 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1030441AbWALPG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 10:06:57 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
To: xen-devel@lists.xensource.com
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
Date: Thu, 12 Jan 2006 14:53:39 +0000
User-Agent: KMail/1.9.1
Cc: "Mike D. Day" <ncmike@us.ibm.com>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Anthony Liguori <aliguori@us.ibm.com>
References: <43C53DA0.60704@us.ibm.com> <20060112071000.GA32418@kroah.com> <43C66B56.8030801@us.ibm.com>
In-Reply-To: <43C66B56.8030801@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601121453.39629.mark.williamson@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You make a very good point. We have not agreed on the heirarchy and file
> contents, and  we need to do so before continuing.
> Some _very rough_ ideas include
>
> /sys/xen/version/{major minor extra version build}
> /sys/xen/domain/{dom0 dom1 ... domn} (each domain could be a dir. with
> attributes)
> /sys/xen/hypervisor/{scheduler cpu memory}
> /sys/xen/migrate/{hosts_to, hosts_from}

It seems to me there are a number of distinct categories these attributes come 
into:

* Xen virtual hardware info (more or less corresponds to what's in /proc now, 
although proc also has the special xenbus and privcmd interface files)
   - hypervisor version, etc
   - capabilities of this domain (admin rights, physical hardware permissions, 
etc)
   - other stuff relating to the Xen in use, or the domain this virtual 
machine is running in

* Xen management
   - info relating to the underlying hardware
   - global scheduler params
   - activate / deactive Xen trace buffers, etc

* Domain management
   - status regarding the domains in the system
   - migration controls

I'd suggest that earlier items in the above list are more important to get 
into sysfs, with the lower stuff being able to follow later.  Hows about we 
start with defining a structure for the stuff in the first (and maybe second) 
bullet points above, and work from there?

> These will be text files with simple attrributes. Most will be
> read-only. It is kind of fun to think about creating a domain by doing
> something like
>
> cat $domain_config > /sys/xen/domain/new
>
> but there are some ugly aspects of doing so. Likewise it would be good
> to add a potential migration host by writing an ip address to
> /sys/xen/migrate/hosts_to
>
> Again, we need to get this solidified before going further.

Anthony (cc-ed) did a little work on implementing something like this using 
FuSE to call the existing management interfaces we have for this 
functionality.  IIRC, it was mostly targetted at reading information about 
running domains, but it seemed like a good level to implement these 
higher-level controls in a virtual FS.

Cheers,
Mark
-- 
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
