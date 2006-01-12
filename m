Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWALOop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWALOop (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbWALOoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:44:44 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:41660 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030424AbWALOoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:44:44 -0500
Message-ID: <43C66B56.8030801@us.ibm.com>
Date: Thu, 12 Jan 2006 09:44:38 -0500
From: "Mike D. Day" <ncmike@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Macintosh/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: xen-devel@lists.xensource.com, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: [RFC] [PATCH] sysfs support for Xen attributes
References: <43C53DA0.60704@us.ibm.com> <20060111230704.GA32558@kroah.com>	<43C5A199.1080708@us.ibm.com> <20060112005710.GA2936@kroah.com>	<43C5B59C.8050908@us.ibm.com> <20060112071000.GA32418@kroah.com>
In-Reply-To: <20060112071000.GA32418@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> What other, specific sysfs files are you going to want to create?
> What is the hierarchy going to look like?
> What is the contents of the file going to look like?

You make a very good point. We have not agreed on the heirarchy and file 
contents, and  we need to do so before continuing.
Some _very rough_ ideas include

/sys/xen/version/{major minor extra version build}
/sys/xen/domain/{dom0 dom1 ... domn} (each domain could be a dir. with 
attributes)
/sys/xen/hypervisor/{scheduler cpu memory}
/sys/xen/migrate/{hosts_to, hosts_from}

These will be text files with simple attrributes. Most will be 
read-only. It is kind of fun to think about creating a domain by doing 
something like

cat $domain_config > /sys/xen/domain/new

but there are some ugly aspects of doing so. Likewise it would be good 
to add a potential migration host by writing an ip address to
/sys/xen/migrate/hosts_to

Again, we need to get this solidified before going further.

> 
> I think this is happening as you are trying to port your code that
> currently uses /proc (and file names there) to use sysfs instead, right?
> To do this correctly, you need to stop thinking about file names and
> paths, and start thinking about the hierarchy and relationship between
> the files, which will allow you to create a tree of kobjects easier.

yes

> If you answer the questions above, I think we can work to figure this
> out.

Excellent, we will work on doing so.

> I should be happy you didn't try to post them using Notes :)

Make that two of us :)
-- 

Mike D. Day
STSM and Architect, Open Virtualization
IBM Linux Technology Center
ncmike@us.ibm.com
