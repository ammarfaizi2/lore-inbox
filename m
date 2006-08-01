Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWHAUZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWHAUZZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161041AbWHAUZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:25:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46759 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161039AbWHAUZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:25:24 -0400
Date: Tue, 1 Aug 2006 13:25:09 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: get_device in device_create_file
Message-Id: <20060801132509.27269013.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.20; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Greg:

This code makes no sense to me:

> int device_create_file(struct device * dev, struct device_attribute * attr)
> {
> 	int error = 0;
> 	if (get_device(dev)) {
> 		error = sysfs_create_file(&dev->kobj, &attr->attr);
> 		put_device(dev);
> 	}
> 	return error;
> }

If the struct device *dev, and its presumably enclosing structure,
can be freed by a different CPU (or pre-empt), then get_device
does not protect it. It can be freed before get_device is reached.
Buf it not, and the caller has a reference, then the call to
get_device is redundant.

How is this supposed to work?

-- Pete
