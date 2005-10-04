Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVJDPYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVJDPYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVJDPYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:24:24 -0400
Received: from ns.suse.de ([195.135.220.2]:17826 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964800AbVJDPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:24:23 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 2/2] x86_64: move apic init in init_IRQs
Date: Tue, 4 Oct 2005 17:24:36 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
References: <m13bnh8gdo.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bnh8gdo.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041724.36535.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 17:13, Eric W. Biederman wrote:
> All kinds of ugliness exists because we don't initialize
> the apics during init_IRQs.
> - We calibrate jiffies in non apic mode even when we are using apics.
> - We have to have special code to initialize the apics when non-smp.
> - The legacy i8259 must exist and be setup correctly, even
>   we won't use it past initialization.

Actually some setups use its timer even in ACPI mode. Do you take this into 
account?


In theory it looks reasonable, but I guess it won't work without the bogus
watchdog change. That would need to be resolved first.

-Andi
