Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262881AbUB0Nt6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbUB0Nt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:49:58 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:63118 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262886AbUB0Ntv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:49:51 -0500
Message-ID: <403F4AFD.8060909@acm.org>
Date: Fri, 27 Feb 2004 07:49:49 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030428
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IPMI driver updates, part 3
References: <20040226225419.20A032C360@lists.samba.org>
In-Reply-To: <20040226225419.20A032C360@lists.samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, I see that this is much better.  I'll work on renaming all these 
and switching to module_param, for the 2.6 version.

Thanks,

-Corey

Rusty Russell wrote:

>In message <403A242A.6000802@acm.org> you write:
>  
>
>>+  insmod ipmi_smb_intf.o
>>+	smb_addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
>>+	smb_dbg=<flags1>,<flags2>...
>>+	[smb_defaultprobe=0] [smb_dbg_probe=1]
>>    
>>
>
>Please use "modprobe" not "insmod" in examples, and drop the ".o"
>extension.
>
>  
>
>>+When compiled into the kernel, the addresses can be specified on the
>>+kernel command line as:
>>+
>>+  ipmi_smb=[<adapter1>.]<addr1>[:<debug1>],[<adapter2>.<addr2>[:<debug1>]....
>>    
>>
>
>I realize this is traditional.  However, I suggest you:
>1) Rename the module to impi_smb.
>2) Change the variable names to addr, debug, debug_probe and
>   default_probe.
>3) Change MODULE_PARM to module_param
>4) Get rid of the #ifndef MODULE code.
>
>The results will be symmetry, and less code:
>
>	modprobe ipmi_smb addr=<adapter1>,<i2caddr1>[,<adapter2>,<i2caddr2>[,...]]
>		debug=<flags1>,<flags2>...
>		default_probe=0 debug_probe=1
>
>and
>
>	boot ipmi_smb.addr=... ipmi_smb.debug=... ipmi.default_probe=0 ipmi.debug_probe=1
>
>Of course, if you really want to you can use module_param_named and
>keep the variable names the same as they are now, and "#undef
>KBUILD_MODNAME // #define KBUILD_MODNAME ipmi_smb", to avoid renaming
>your module.
>
>But I really think the module name wants a revisit (although I have no
>idea what it does, so might be wrong).
>
>Cheers!
>Rusty.
>--
>  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>  
>


