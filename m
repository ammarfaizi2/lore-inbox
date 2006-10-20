Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWJTKIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWJTKIh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 06:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWJTKIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 06:08:37 -0400
Received: from ozlabs.org ([203.10.76.45]:46542 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932248AbWJTKIg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 06:08:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17720.40987.289776.269230@cargo.ozlabs.ibm.com>
Date: Fri, 20 Oct 2006 20:08:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>,
       Deepak Saxena <dsaxena@plexity.net>
Subject: Re: [PATCH] Add device addition/removal notifier
In-Reply-To: <20061020061618.GA9432@kroah.com>
References: <1161309350.10524.119.camel@localhost.localdomain>
	<20061020032624.GA7620@kroah.com>
	<1161318564.10524.131.camel@localhost.localdomain>
	<20061020044454.GA8627@kroah.com>
	<1161322979.10524.143.camel@localhost.localdomain>
	<20061020061618.GA9432@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> Remember, we didn't add a type identifier to the struct device for a
> reason, comparing the string of the bus type is not a good idea (for
> USB, it will get you in trouble, because two different types of devices
> can be on that bus, who's to say other busses will not also have that
> issue?)

But then we added the dma_map_* API, which only gets the struct device
pointer but needs to do something different depending on what type of
bus the device is on, and possibly even depending on which instance of
its bus type it's on...

If we are going to have APIs like this that work on a struct device,
then we need to have some good way to know what type of bus the device
is on, and what code we need to call to manipulate that bus type.

Paul.
