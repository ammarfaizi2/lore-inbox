Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932353AbWEUSfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWEUSfP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWEUSfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:35:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:17607 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932353AbWEUSfO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:35:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q1mtNETxYpS+3uEg08b2a4kiiiMZjrl0xamVk2i1rWQJTPAp0/vnCHdQ4bgeS4jEUdxAbPIJQzyOveRGjwJLD41CdclbxNK20l7ZAHSKNW4uKYRqSnUWrKsKSgZ84WbR6to5mLiynIHLKL39QYoQmVI89GIIoKOThO2fcL50X1U=
Message-ID: <a36005b50605211135v2d55827fr96360d9a025b9db8@mail.gmail.com>
Date: Sun, 21 May 2006 11:35:12 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Chris Wedgwood" <cw@f00f.org>,
       dragoran <dragoran@feuerpokemon.de>, linux-kernel@vger.kernel.org
Subject: Re: IA32 syscall 311 not implemented on x86_64
In-Reply-To: <20060521160332.GA8250@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <44702650.30507@feuerpokemon.de>
	 <20060521085015.GB2535@taniwha.stupidest.org>
	 <20060521160332.GA8250@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/06, Dave Jones <davej@redhat.com> wrote:
> It's a glibc problem really.

It's not a glibc problem really.  The problem is this stupid error
message in the kernel.  We rely in many dozens of places on the kernel
returning ENOSYS in case a syscall is not implemented and we deal with
it appropriately.  There is absolutely no justification to print these
messages except perhaps in debug kernels.  IMO the sys32_ni_syscall
functions should just return ENOSYS unless you select a special debug
kernel.  One doesn't need the kernel to detect missing syscall
implementations, strace can do this as well.
