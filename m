Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWGGXyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWGGXyy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWGGXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:54:54 -0400
Received: from terminus.zytor.com ([192.83.249.54]:56477 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751278AbWGGXyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:54:54 -0400
Message-ID: <44AEF43A.5020308@zytor.com>
Date: Fri, 07 Jul 2006 16:54:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Bob Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1 build error (YACC): followup
References: <20060707202442.DA2AFDBA1@gherkin.frus.com> <20060707223650.GB28811@mars.ravnborg.org>
In-Reply-To: <20060707223650.GB28811@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Jul 07, 2006 at 03:24:42PM -0500, Bob Tracy wrote:
>> I wrote:
>>> $YACC now seems to be undefined when I do a "make bzImage" and the
>>> build process gets to drivers/scsi/aic7xxx/aicasm (with the aic7xxx
>>> driver configured as a built-in).  As a workaround, it's possible to
>>> "cd" into the indicated directory and run "make" directly.  Once the
>>> default build completes, restarting "make bzImage" from the kernel
>>> source root continues as expected.
>> Found it.  The main "Makefile" has "MAKEFLAGS += -rR" uncommented as
>> of 2.6.18-rc1.  The deleted comment about "possibly random breakage"
>> that used to be just above that line pretty much says it all :-).
> I have now applied a patch where YACC= bison is dined in
> aicasm/Makefile.
> There are no other $(YACC) users in the kernel - the others specify bison
> direct.
> 

I propose the following as a global yacc rule; already used in usr/dash 
in the klibc tree, and which seems to work for both bison and BSD yacc:

quiet_cmd_yacc = YACC    $@
       cmd_yacc = $(YACC) -d -o $@ $<

$(obj)/%.c %(obj)/%.h: $(src)/%.y
         $(call cmd,yacc)


Note that bison seems to make smaller code than yacc, so I definiteily 
think we should default to bison over yacc.

	-hpa

