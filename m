Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUBROts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbUBROtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:49:47 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:23510
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S264917AbUBROtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:49:45 -0500
Message-ID: <4033773C.7020804@tmr.com>
Date: Wed, 18 Feb 2004 09:31:24 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Davis <tadavis@lbl.gov>
CC: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix make rpm in 2.6 when using RH9 or Fedora..
References: <402BD507.2040201@lbl.gov> <402EE151.4000807@tmr.com> <403008C0.1070806@lbl.gov> <20040216210121.GD2977@mars.ravnborg.org> <4031950F.2040406@lbl.gov>
In-Reply-To: <4031950F.2040406@lbl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Davis wrote:
> Sam Ravnborg wrote:
> 
>>
>> Please forward the original patch to Andrew for inclusion.
>>
>>     Sam
> 
> 
> Andrew; Sam asked me to forward this to you for inclusion into the next 
> 2.6 kernel.
> 
> thanks!
> 
> Short description:
> 
> Doing a 'make rpm' with any linux-2.6 (or probably, even linux-2.4 
> kernel) will fail with the current RH9/Fedora RPM macros.
> 
> The failure message is this:
> 
> Processing files: kernel-debuginfo-2.6.3rc1mm1-12
> error: Could not open %files file 
> /usr/src/redhat/BUILD/kernel-2.6.3rc1mm1/debugfiles.list: No such file 
> or directory
> 
> 
> RPM build errors:
>   Could not open %files file 
> /usr/src/redhat/BUILD/kernel-2.6.3rc1mm1/debugfiles.list: No such file 
> or directory
> make: *** [rpm] Error 1
> 
> 
> The fix is this patch:
> 
> --- linux-2.6/scripts/mkspec    2004-01-08 22:59:04.000000000 -0800
> +++ linux-2.6.3-rc1-mm1/scripts/mkspec  2004-02-12 00:02:55.000000000 -0800
> @@ -37,6 +37,7 @@
> echo "BuildRoot: /var/tmp/%{name}-%{PACKAGE_VERSION}-root"
> echo "Provides: $PROVIDES"
> echo "%define __spec_install_post /usr/lib/rpm/brp-compress || :"
> +echo "%define debug_package %{nil}"
> echo ""
> echo "%description"
> echo "The Linux Kernel, the operating system core itself"

Am I missing something? Won't this completely break the creation of the 
debug rpm?

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
