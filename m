Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUBZVc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 16:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbUBZVc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 16:32:28 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:38342 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261220AbUBZVbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 16:31:44 -0500
In-Reply-To: <20040226001830.GB3702@kroah.com>
References: <1077667227.21201.73.camel@SigurRos.rchland.ibm.com> <20040225012845.GA3909@kroah.com> <opr3woijnwl6e53g@us.ibm.com> <20040225042224.GA5135@kroah.com> <1077708874.22213.13.camel@gaston> <C4149BD3-67A9-11D8-B826-000A95A0560C@us.ibm.com> <20040226001830.GB3702@kroah.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <307BD6D0-68A3-11D8-9E2B-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
Cc: Ryan Arnold <rsa@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dave Boutcher <sleddog@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: device/kobject naming
Date: Thu, 26 Feb 2004 15:31:50 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.612)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 25, 2004, at 6:18 PM, Greg KH wrote:
>
> No, I think you are confused.  The only thing that has to be unique in
> the kobject/device name is it must be unique for the bus it is on.

I must be confused. device_initialize() sets the new device->kobj->kset 
to devices_subsys.kset. Then device_add() calls kobject_add(), which 
appends device->kobj to its kset. As we've already discussed, 
devices_subsys is a global list of all registered devices in the 
system, not a per-bus list.

It doesn't look like this will actually cause an immediate error (in 
that the sysfs directory created will be different per bus), but you 
could end up with two devices named "foo" in the devices_subsys list, 
even if they're on different busses.

-- 
Hollis Blanchard
IBM Linux Technology Center

