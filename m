Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbTDCWyq 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 17:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263558AbTDCWyq 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 17:54:46 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64269 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261296AbTDCWyo 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 17:54:44 -0500
Date: Fri, 4 Apr 2003 00:06:08 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jes Sorensen <jes@wildopensource.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch 2.4] make tty->count atomic_t
Message-ID: <20030404000608.B18485@flint.arm.linux.org.uk>
Mail-Followup-To: Jes Sorensen <jes@wildopensource.com>,
	linux-kernel@vger.kernel.org, alan@redhat.com,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <16012.27749.781757.8312@trained-monkey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16012.27749.781757.8312@trained-monkey.org>; from jes@wildopensource.com on Thu, Apr 03, 2003 at 12:16:21PM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 03, 2003 at 12:16:21PM -0500, Jes Sorensen wrote:
> I believe the 2.4 tty code is racey in the way it handles tty->count.
> release_dev() does the tty->count-- thing without protecting against
> parallel execution, hence tty->count can end up a random state as
> tty->count-- isn't guaranteed to be atomic (load-store architectures and
> architectures with weak memory ordering etc).

Isn't release_dev() only called under the BKL, which guarantees the
old "single-thread in the kernel at a time" behaviour from pre-SMP
Linux ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

