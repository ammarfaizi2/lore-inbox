Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966737AbWKOKM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966737AbWKOKM5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966738AbWKOKM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:12:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S966737AbWKOKM4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:12:56 -0500
Message-ID: <455AE7D7.4020002@redhat.com>
Date: Wed, 15 Nov 2006 10:11:35 +0000
From: Patrick Caulfield <pcaulfie@redhat.com>
Organization: Red Hat
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Steven Whitehouse <swhiteho@redhat.com>,
       teigland@redhat.com, linux-kernel@vger.kernel.org,
       cluster-devel@redhat.com
Subject: Re: [-mm patch] fix the DLM dependencies, part 2
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114183324.GL22565@stusta.de> <20061114225641.GP22565@stusta.de>
In-Reply-To: <20061114225641.GP22565@stusta.de>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Nov 14, 2006 at 07:33:24PM +0100, Adrian Bunk wrote:
>> On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>>> ...
>>> - A nasty Kconfig warning comes out during the build.  It's due to
>>>   git-gfs2-nmw.patch.
>>> ...
>> So let's fix it.  ;-)
>> ...
> 
> And let's also fix another bug...
> 
> 
> <--  snip  -->
> 
> 
> IPV6=m, DLM=m, DLM_SCTP=y mustn't result in IP_SCTP=y.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.19-rc5-mm2/fs/dlm/Kconfig.old	2006-11-14 22:25:01.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/fs/dlm/Kconfig	2006-11-14 22:25:19.000000000 +0100
> @@ -5,6 +5,7 @@ config DLM
>  	tristate "Distributed Lock Manager (DLM)"
>  	depends on IPV6 || IPV6=n
>  	select CONFIGFS_FS
> +	select IP_SCTP if DLM_SCTP
>  	help
>  	A general purpose distributed lock manager for kernel or userspace
>  	applications.
> @@ -23,7 +24,6 @@ config DLM_TCP
>  
>  config DLM_SCTP
>  	bool "SCTP"
> -	select IP_SCTP
>  
>  endchoice

Thanks Adrian. I need to read the kconfig docs a little more closely :)

Incidentally, I think the 'depends on IPV6 || IPV6=n' can go too; it's in a patch I sent to Steve and it's basically just a line
copied from SCTP which is obsoleted by these other changes and the addition of the TCP transport.

-- 

patrick
