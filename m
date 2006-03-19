Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWCSR6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWCSR6D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 12:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbWCSR6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 12:58:03 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:49424 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751546AbWCSR6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 12:58:01 -0500
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 5 of 8] Add the __stack_chk_fail() function
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
	<1142612087.3033.110.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: ballast for RAM.
Date: Sun, 19 Mar 2006 17:57:55 +0000
In-Reply-To: <1142612087.3033.110.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "17 Mar 2006 16:20:17 -0000")
Message-ID: <878xr62u70.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Mar 2006, Arjan van de Ven wrote:
> GCC emits a call to a __stack_chk_fail() function when the cookie is not 
> matching the expected value. Since this is a bad security issue; lets panic
> the kernel

This turns even minor buffer overflows into complete denials of service.
If we're running in process context and the process is currently
killable it might make more sense to printk() a message and zap the
process; that way we only halt whatever service it is the attacker
hit us through.

(I agree that this is much-needed: I'm doing the rough equivalent in UML
right now, where it's a good bit simpler, but having it for the real
kernel on bare metal will be great!)

-- 
`Come now, you should know that whenever you plan the duration of your
 unplanned downtime, you should add in padding for random management
 freakouts.'
