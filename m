Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263558AbTDCXHG 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 18:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263562AbTDCXHG 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 18:07:06 -0500
Received: from trained-monkey.org ([209.217.122.11]:5645 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id S263558AbTDCXHD 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 18:07:03 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch 2.4] make tty->count atomic_t
References: <16012.27749.781757.8312@trained-monkey.org>
	<20030404000608.B18485@flint.arm.linux.org.uk>
From: Jes Sorensen <jes@wildopensource.com>
Date: 03 Apr 2003 18:18:22 -0500
In-Reply-To: <20030404000608.B18485@flint.arm.linux.org.uk>
Message-ID: <m3of3ndvb5.fsf@trained-monkey.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

Russell> On Thu, Apr 03, 2003 at 12:16:21PM -0500, Jes Sorensen wrote:
>> I believe the 2.4 tty code is racey in the way it handles
>> tty->count.  release_dev() does the tty->count-- thing without
>> protecting against parallel execution, hence tty->count can end up
>> a random state as
tty-> count-- isn't guaranteed to be atomic (load-store architectures
tty-> and
>> architectures with weak memory ordering etc).

Russell> Isn't release_dev() only called under the BKL, which
Russell> guarantees the old "single-thread in the kernel at a time"
Russell> behaviour from pre-SMP Linux ?

It's called from tty_release() and tty_open(). tty_release() grabs the
BKL but I don't see the path that grabs it when calling through
tty_open() (doesn't mean I am not blind of course ;-).

cheers,
Jes
