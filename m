Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWDLUYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWDLUYB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 16:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWDLUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 16:24:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:5099 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932205AbWDLUYA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 16:24:00 -0400
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Making percpu module variables have their own memory.
References: <1144869739.26133.74.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 12 Apr 2006 22:23:58 +0200
In-Reply-To: <1144869739.26133.74.camel@localhost.localdomain>
Message-ID: <p734q0y4k69.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

The basic optimization idea looks interesting. But your implementation
is quite complicated.  

The basic problem is that extern declarations and definitions
are the same macro. If they weren't one could just use a different
macro depending on if MODULE is defined or not and get rid
of the type comparisons you do.

Since you already need to change a lot of the per CPU definitions how
about you just define a separate macro for extern per cpu
declarations? And then change the basic macro to do the right
thing based on MODULE is set or not.

-Andi
