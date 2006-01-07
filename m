Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030381AbWAGJnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030381AbWAGJnY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 04:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932710AbWAGJnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 04:43:24 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:26038 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932709AbWAGJnX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 04:43:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VZST0giG1s1AIB++aLST1pTDmxDFe2XU1/BU9ppIPTtS3vQl4AwudNvjMnfSlf/O+gW0AZgwsiInLu1hysRbbw6h/eVoTo6FCyN1rCZPwjZ5T3tgjwDDw3S9VBWHob5XdgrQBzCFMdrUlxhIFr2gdEnT2wKvzgSxRsT3CdLprkg=
Message-ID: <86802c440601070143v44ee9f4dua2dcef2a536d4c73@mail.gmail.com>
Date: Sat, 7 Jan 2006 01:43:22 -0800
From: yhlu <yhlu.kernel@gmail.com>
To: Andi Kleen <ak@muc.de>, ebiederm@xmission.com
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
In-Reply-To: <86802c440601062320r597d6970i3b120ec90f96abce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
	 <86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
	 <86802c440601062238r1b304cd4j2d9c8e14a8324618@mail.gmail.com>
	 <86802c440601062320r597d6970i3b120ec90f96abce@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andi,

In LinuxBIOS, we don't set the MPS 0x467 and the AP still can be started by BSP.

are these really needed for x86_64?

        Dprintk("Setting warm reset code and vector.\n");

        CMOS_WRITE(0xa, 0xf);
        local_flush_tlb();
        Dprintk("1.\n");
        *((volatile unsigned short *) phys_to_virt(0x469)) = start_rip >> 4;
        Dprintk("2.\n");
        *((volatile unsigned short *) phys_to_virt(0x467)) = start_rip & 0xf;
        Dprintk("3.\n");

the STARTUP IPI should work well with MPS v1.4

YH
