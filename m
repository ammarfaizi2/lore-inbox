Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbTELOpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 10:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbTELOpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 10:45:33 -0400
Received: from franka.aracnet.com ([216.99.193.44]:50126 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262185AbTELOp1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 10:45:27 -0400
Date: Mon, 12 May 2003 05:43:50 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: bug on shutdown from 68-mm4 (machine_power_off returning causes problems)
Message-ID: <22080000.1052743429@[10.10.2.4]>
In-Reply-To: <m11xz45lqk.fsf@frodo.biederman.org>
References: <8570000.1052623548@[10.10.2.4]><20030510224421.3347ea78.akpm@digeo.com><8880000.1052624174@[10.10.2.4]><20030510231120.580243be.akpm@digeo.com><12530000.1052664451@[10.10.2.4]><m17k8x72ir.fsf_-_@frodo.biederman.org><19660000.1052710226@[10.10.2.4]> <m11xz45lqk.fsf@frodo.biederman.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Yup, backing out kexec fixes it.
>> > 
>> > 
>> > Ok.  Thinking it through the differences is that I have machine_power_off
>> > call stop_apics (which is roughly equivalent to the old smp_send_stop).
>> 
>> Mmmm. Not sure NUMA-Q will like disconnect_bsp_APIC() much, but I guess
>> that's my problem, not yours ;-) I can't do init 6 at the moment, so I'm
>> walking on thin ice as is ... if I have to fix a couple of things up for
>> NUMA-Q, that's no problem.
> 
> Ah ok.  This could explain some of your problems with kexec if you
> can't even reboot the box....

Well, yes ... but I'm not trying to use kexec, just doing an init 0 ;-)
That worked fine before. Perhaps you want to take this code out of the
power down path, and just have it in the reboot path? Seems odd to change
the power down path if you don't need to.

> I have sent the fixed patches to Andrew and CC'd the list so we will
> see what develops.

Thanks, will try them sometime soon-ish ;-)

M.

