Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWHaHsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWHaHsO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWHaHsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:48:14 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:10425 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751028AbWHaHsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:48:14 -0400
Message-Id: <44F6B082.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 31 Aug 2006 09:48:50 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
       "Badari Pulavarty" <pbadari@gmail.com>, <petkov@math.uni-muenster.de>,
       <akpm@osdl.org>, "lkml" <linux-kernel@vger.kernel.org>
Subject: Re: Was: boot failure, "DWARF2 unwinder stuck at 0xc0100199"
References: <20060820013121.GA18401@fieldses.org>
 <1156974410.16136.1.camel@dyn9047017100.beaverton.ibm.com>
 <44F6AD47.76E4.0078.0@novell.com> <200608310941.40076.ak@suse.de>
In-Reply-To: <200608310941.40076.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andi Kleen <ak@suse.de> 31.08.06 09:41 >>>
>On Thursday 31 August 2006 09:35, Jan Beulich wrote:
>> Andi submitted a fix for this to Linus, but that's post-rc5. Jan
>
>I assume you mean the fallback validation fix. Linus unfortunately
>didn't merge any of my new patches yet :/

Actually, the same patch, but other pieces of it ...

>But did you ever work out why the stack backtrace completely restarted? 
>I never got this. In theory the RSP gotten out of the unwind
>context and used for the fallback should have been already near the end
>and the old unwinder shouldn't have found much.

In the old (up to -rc5) code, we had

		if (unw_ret > 0 && !arch_unw_user_mode(&info)) {
			< all the fallback handling>
		}

with no else, thus just falling through (without even changing the
stack pointer, which was wrong when unw_ret > 0 but we reached
a user mode address (i.e. as in the example here, after unwinding
out of a syscall frame).

Jan
