Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUKXDOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUKXDOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 22:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbUKXDOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 22:14:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:26046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261700AbUKXDOb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 22:14:31 -0500
Message-ID: <41A3FBC4.5030609@osdl.org>
Date: Tue, 23 Nov 2004 19:11:00 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       jgarzik@pobox.com, alan@redhat.com, david.balazic@hermes.si,
       hpa@zytor.com, ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] EDD: add edd=off and edd=skipmbr options
References: <20041123230001.GE30452@lists.us.dell.com>
In-Reply-To: <20041123230001.GE30452@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> 
> Peter, Andi: I've built this for x86 and x86-64, and run this on x86.
> I'd appreciate your review of the assembly code, and suggestions for
> improvement, prior to my submitting it to akpm for 2.6.11.
> 
> EDD: add edd=off and edd=skipmbr command line options
>     
> New command line options
> edd=off     (or edd=of)
> edd=skipmbr (or edd=sk)
>  
> These are provided to allow Linux distributions to include CONFIG_EDD=m, yet
> allow end-users to disable parts of EDD which may not work well with their
> system's BIOS.

Sorry to nitpick this, but the doc. should include an
'=' sign like the ones before and after it:

  	edb=		[HW,PS2]
+
+	edd		[EDD]
+			Format: {"of[f]" | "sk[ipmbr]"}
+			See comment in arch/i386/boot/edd.S


in edd.S:
+	movb	$0, (EDD_MBR_SIG_NR_BUF)	# zero value at EDD_MBR_SIG_NR_BUF
+	movb	$0, (EDDNR)			# zero value at EDDNR

Such obvious comments aren't needed, even if they were just
moved from other places....

Rest of the .S code makes sense to me.

~Randy
