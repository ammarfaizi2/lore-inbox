Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWCIXTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWCIXTA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWCIXTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:19:00 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:38691 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751959AbWCIXS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:18:59 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 8 of 20] ipath - sysfs support for core driver
X-Message-Flag: Warning: May contain useful information
References: <ef8042c934401522ed3f.1141922821@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 15:18:49 -0800
In-Reply-To: <ef8042c934401522ed3f.1141922821@localhost.localdomain> (Bryan O'Sullivan's message of "Thu,  9 Mar 2006 08:47:01 -0800")
Message-ID: <adapskvfbqe.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Mar 2006 23:18:50.0509 (UTC) FILETIME=[D311D3D0:01C643CF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +static ssize_t show_version(struct device_driver *dev, char *buf)
 > +{
 > +	return scnprintf(buf, PAGE_SIZE, "%s", ipath_core_version);
 > +}

Any reason you left a "\n" off of this attribute?

 > +static ssize_t show_atomic_stats(struct device_driver *dev, char *buf)
 > +{
 > +	memcpy(buf, &ipath_stats, sizeof(ipath_stats));
 > +
 > +	return sizeof(ipath_stats);
 > +}

I think putting a whole binary struct in a sysfs attribute is
considered a no-no.

 > +static ssize_t show_boardversion(struct device *dev,
 > +			       struct device_attribute *attr,
 > +			       char *buf)
 > +{
 > +	struct ipath_devdata *dd = dev_get_drvdata(dev);
 > +	return scnprintf(buf, PAGE_SIZE, "%s", dd->ipath_boardversion);
 > +}

Another missing "\n"
