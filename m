Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268535AbUIQHrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268535AbUIQHrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268534AbUIQHry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:47:54 -0400
Received: from main.gmane.org ([80.91.229.2]:50839 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268535AbUIQHrv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:47:51 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: udev is too slow creating devices
Date: Fri, 17 Sep 2004 13:48:02 +0600
Message-ID: <cie4r1$c57$1@sea.gmane.org>
References: <41473972.8010104@debian.org> <41474926.8050808@nortelnetworks.com> <20040914195221.GA21691@kroah.com> <414757FD.5050209@pixelized.ch> <20040914213506.GA22637@kroah.com> <20040914214552.GA13879@wonderland.linux.it> <20040914215122.GA22782@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 80.78.110.194
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <20040914215122.GA22782@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Tue, Sep 14, 2004 at 11:45:52PM +0200, Marco d'Itri wrote:
> 
>>On Sep 14, Greg KH <greg@kroah.com> wrote:
>>
>>
>>>What's wrong with the /etc/dev.d/ location for any type of script that
>>>you want to run after a device node has appeared?  This is an
>>>application specific issue, not a kernel issue.
>>
>>The problem is that since most distributions cannot make udev usage
>>mandatory, this would require duplicating in the init script and in the
>>dev.d script whatever needs to be done with the device.
> 
> 
> Well, that sounds like a distro problem then, not a kernel or udev one :)
> 
> 
>>Then there are the issues of scripts needing programs in /usr, which may
>>not be mounted when the module is loaded, or which are interactive and
>>need console access (think fsck).
> 
> 
> True, so sit and spin and sleep until you see the device node.  That's
> how a number of distros have fixed the fsck startup issue.

Hm, why should _I_ sleep and spin after modprobe, without even knowing 
if the node will appear at all, when you can include the "modprobe" 
wrapper script with udev source package.

This wrapper should call modprobe.orig with original arguments, and then 
call udev for /sys entries that appeared (or just run udevstart), and 
only then return. Yes, this will result in duplicate hotplug events 
(synthetic + real) being delivered to udev, but it solves the problem 
with modprobe once, for all programs, and in compatible way.

-- 
Alexander E. Patrakov

