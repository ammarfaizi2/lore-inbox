Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268265AbUIBMEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268265AbUIBMEH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268266AbUIBMEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:04:07 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:1233 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268265AbUIBMEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:04:02 -0400
Subject: Re: [patch] kernel sysfs events layer
From: Daniel Stekloff <dsteklof@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Robert Love <rml@ximian.com>, akpm@osdl.org, kay.sievers@vrfy.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040902083407.GC3191@kroah.com>
References: <1093988576.4815.43.camel@betsy.boston.ximian.com>
	 <20040831145643.08fdf612.akpm@osdl.org>
	 <1093989513.4815.45.camel@betsy.boston.ximian.com>
	 <20040831150645.4aa8fd27.akpm@osdl.org>
	 <1093989924.4815.56.camel@betsy.boston.ximian.com>
	 <20040902083407.GC3191@kroah.com>
Content-Type: text/plain
Message-Id: <1094126565.1761.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 05:02:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-02 at 01:34, Greg KH wrote:
> On Tue, Aug 31, 2004 at 06:05:24PM -0400, Robert Love wrote:
> > +int send_kevent(enum kevent type, struct kset *kset,
> > +		struct kobject *kobj, const char *signal);
> 
> Why is the kset needed?  We can determine that from the kobject.
> 
> How about changing this to:
> 	int send_kevent(struct kobject *kobj, struct attribute *attr);
> which just tells userspace that a specific attribute needs to be read,
> as something "important" has changed.


Do all events require an attribute? What about the "overheating"
example? Would you need an attribute or would getting a "signal" for a
specific kobj be enough? 

Binding an attribute to an event would at least tell you the name of the
attribute to check. Otherwise, how does an app know the name of the
attribute that changed? Or am I missing something?

Thanks,

Dan



> Will passing the attribute name be able to successfully handle the 
> "enum kevent" and "signal" combinations?
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

