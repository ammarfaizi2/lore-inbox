Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbTIYSJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 14:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261828AbTIYSIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 14:08:55 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:45221 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S261835AbTIYSES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 14:04:18 -0400
Subject: Re: [PATCH} fix defect with kobject memory leaks during del_gendisk
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
In-Reply-To: <20030925072343.A4636@infradead.org>
References: <1064444526.13033.355.camel@persist.az.mvista.com>
	 <20030925072343.A4636@infradead.org>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1064513050.4763.21.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 25 Sep 2003 11:04:11 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-24 at 23:23, Christoph Hellwig wrote:
> On Wed, Sep 24, 2003 at 04:02:06PM -0700, Steven Dake wrote:
> > Unfortunately it appears that del_gendisk uses kobject_del to delete the
> > kobject.  If the kobject has a ktype release function, it is not called
> > in the kobject_del call path, but only in kobject_unregister.
> 
> That's intentional.  gendisks (like everything using kobjects) are
> reference counted and ->release is unly called after the last reference
> goes away, for gendisks that would be the last put_disk call.
> 
> Unless you miss the put_disk call (which md certainly has) there's
> no memeory leak.
> 
Thanks Christoph...

Looks like I'm barking up the wrong tree.  Time to go fix up md :)

-steve
> 

