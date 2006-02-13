Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWBMQdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWBMQdI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 11:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWBMQdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 11:33:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:30744 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S932076AbWBMQdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 11:33:07 -0500
Message-ID: <43F0B484.3060603@cfl.rr.com>
Date: Mon, 13 Feb 2006 11:32:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Seewer Philippe <philippe.seewer@bfh.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFC: disk geometry via sysfs
References: <43EC8FBA.1080307@bfh.ch>
In-Reply-To: <43EC8FBA.1080307@bfh.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2006 16:33:53.0636 (UTC) FILETIME=[47173A40:01C630BB]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14265.000
X-TM-AS-Result: No--6.900000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seewer Philippe wrote:
> Hello all!
>
> I don't want to start another geometry war, but with the introduction of
> the general getgeo function by Christoph Hellwig for all disks this
> simply would become a matter of extending the basic gendisk block driver.
>
> There are people out there (like me) who need to know about disk
> geometry. But since this is clearly post 2.6.16 I prefer to ask here
> before writing a patch...
>   

Why do you need to know about geometry?  Geometry is a useless fiction 
that only still exists in PC system BIOS for the sake of backward 
compatibility with software that was originally designed to operate with 
MFM and RLL disks that actually used geometric addressing.  These days 
there is no such thing; it's just made up by the bios. 
> Q1: Yes or No?
> If no, the other questions do not apply
>
> Q2: Where under sysfs?
> Either do /sys/block/hdx/heads, /sys/block/hdx/sectors, etc. or should
> there be a new sub-object like /sys/block/hdx/geometry/heads?
>   

This is not suitable because block devices may not be bios accessible, 
and thus, nowhere to get any bogus geometry information from.  Even if 
it is, do we really want to be calling the bios to get this information 
and keep it around?

> Q3: Writable?
> Under some (weird) circumstances it would actually be quite nice to
> overwrite the kernels idea of a disks geometry. This would require a
> general function like setgeo. Acceptable?
>
>   

What for?  The only purpose to geometry is bios compatibility.  Changing 
the kernel's copy of the values won't do any good because the bios won't 
be changed. 


