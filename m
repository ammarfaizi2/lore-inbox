Return-Path: <linux-kernel-owner+w=401wt.eu-S932662AbXAHUrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbXAHUrK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 15:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422737AbXAHUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 15:47:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36458 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932668AbXAHUrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 15:47:06 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Tobias Diedrich" <ranma+kernel@tdiedrich.de>,
       "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "Andi Kleen" <ak@suse.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86_64 ioapic: Improve the heuristics for when check_timer fails.
References: <5986589C150B2F49A46483AC44C7BCA4907360@ssvlexmb2.amd.com>
Date: Mon, 08 Jan 2007 13:46:46 -0700
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA4907360@ssvlexmb2.amd.com>
	(Yinghai Lu's message of "Mon, 8 Jan 2007 09:16:32 -0800")
Message-ID: <m1wt3xgsax.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lu, Yinghai" <yinghai.lu@amd.com> writes:

>
>>I have tested this on an Nvidia board that reports that apic 0 pin 2
>>works when it does not and this code successfully programs apic 0 pin 0
>>into ExtINT mode.
>
> For some CK804 boards, BIOS forget set to 8254 timer to apic0/pin2, and
> still leave it at apic0/pin0. but mptable and acpi said 8254 timer is to
> apic0/pin2. At such case we should try apic0/pin0 with INT mode instead
> of ExtINT mode.

Duh.  I forgot Nvidia provided a register like that, now I am
beginning to understand what is wrong.  Anyway we do try apic0 pin0 by
default on the Nvidia's because of a Nvidia specific work around.

So that doesn't invalidate the generic test.  I'm going to go dig
out what little information I have and see if I can stair at the
register definition.

Anyway that doesn't invalidate anything in this patch. 

Eric
