Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264395AbTLKI2U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264463AbTLKI2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:28:20 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:39298 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264395AbTLKI2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:28:16 -0500
Message-ID: <3FD82A8A.9050307@google.com>
Date: Thu, 11 Dec 2003 00:27:54 -0800
From: Paul Menage <menage@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] ACPI global lock macros
References: <3ACA40606221794F80A5670F0AF15F8401720C21@PDSMSX403.ccr.corp.intel.com> <20031211090716.0c3662d3.ak@suse.de>
In-Reply-To: <20031211090716.0c3662d3.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> It has even more bugs, e.g. it doesn't tell gcc that GLptr is modified (this hurts with
> newer versions that optimize more aggressively) 

GLptr itself isn't modified - *GLptr is, but none of the actual C code 
accesses *GLptr, so how does this affect the compiler's optimization 
efforts? Is it because gcc treats the call as a pure function that maps 
a pointer to an acquired value, and hence believes that it can move it 
around? There aren't any instances of ACPI_ACQUIRE_GLOBAL_LOCK being 
called twice in the same function, so it wouldn't be able to cache a 
result. But I agree that it ought to declare that it clobbers memory.

Paul


