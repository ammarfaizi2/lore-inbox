Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUKSMnf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUKSMnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUKSMnX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:43:23 -0500
Received: from main.gmane.org ([80.91.229.2]:31145 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261383AbUKSMl0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:41:26 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: modprobe + request_module() deadlock
Date: Fri, 19 Nov 2004 17:42:51 +0500
Message-ID: <cnkpl6$jjm$1@sea.gmane.org>
References: <20041117222949.GA9006@linuxtv.org> <1100749702.5865.39.camel@localhost.localdomain> <20041118135522.GA16910@linuxtv.org> <s5h4qjnc6zs.wl@alsa2.suse.de> <cnjr8v$dcu$1@sea.gmane.org> <s5hpt2aayco.wl@alsa2.suse.de> <20041119115042.GA30334@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: inet.ycc.ru
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:

>> Well, how about to add a new marker in the driver code such as
>> 
>> MODULE_DEPENDS_ON("somemodule");
>> 
>> so that depmod can pick it up?
> 
> Wouldn't work for me as this isn't static.  saa7134 has to look at the
> hardware, then decide whenever it should load saa7134-empress,
> saa7134-dvb or none of them.
> 
> On the other hand I don't depend on request_module() waiting for the
> modprobe being finished.  So maybe we can solve that with a
> request_module_async()?

Unfortunately I am not an expert here, but wouldn't it be sufficient to
export in sysfs the information needed to distinguish between those two
saa7134-* modules, and then submit a new agent to linux-hotplug-devel? Then
hotplug will take care of loading the correct module (and hotplug is always
called asynchronously).

-- 
Alexander E. Patrakov

