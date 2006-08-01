Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWHAOeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWHAOeo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWHAOeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:34:44 -0400
Received: from mail.aknet.ru ([82.179.72.26]:4104 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S932075AbWHAOen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:34:43 -0400
Message-ID: <44CF672E.9080906@aknet.ru>
Date: Tue, 01 Aug 2006 18:37:34 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Beulich <jbeulich@novell.com>
Cc: Zachary Amsden <zach@vmware.com>, 76306.1226@compuserve.com,
       rohitseth@google.com, ak@muc.de, akpm@osdl.org,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net> <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru> <44CF755C.76E4.0078.0@novell.com>
In-Reply-To: <44CF755C.76E4.0078.0@novell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Jan Beulich wrote:
>> Well, someone used that macro in a .fixup section, where the
>> CFI adjustments do not seem to work. But since I don't know
>> why this was done (Jan?), I reverted that to my original code and
>> added the adjustments now.
> The macro in question is UNWIND_ESPFIX_STACK, which is used in exactly
No, that was about FIXUP_ESPFIX_STACK in fact.

> Even more, the macro itself switches to .fixup,
... where it uses FIXUP_ESPFIX_STACK. I haven't done that.
Someone else added the .fixup section to UNWIND_ESPFIX_STACK,
and so the FIXUP_ESPFIX_STACK became used in that section.
I removed that now with my patch, unless someone can tell
me why it was needed.

> Note
> that FIXUP_ESPFIX_STACK doesn't have any annotations, and hence can
> freely be used in .fixup.
Yes, but now the annotations had to be added, and so was the problem.

>> Hmm, I guess it wasn't correct also before, so I just
>> left it as is. Should now be fixed.
> I would think it was correct,
But why? FIXUP_ESPFIX_STACK doesn't pop up 20 bytes or something,
it just used to copy the entire stack frame from 16bit to 32bit
stack. It is much more than 20 bytes, but at the end, %ss:%esp
points to the very same data. So where exactly did 20 come from?
Well, historical interest mainly, as that code is going to die
when we agree on the patch, and the new code is much cleaner and
won't raise such a questions.

> but surely annotating these pieces of
> code wasn't something that anybody but the original author (you) should
> have done, as it wasn't too difficult to get lost.
When it was written, such an annotations were not needed yet, so
I couldn't do that.

