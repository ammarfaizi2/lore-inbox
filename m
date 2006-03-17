Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752581AbWCQJbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbWCQJbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbWCQJbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:31:21 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:59510 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752581AbWCQJbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:31:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qMNvnJfm0zEox6JKTQFqxg4eT/YOqOYeJQeLw7FxnZCb4dFNC7+/DXk8fFs0arjvOF7FjMAAIRT8MMF7yJO/zT7RpTEDWtNdp6ZYRictzNN/0oqti75CHGL5/GFzYQDQ3XdUWvXVAsjPe6JsZRP19ZDdOnrjDDTRhTEwNJv3Nng=
Message-ID: <661de9470603170131j7580d8ccr9927a600a7184ef3@mail.gmail.com>
Date: Fri, 17 Mar 2006 15:01:19 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: prasanna@in.ibm.com
Subject: Re: Kernel Oops-jprobe
Cc: "emist emist" <emistz@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060317025519.GA32497@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060317025519.GA32497@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> >DEVPATH=/module/sysensor SUBSYSTEM=module[17192146.124000] Unable to
> >handle kernel paging request at virtual address 080c9566

The address looks like a user space address. Since sys_open() passes
user space arguments - in this case a pointer to the filename. Are you
derefencing the pointer correctly?

I think the handler should first copy_from_user().

Moreover your stack is
[17192146.124000] Call Trace:
[17192146.124000]  [<c01c6384>] vscnprintf+0x17/0x24
[17192146.124000]  [<c0116c7d>] vprintk+0x62/0x22a
[17192146.124000]  [<c02a8682>] int3+0x1e/0x24
[17192146.124000]  [<c0116c18>] printk+0xe/0x11
[17192146.124000]  [<e05610ac>] jsys_open+0x1d/0x28 [sysensor]
[17192146.124000]  [<c0102cef>] sysenter_past_esp+0x54/0x75
[17192146.124000] Code: 77 03 c6 03 20 4d 43 85 ed 7f f1 e9 9e 01 00
00 89 f0 89 fa 83 c6 04 8b 08 b8 19 14 2d c0 81 f9 ff 0f 00 00 0f 46
c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 f6 04 24 10
89 c7 75

and in the code posted, there is no printk in jsys_open(). Have you
sent a revised version of your probe module?

Regards,
Balbir
