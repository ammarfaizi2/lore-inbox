Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268253AbTB1VkT>; Fri, 28 Feb 2003 16:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268230AbTB1Vjt>; Fri, 28 Feb 2003 16:39:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:1157 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S268215AbTB1ViP>;
	Fri, 28 Feb 2003 16:38:15 -0500
Date: Fri, 28 Feb 2003 13:38:51 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 423] New: make -j X bzImage gives a warning
Message-ID: <362820000.1046468331@flay>
In-Reply-To: <20030228212504.GA21843@mars.ravnborg.org>
References: <347860000.1046465385@flay> <20030228212504.GA21843@mars.ravnborg.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Feb 28, 2003 at 12:49:45PM -0800, Martin J. Bligh wrote:
>> http://bugme.osdl.org/show_bug.cgi?id=423
>> 
>>            Summary: make -j X bzImage gives a warning
>>     Kernel Version: 2.5.63
>>             Status: NEW
>>           Severity: low	
>>              Owner: zippel@linux-m68k.org
> 
> Feel free to bug me with kbuild related issues.
> In this area Roman is 'only' taking care of kconfig & related issues AFAIK.
> 
>> make -j X bzImage gives a warning:
>> 
>> make[1]: warning: jobserver unavailable: using -j1.  Add `+' to parent make
>> rule.
>> 
>> Can we get rid of this one way or the other?
> 
> I have tried before - no luck.
> This one happens due to a $(Q)$(MAKE) used as part of a $(if
> construct in the top-level Makefile.
> See around line 335 - 345.
> It requires more than trivial changes to get rid of this one.

This bit?

define rule_vmlinux__
        set -e
        $(if $(filter .tmp_kallsyms%,$^),,
          echo '  Generating build number'
          . $(src)/scripts/mkversion > .tmp_version
          mv -f .tmp_version .version
          $(Q)$(MAKE) $(build)=init
        )
        $(call cmd,vmlinux__)
        echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
endef

Is it possible to define $(SINGLE_MAKE) or something as well as $(MAKE),
where it strips the -j, and use that in the instances where it can't
take a -j? Would be nice to get rid of that one last warning ... ;-)

M.

