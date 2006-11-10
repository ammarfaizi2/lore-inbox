Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946118AbWKJJSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946118AbWKJJSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946139AbWKJJSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:18:41 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:2873 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946118AbWKJJSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:18:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=HXV667yxpbrcX6mNjvkM/DH45GgNf2JVpRBoelf6WuFFvrXnvV1xcmHQzCPb7oJRNE9ohhmx5ZZlI8A4Og1w+HbtRljnAoXvMpEfDHFcIqEIneLpl12cjvCT+9SPRK111/FGT0u9HpLH7h5ik9ChOY1H2naJyk4/rXtG/Twia+o=
Message-ID: <86802c440611100118s39613504q335914f01273fd30@mail.gmail.com>
Date: Fri, 10 Nov 2006 01:18:37 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Andi Kleen" <ak@muc.de>, yhlu <yinghailu@gmail.com>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Horms <horms@verge.net.au>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <2ea3fae10611092330q551127e0oad87775964fe7251@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49071D3@ssvlexmb2.amd.com>
	 <m164dnnaac.fsf@ebiederm.dsl.xmission.com>
	 <2ea3fae10611092330q551127e0oad87775964fe7251@mail.gmail.com>
X-Google-Sender-Auth: 1d7773fafe1ca462
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On 11/9/06, yhlu <yinghailu@gmail.com> wrote:
> the /proc/iomem doesn't show RAM above 1M.
>
> I have increased linuxbios table at high 0xf0000-0xf0400 to
> 0xf0000-0x100000. the RAM above 1M show up.
>

Can you explain more about the patch?

I wonder what we suppose to do about [640K, 1M).
In LinuxBIOS we only set [0xa0000, 0xc0000) and [0xf0000, 0xf0400) to reserved,
[0xc0000, 0xf0000) and [0xf0400, 4G) as ram..

with your patch, the 1M above range will not show up on /proc/iomem

YH

[PATCH] Don't force reserve the 640k-1MB range
>From i386 x86-64 inherited code to force reserve the 640k-1MB area.
That was needed on some old systems.

But we generally trust the e820 map to be correct on 64bit systems
and mark all areas that are not memory correctly.

This patch will allow to use the real memory in there.

Or rather the only way to find out if it's still needed is to
try. So far I'm optimistic.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=dbf9272e863bf4b17ee8e3c66c26682b2061d40d
