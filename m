Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932487AbWHHE5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbWHHE5M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWHHE5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:57:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:56030 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932487AbWHHE5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:57:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Us6xmMdCfBTmrUlEKfZVsOrYAaugAXu6HXB7FvAc8gbI/hEAidaY2BeLtKtFmSF3N9XgjwGF8qDwd9b5mMpa54aSVGvyFgw3CdCG+lfOrkSlm6kh7Zm+yeBrxtdmMELuLVaW65IqhqMSfEOSEeLU26720IAVK1jq5UyBhyPH5sw=
Message-ID: <aec7e5c30608072157m2f42efg4b8f6753a3509c28@mail.gmail.com>
Date: Tue, 8 Aug 2006 13:57:10 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Cc: Horms <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>,
       vgoyal@in.ibm.com, fastboot@osdl.org, linux-kernel@vger.kernel.org,
       "Jan Kratochvil" <lace@jankratochvil.net>,
       "Linda Wang" <lwang@redhat.com>
In-Reply-To: <44D813D7.3050004@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
	 <20060804225611.GG19244@in.ibm.com>
	 <m1k65onleq.fsf@ebiederm.dsl.xmission.com>
	 <20060808033405.GA6767@verge.net.au> <44D813D7.3050004@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, H. Peter Anvin <hpa@zytor.com> wrote:
> Horms wrote:
> >
> > I also agree that it is non-intitive. But I wonder if a cleaner
> > fix would be to remove CONFIG_PHYSICAL_START all together. Isn't
> > it just a work around for the kernel not being relocatable, or
> > are there uses for it that relocation can't replace?
> >
>
> Yes, booting with the 2^n existing bootloaders.
>
> Relocation, as far as I've understood this patch, refers to loaded
> address, not runtime address.

I believe Erics patch implements the following (correct me if I'm wrong):

vmlinux:
vmlinux is extended to contain relocation information. Absolute
symbols are used for non-relocatable symbols, and section-relative
symbols are used for relocatable symbols.

bzImage loader:
The bzImage loader code is no longer required to be loaded at a fixed
address. The bzImage file contains vmlinux relocation information and
the bzImage loader adjusts the relocations in vmlinux before executing
it.

So I would say that the runtime address of symbols in vmlinux are
changed by the bzImage loader. Or maybe I'm misunderstanding?

/ magnus
