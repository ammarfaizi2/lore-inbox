Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbTJCRTF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:19:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbTJCRTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:19:05 -0400
Received: from khms.westfalen.de ([62.153.201.243]:4583 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S263661AbTJCRTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:19:02 -0400
Date: 03 Oct 2003 18:49:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8v8r7cxHw-B@khms.westfalen.de>
In-Reply-To: <fa.e2g5r6g.u3igb4@ifi.uio.no>
Subject: Re: [PATCH] linuxabi
X-Mailer: CrossPoint v3.12d.kh12 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <fa.ks78dgu.14g2fa8@ifi.uio.no> <m17k3nhfex.fsf@ebiederm.dsl.xmission.com> <fa.e2g5r6g.u3igb4@ifi.uio.no>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aebr@win.tue.nl (Andries Brouwer)  wrote on 02.10.03 in <fa.e2g5r6g.u3igb4@ifi.uio.no>:

> Now you come with comment #2: write LINUX_MS_RDONLY instead of
> MS_RDONLY. You have not convinced me.

The argument is fairly simple.

The main idea is that we expect glibc to use these includes to talk to the  
kernel, and that we expect glibc to at least in part do that by including  
these files from the glibc includes.

So this means userspace is bound to see these declarations.

So this means namespace cleanliness issues come up.

Also, we know that glibc likes to have an ABI that's different from the  
kernel ABI.

So we can't use the POSIX names for these things, or we'd create serious  
problems for glibc actually using this stuff.

Now, what namespace to use?

I think the rules here are clear: it MUST be part of the namespace  
reserved for language implementation, which is /^_[_A-Z][a-zA-Z_0-9]*$/.  
Also, it SHOULD be something we're fairly certain nobody else will be  
using.

There's one more thing here. Sometimes things change. We should consider  
having some sort of standard way of indicating a version in the name, AND  
WE SHOULD USE IT FROM THE FIRST VERSION ON, so that there's never a need  
to change the definition of a symbol, and there's never a need to invent a  
name like new_new_new_foo.

Let me repeat and slightly rephrase that point:

Symbols in the ABI includes should *NEVER* change their definition. Use  
new symbols for new definitions. Glibc should be able to rely on knowing  
that, say, _Linux_20_stat_t will always describe the stat_t to use on  
Linux 2.0 and compatible kernels.

Remember, these things describe an ABI. To be useful, there has to be a  
1:1 correspondence between names and ABI. It's glibc above and kernel  
below who actually do compatibility conversions, it's not the job of the  
ABI descriptions. (Except in the form of comments.)

MfG Kai
