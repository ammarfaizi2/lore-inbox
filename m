Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbWHANhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbWHANhR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWHANhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:37:16 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:54971 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1161016AbWHANhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:37:15 -0400
Message-Id: <44CF755C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 01 Aug 2006 15:38:04 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Stas Sergeev" <stsp@aknet.ru>, "Zachary Amsden" <zach@vmware.com>
Cc: <76306.1226@compuserve.com>, <rohitseth@google.com>, <ak@muc.de>,
       <akpm@osdl.org>, "Linux kernel" <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net>
 <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru>
In-Reply-To: <44CF474C.9070800@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>      pushl %eax; \                     <----
>>> -    CFI_ADJUST_CFA_OFFSET 4; \
>>> +    lss (%esp), %esp;
>> <---- CFI adjustment here is missing.
>Well, someone used that macro in a .fixup section, where the
>CFI adjustments do not seem to work. But since I don't know
>why this was done (Jan?), I reverted that to my original code and
>added the adjustments now.

The macro in question is UNWIND_ESPFIX_STACK, which is used in exactly
one place (in normal .text). Even more, the macro itself switches to
.fixup,
so it would be rather odd if it was used in a .fixup section by itself.
Note
that FIXUP_ESPFIX_STACK doesn't have any annotations, and hence can
freely be used in .fixup.

>>>      FIXUP_ESPFIX_STACK        # %eax == %esp
>>> -    CFI_ADJUST_CFA_OFFSET -20    # the frame has now moved
>>> +    CFI_ADJUST_CFA_OFFSET -20
>> Is this CFI adjustment still correct?
>Hmm, I guess it wasn't correct also before, so I just
>left it as is. Should now be fixed. 

I would think it was correct, but surely annotating these pieces of
code
wasn't something that anybody but the original author (you) should
have
done, as it wasn't too difficult to get lost.

Jan
