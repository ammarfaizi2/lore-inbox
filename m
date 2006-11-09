Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424265AbWKIXlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424265AbWKIXlE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424263AbWKIXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:58 -0500
Received: from gw.goop.org ([64.81.55.164]:36307 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161869AbWKIXjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:11 -0500
Message-ID: <4553BC18.6090207@goop.org>
Date: Thu, 09 Nov 2006 15:39:04 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH] KVM: Avoid using vmx instruction directly
References: <20061109110852.A6B712500F7@cleopatra.q> <200611091429.42040.arnd@arndb.de> <45532EE3.4000104@qumranet.com> <200611091542.31101.arnd@arndb.de> <455340B8.2080206@qumranet.com>
In-Reply-To: <455340B8.2080206@qumranet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
>> Or gcc
>> might move the assignment of phys_addr to after the inline assembly.
>>   
> "asm volatile" prevents that (and I'm not 100% sure it's necessary).

No, it won't necessarily.  "asm volatile" simply forces gcc to emit the
assembler, even if it thinks its output doesn't get used.  It makes no
ordering guarantees with respect to other code (or even other "asm
volatiles").   The "memory" clobbers should fix the ordering of the asms
though.


    J
