Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUFLLPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUFLLPf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 07:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264725AbUFLLPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 07:15:34 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62114 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264705AbUFLLPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 07:15:33 -0400
Date: Sat, 12 Jun 2004 12:10:16 +0100
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, herbert@gondor.apana.org.au,
       pavel@suse.cz, mochel@digitalimplant.org, linux-kernel@vger.kernel.org
Subject: Re: Fix memory leak in swsusp
Message-ID: <20040612111016.GA23441@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Nigel Cunningham <ncunningham@linuxmail.org>,
	herbert@gondor.apana.org.au, pavel@suse.cz,
	mochel@digitalimplant.org, linux-kernel@vger.kernel.org
References: <E1BYN8O-0008Vg-00@gondolin.me.apana.org.au> <20040610105629.GA367@gondor.apana.org.au> <20040610212448.GD6634@elf.ucw.cz> <20040610233707.GA4741@gondor.apana.org.au> <20040611094844.GC13834@elf.ucw.cz> <20040611101655.GA8208@gondor.apana.org.au> <20040611102327.GF13834@elf.ucw.cz> <20040611110314.GA8592@gondor.apana.org.au> <40CA75CA.2030209@linuxmail.org> <20040611210059.2522e02d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611210059.2522e02d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2004 at 09:00:59PM -0700, Andrew Morton wrote:
 > Nigel Cunningham <ncunningham@linuxmail.org> wrote:
 > >
 > >  We were avoiding the use of memcpy because it messes up the preempt count with 3DNow, and 
 > >  potentially as other unseen side effects. The preempt could possibly simply be reset at resume time, 
 > >  but the point remains.
 > 
 > eh?  memcpy just copies memory.  Maybe your meant copy_*_user()?

See arch/i386/lib/memcpy.c  The 3dnow routine does kernel_fpu_begin()/..end()
which futzes with preempt count.  What I'm missing though is that the count
afterwards should be the same as it was before the memcpy. Why is this
a problem for the suspend folks?

		Dave
