Return-Path: <linux-kernel-owner+w=401wt.eu-S1030225AbXAKIc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbXAKIc2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 03:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbXAKIc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 03:32:28 -0500
Received: from il.qumranet.com ([62.219.232.206]:53198 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030225AbXAKIc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 03:32:28 -0500
Message-ID: <45A5F616.3040305@qumranet.com>
Date: Thu, 11 Jan 2007 10:32:22 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
References: <45A39A97.5060807@qumranet.com> <45A39D0D.7090007@garzik.org> <200701110834.43800.arnd@arndb.de> <45A5F4A5.9000408@garzik.org>
In-Reply-To: <45A5F4A5.9000408@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Arnd Bergmann wrote:
>> On Tuesday 09 January 2007 14:47, Jeff Garzik wrote:
>>> Can we please avoid adding a ton of new ioctls?  ioctls inevitably 
>>> require 64-bit compat code for certain architectures, whereas 
>>> sysfs/procfs does not.
>>
>> For performance reasons, an ascii string based interface is not
>> desireable here, some of these calls should be optimized to
>> the point of counting cycles.
>
> sysfs does not require ASCII...
>

The main kvm ioctl switches the execution mode to guest mode.  Just like 
a syscall enters kernel mode, ioctl(vcpu_fd, KVM_VCPU_RUN) enters the 
guest address space and begins executing guest code.

I don't see how to model that with sysfs.

There are other objections as well. sysfs is a public interface, whereas 
kvm is a process private attribute.  These objections don't apply to 
/proc though.


-- 
error compiling committee.c: too many arguments to function

