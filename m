Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160997AbWHAOm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160997AbWHAOm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWHAOm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:42:59 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:18403 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1751347AbWHAOm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:42:58 -0400
Message-Id: <44CF84C4.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 01 Aug 2006 16:43:48 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Stas Sergeev" <stsp@aknet.ru>
Cc: <76306.1226@compuserve.com>, <rohitseth@google.com>, <ak@muc.de>,
       <akpm@osdl.org>, "Linux kernel" <linux-kernel@vger.kernel.org>,
       "Zachary Amsden" <zach@vmware.com>
Subject: Re: + espfix-code-cleanup.patch added to -mm tree
References: <200607300016.k6U0GYu4023664@shell0.pdx.osdl.net>
 <44CE766D.6000705@vmware.com> <44CF474C.9070800@aknet.ru>
 <44CF755C.76E4.0078.0@novell.com> <44CF672E.9080906@aknet.ru>
In-Reply-To: <44CF672E.9080906@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Well, someone used that macro in a .fixup section, where the
>>> CFI adjustments do not seem to work. But since I don't know
>>> why this was done (Jan?), I reverted that to my original code and
>>> added the adjustments now.
>> The macro in question is UNWIND_ESPFIX_STACK, which is used in
exactly
>No, that was about FIXUP_ESPFIX_STACK in fact.
>
>> Even more, the macro itself switches to .fixup,
>... where it uses FIXUP_ESPFIX_STACK. I haven't done that.
>Someone else added the .fixup section to UNWIND_ESPFIX_STACK,
>and so the FIXUP_ESPFIX_STACK became used in that section.
>I removed that now with my patch, unless someone can tell
>me why it was needed.

That was me, in order to get the unwind annotations right without
complicating the code too much. Again, FIXUP_ESPFIX_STACK doesn't
use any unwind directives so can be used anywhere, including the
.fixup section UNWIND_ESPFIX_STACK switches to.

Jan
