Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUIQXeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUIQXeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 19:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269042AbUIQXeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 19:34:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269018AbUIQXeV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 19:34:21 -0400
Message-ID: <414B7470.4000703@pobox.com>
Date: Fri, 17 Sep 2004 19:34:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Li Shaohua <shaohua.li@intel.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: hotplug e1000 failed after 32 times
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>	<20040916221406.1f3764e0.akpm@osdl.org>	<1095411933.10407.29.camel@sli10-desk.sh.intel.com> <20040917161920.16d18333.akpm@osdl.org>
In-Reply-To: <20040917161920.16d18333.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All this work and code for such an uncommon case??

First off, any settings which are _indexed_ are almost guaranteed 
broken.  For reasons as we see here, and others.  Any 
"setting_foo[board_number]" should be found and eliminated instead.

Even if you allocate and free board numbers as described, how precisely 
do you propose to predict which settings belong to which hotplugged 
board?  Look at the problem, and you realize that the board<->setting 
association becomes effectively _random_ for any adapter not present at 
modprobe time.

The best model is to set these settings via netlink/ethtool after 
registering the interface, but before bringing it up.

	Jeff



