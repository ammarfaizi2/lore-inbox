Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262303AbVCILOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbVCILOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 06:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVCILOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 06:14:18 -0500
Received: from one.firstfloor.org ([213.235.205.2]:65446 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262304AbVCILL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 06:11:28 -0500
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Badari Pulavarty <pbadari@us.ibm.com>,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: aio stress panic on 2.6.11-mm1
References: <20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com> <20050309110404.GA4088@in.ibm.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 09 Mar 2005 12:11:26 +0100
In-Reply-To: <20050309110404.GA4088@in.ibm.com> (Suparna Bhattacharya's
 message of "Wed, 9 Mar 2005 16:34:04 +0530")
Message-ID: <m1oedtvztt.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> Any sense of how costly it is to use spin_lock_irq's vs spin_lock
> (across different architectures) ? Isn't rwsem used very widely ?

On P4s cli/sti is quite costly, let's says 100+ cycles. That is mostly
because it synchronizes the CPU partly. The Intel tables say 26/36 cycles
latency, but in practice it seems to take longer because of the 
synchronization.

I would assume this is the worst case, everywhere else it should
be cheaper (except perhaps in some virtualized environments)
On P-M and AMD K7/K8 it is only a few cycles difference.

-Andi
