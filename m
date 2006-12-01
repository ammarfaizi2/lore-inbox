Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161254AbWLAU4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161254AbWLAU4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161334AbWLAU4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:56:42 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:45511 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S1161254AbWLAU4m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:56:42 -0500
Subject: Re: [PATCH 2/4] [APIC] Allow disabling of UP APIC/IO-APIC by
	default, with command line option to turn it on.
From: Ben Collins <ben.collins@ubuntu.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061201083900.GA26703@elte.hu>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	 <11648607732981-git-send-email-bcollins@ubuntu.com>
	 <20061201083900.GA26703@elte.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 01 Dec 2006 15:56:36 -0500
Message-Id: <1165006596.5257.966.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 09:39 +0100, Ingo Molnar wrote:
> * Ben Collins <bcollins@ubuntu.com> wrote:

> that should be "ioapic", not "apic". The CPU has a piece of silicon 
> called the "local APIC" - enabled via the 'lapic' option, and disabled 
> via noapic. What the option above wants to enable is the IO-APIC in the 
> chipset (a different piece of silicon) and the interrupt routing 
> capabilities attached to it. That piece is what is causing the installer 
> problems.

I know the difference between APIC and IO-APIC :)

Thing is, the function right above the one I added was this:

static int __init parse_noapic(char *arg)
{
        /* disable IO-APIC */
        disable_ioapic_setup();
        return 0;
}
early_param("noapic", parse_noapic);

So while "ioapic" might make more sense, it's doesn't match the opposing
command line option of "noapic".

I could include this in the diff:

+/* "noapic" is for backward compatibility */
 early_param("noapic", parse_noapic);
+early_param("noioapic", parse_noapic);

And then add the "ioapic" option.
