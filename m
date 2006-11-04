Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965613AbWKDUCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965613AbWKDUCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965614AbWKDUCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:02:25 -0500
Received: from mx1.suse.de ([195.135.220.2]:53153 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965613AbWKDUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:02:24 -0500
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [patch] i386: remove IOPL check on task switch
Date: Sat, 4 Nov 2006 21:02:12 +0100
User-Agent: KMail/1.9.5
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200611031900_MC3-1-D041-6F32@compuserve.com> <454CE7D9.3070308@vmware.com> <454CEC5C.2050507@vmware.com>
In-Reply-To: <454CEC5C.2050507@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042102.13026.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Ok, checking shows Linus put it back to stop NT leakage. 

It is also needed to stop AC leakage

> This is  
> correct, but unlikely.  Would be nice to avoid it unless absolutely 
> necessary.  Perhaps xor eflags old and new and only set_system_eflags() 
> if non-ALU bits have changed.

If it's worth it...

If it's worth for the context switch i think it would make 
more sense to do it for the normal restore_flags() etc. which are much
more common (and could be actually handled in most cases with test + jump + sti)

-Andi
