Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVDCQgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDCQgb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 12:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDCQga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 12:36:30 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:13759 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261236AbVDCQg2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 12:36:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=DnZo7Z6fIOV3/7y65nctJgwcKwODwYdjCTIPZwWLaDvchmsGcRbYnW8lPM3W8EAwW6OKl0fM+CRk6Lgf4XdZFH0x0cKTwp/8TeYu5xvZGm3+u20Rt7vCivkIkcsoOgyQLJorudjiXjL9pPTExFYsuLF9y/BYgeZSowUlSrEtz4M=
Message-ID: <9e47339105040309366013558d@mail.gmail.com>
Date: Sun, 3 Apr 2005 12:36:27 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: acme@ghostprotocols.net, Jon Smirl <jonsmirl@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, davem@davemloft.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: initramfs linus tree breakage in last day
In-Reply-To: <20050403155144.GD640@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e473391050401181824d9e50f@mail.gmail.com>
	 <9e47339105040119302e6bb405@mail.gmail.com>
	 <20050403155144.GD640@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 3, 2005 11:51 AM, Arnaldo Carvalho de Melo
<acme@ghostprotocols.net> wrote:
> Em Fri, Apr 01, 2005 at 10:30:42PM -0500, Jon Smirl escreveu:
> > This is what I see on boot.
> >
> > --
> > Jon Smirl
> > jonsmirl@gmail.com
> >
> > Linux version 2.6.12-rc1 (jonsmirl@jonsmirl.smirl.net) (gcc version
> > 3.4.2 200410
> > 17 (Red Hat 3.4.2-6.fc3)) #21 SMP Fri Apr 1 22:09:28 EST 2005
> > found SMP MP-table at 000fe710
> 
> OK, SMP, could you please try this patch by James Bottomley that fixes
> a brown paper bag bug in my proto_register patch?
> 
> Regards,
> 
> - Arnaldo
> 
> ===== net/core/sock.c 1.67 vs edited =====
> --- 1.67/net/core/sock.c        2005-03-26 17:04:35 -06:00
> +++ edited/net/core/sock.c      2005-04-02 13:37:20 -06:00
> @@ -1352,7 +1352,7 @@
> 
>  EXPORT_SYMBOL(sk_common_release);
> 
> -static rwlock_t proto_list_lock;
> +static DEFINE_RWLOCK(proto_list_lock);
>  static LIST_HEAD(proto_list);
> 
>  int proto_register(struct proto *prot, int alloc_slab)
> 

This patch fixes the boot problem. 

-- 
Jon Smirl
jonsmirl@gmail.com
