Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753524AbWKNCmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753524AbWKNCmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 21:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755394AbWKNCmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 21:42:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15034 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753524AbWKNCmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 21:42:19 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 2/16] x86_64: Assembly safe page.h and pgtable.h
References: <20061113162135.GA17429@in.ibm.com>
	<200611131817.01066.ak@suse.de> <20061113211636.GC13832@in.ibm.com>
	<200611140246.28433.ak@suse.de>
Date: Mon, 13 Nov 2006 19:41:17 -0700
In-Reply-To: <200611140246.28433.ak@suse.de> (Andi Kleen's message of "Tue, 14
	Nov 2006 02:46:28 +0100")
Message-ID: <m1velin41e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> 
>> I think we need these UL suffixes. Otherwise in some cases overflow
>> can take place and compiler emits warning.
>> 
>> For ex. in following definition I got rid of UL.
>> 
>> #define PGDIR_SIZE      (1 << PGDIR_SHIFT) 
>
> Yes for the shifts it is needed, but not for the unshifted constants.
> I think. At least when they're hex the compiler should chose the right
> type on its own.

Only if the high bit is set.  But it should chose a big enough type.
However there is no reason to play games and possibly out smart ourselves.
That is the point of the _AC() macro.  It adds the suffix only for
C code, and drops it for assembly.

Eric
