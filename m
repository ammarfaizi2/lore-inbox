Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWHVIx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWHVIx1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWHVIx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:53:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:44659 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932142AbWHVIx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:53:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lcVHmr58TgGyP0WTg98hojqAwOLjfTgQs2gkzCe5kJ9ff03PRnVl3UsePdzDl5Bsja+BD86jMwmajq9PFv08gHhx2m96Ixl4ezWMWgbXK6W6S9wxrQXfAj0xbVG7JCik2T4T19r6JNjZr/v7xt6+qWbel60w42AyhWtM0FeLeFc=
Message-ID: <aec7e5c30608220153h4553d890v3a3740e7fdc6986@mail.gmail.com>
Date: Tue, 22 Aug 2006 17:53:26 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH] x86_64: Reload CS when startup_64 is used.
Cc: "Andi Kleen" <ak@suse.de>, "Magnus Damm" <magnus@valinux.co.jp>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060821095328.3132.40575.sendpatchset@cherry.local>
	 <1156208306.21411.85.camel@localhost>
	 <m1u045sagu.fsf@ebiederm.dsl.xmission.com>
	 <200608221003.12608.ak@suse.de>
	 <m1y7thqi7b.fsf_-_@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 8/22/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> In long mode the %cs is largely a relic.  However there are a few cases
> like lret where it matters that we have a valid value.  Without this
> patch it is possible to enter the kernel in startup_64 without setting
> %cs to a valid value.  With this patch we don't care what %cs value
> we enter the kernel with, so long as the cs shadow register indicates
> it is a privileged code segment.
>
> Thanks to Magnus Damm for finding this problem and posting the
> first workable patch.  I have moved the jump to set %cs down a
> few instructions so we don't need to take an extra jump.  Which
> keeps the code simpler.
>
> Signed-of-by: Eric W. Biederman <ebiederm@xmission.com>

While at it, could you please fix up the purgatory code in kexec-tools
to include this fix so we can boot older versions of the kernel too?

Thanks,

/ magnus
