Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUHMTNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUHMTNF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUHMTNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:13:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:20915 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266820AbUHMTJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:09:39 -0400
X-Authenticated: #12437197
Date: Fri, 13 Aug 2004 22:09:53 +0300
From: Dan Aloni <da-x@colinux.org>
To: Sam Ravnborg <sam@ravnborg.org>, Benno <benjl@cse.unsw.edu.au>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] #2 (Generation of *.s files from *.S files in kbuild)
Message-ID: <20040813190953.GA14504@callisto.yi.org>
References: <20040812192535.GA20953@callisto.yi.org> <20040813003743.GF30576@cse.unsw.edu.au> <20040813050424.GA7417@mars.ravnborg.org> <20040813080941.GA7639@callisto.yi.org> <20040813092426.GA27895@callisto.yi.org> <20040813183347.GA9098@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040813183347.GA9098@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 08:33:47PM +0200, Sam Ravnborg wrote:
> On Fri, Aug 13, 2004 at 12:24:26PM +0300, Dan Aloni wrote:
> > diff -urN linux-2.6.7/scripts/Makefile.build linux-2.6.7-work/scripts/Makefile.build
> > --- linux-2.6.7/scripts/Makefile.build	2004-08-13 12:18:52.000000000 +0300
> > +++ linux-2.6.7-work/scripts/Makefile.build	2004-08-13 12:19:00.000000000 +0300
> > @@ -194,11 +194,11 @@
> >  $(real-objs-m)      : modkern_aflags := $(AFLAGS_MODULE)
> >  $(real-objs-m:.o=.s): modkern_aflags := $(AFLAGS_MODULE)
> >  
> > -quiet_cmd_as_s_S = CPP $(quiet_modtag) $@
> > -cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $< 
> > +quiet_cmd_as_lds_lds_S = CPP $(quiet_modtag) $@
> > +cmd_as_lds_lds_S       = $(CPP) $(a_flags)   -o $@ $< 
> >  
> > -%.s: %.S FORCE
> > -	$(call if_changed_dep,as_s_S)
> > +%.lds: %.lds.S FORCE
> > +	$(call if_changed_dep,as_lds_lds_S)
> 
> 
> This is not good.
> The .S -> .s is used for assembly.

Actually the only rule I saw that is being used for 
assembly is the .S -> .o rule (examples under 
arch/i386/kernel).
 
> An additional rule is needed:
> 
> Something like:
> quiet_cmd_cpp_lds_S    = LDS    $@
>       cmd_cpp_lds_S    = $(CPP) $(cpp_flags) -o $@ $<
> 
> %.lds: %.lds.S FORCE
> 	$(call if_changed_dep,cpp_lds_S)
>
> Adding a new rule it no longer are acceptable to misuse
> AFLAGS for this. So you have to add support for a new
> set of flags.
> Better name them with CPP so they can be used for other
> preprocessings tasks later if needed.
> 
> So in Makefile.lib you need to add cpp_flags like a_flags
> but using CPPFLAGS, EXTRA_CPPFLAGS, and CPPFLAGS_@
> 
> Try building a clean kernel after implementing this.

Okay, I'll send a patch when it's ready.

-- 
Dan Aloni
da-x@colinux.org
