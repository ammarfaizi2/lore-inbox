Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTJFSii (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbTJFSii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:38:38 -0400
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:56042 "EHLO
	office.lsg.internal") by vger.kernel.org with ESMTP id S262439AbTJFSig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:38:36 -0400
Message-ID: <3F81B6A1.4030406@backtobasicsmgmt.com>
Date: Mon, 06 Oct 2003 11:38:25 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Christian Borntraeger <CBORNTRA@de.ibm.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [RFC 0/6] Backing Store for sysfs
References: <OF6873DDE8.877C0EE8-ONC1256DB7.005F0935-C1256DB7.0060DEDC@de.ibm.com> <20031006174128.GA4460@kroah.com> <3F81ADC8.3090403@backtobasicsmgmt.com> <20031006181134.GA4657@kroah.com> <3F81B339.6040201@backtobasicsmgmt.com> <20031006183056.GA4714@kroah.com>
In-Reply-To: <20031006183056.GA4714@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

> They might, depending on the patch implementation.  And no, the issue
> isn't different, as we have to show the memory usage after all kobjects
> are accessed in sysfs from userspace, not just before, like some of the
> measurements are, in order to try to compare apples to apples.
> 

My point in saying that they are different was that your original 
message implied each hotplug event would be walking most (or all) of 
the sysfs tree _each time_, thus effectively touching all the dentries 
and inodes in the cache. In actuality during system startup it will 
appear that this is the case as all the hotplug events occur, but once 
that flurry is over the caches can release the unused entries. Later 
hotplug events would only bring in the entries relevant to the 
specific kobject that the event relates to, so would cause minimal 
cache pressure.

Now that I understand how you're expecting hotplug/udev to interact 
I'll bow out of this thread... I can't even begin to understand the 
complexities of the patch that's been posted :-)

