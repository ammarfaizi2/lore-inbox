Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTEGCO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 22:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTEGCO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 22:14:59 -0400
Received: from holomorphy.com ([66.224.33.161]:29068 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261832AbTEGCO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 22:14:58 -0400
Date: Tue, 6 May 2003 19:27:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Keith Mannthey <kmannth@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][Patch] fix for irq_affinity_write_proc v2.5
Message-ID: <20030507022717.GV8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Keith Mannthey <kmannth@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1052247789.16886.261.camel@dyn9-47-17-180.beaverton.ibm.com> <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052250874.1202.162.camel@dhcp22.swansea.linux.org.uk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 20:03, Keith Mannthey wrote:
>>   irq_affinity_write_proc currently directly calls set_ioapic_affinity
>> which writes to the ioapic.  This undermines the work done by kirqd by
>> writing a cpu mask directly to the ioapic. I propose the following patch
>> to tie the /proc affinity writes into the same code path as kirqd. 
>> Kirqd will enforce the affinity requested by the user.   

On Tue, May 06, 2003 at 08:54:35PM +0100, Alan Cox wrote:
> Why should the kernel be enforcing policy here. You have to be root to 
> do this, and root should have the ability to configure apparently stupid
> things because they may find them useful.

It's basically not working as specified for clustered hierarchical, and
in truth the specification can never be met. As it stands most calls to
it are lethal on such systems, especially those using physical destmod.

I'd prefer to have it redesigned for some validity checking and error
returns as on such systems the impossible destinations serve no purpose
but raising MCE's and/or deadlocking the box.


-- wli
