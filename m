Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932847AbWF1PvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbWF1PvA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWF1PvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:51:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:53442 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932848AbWF1Pu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:50:59 -0400
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu_up not called for boot cpu
References: <8054.1151466063@kao2.melbourne.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 28 Jun 2006 17:50:57 +0200
In-Reply-To: <8054.1151466063@kao2.melbourne.sgi.com>
Message-ID: <p731wt9xori.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> writes:

> cpu_up() is only called for secondary cpus, not for the boot cpu.  That
> means that code hooked into the cpu_chain notifier never gets called
> for the boot cpu, which prevents additional subsystems from taking
> action for the boot cpu.  So how are additional subsystems meant to be
> initialised for the boot cpu?

They ought to initialize themselves for the already online cpus
when they start.

Any other way would make them lose CPUs if they were loaded
after the other CPUs are added.

-Andi
