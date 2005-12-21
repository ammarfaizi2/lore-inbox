Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbVLUTfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbVLUTfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbVLUTfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:35:23 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:28451 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751194AbVLUTfX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:35:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ArRlvBwymUevRdHaFYwdVFs2Ik7kyz0ZEOYOw+taBBETcjH35HVr+JIh0HmaNkPgZKpyFiBj+0HCMni20eHPgfnmUjvNtuyekj0DQ8E0NT057LXrkdn1+KgFnzoV/aP68cNJ4aOdcBiE2mzy9+DWrcUK5AphuyJd7tNWZ+UT2I8=
Message-ID: <9a8748490512211135lb2248bdm7c0c7e9a71398bbc@mail.gmail.com>
Date: Wed, 21 Dec 2005 20:35:22 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: ip_output.c change question
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0512212021140.12159@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0512212021140.12159@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> Hello,
>
>
> what was the reason to remove the EXPORT_SYMBOL(sysctl_ip_default_ttl) in
> http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.16.git;a=blobdiff;h=c934f5316c3bc1362e85029f3978448501028b96;hp=766564cb420760d0d715d75851a8e49496eeaf6b;hb=0742fd53a3774781255bd1e471e7aa2e4a82d5f7;f=net/ipv4/ip_output.c
> ? ipt_TARPIT uses this variable and relies on it being available.
>

I don't know, but a little digging in the git repository found a little info :

The commit :
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0742fd53a3774781255bd1e471e7aa2e4a82d5f7

Contained this exlanation :

This patch contains the following possible cleanups:
- make needlessly global code static
- #if 0 the following unused global function:
  - xfrm4_state.c: xfrm4_state_fini
- remove the following unneeded EXPORT_SYMBOL's:
  - ip_output.c: ip_finish_output
  - ip_output.c: sysctl_ip_default_ttl
  - fib_frontend.c: ip_dev_find
  - inetpeer.c: inet_peer_idlock
  - ip_options.c: ip_options_compile
  - ip_options.c: ip_options_undo
  - net/core/request_sock.c: sysctl_max_syn_backlog

[Adding Adrian Bunk and David Miller to Cc as they both signed off on
the patch, maybe they can explain]


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
