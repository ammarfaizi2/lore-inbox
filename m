Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWHAWKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWHAWKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 18:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWHAWKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 18:10:21 -0400
Received: from gw.goop.org ([64.81.55.164]:33695 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751247AbWHAWKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 18:10:20 -0400
Message-ID: <44CFD148.9020300@goop.org>
Date: Tue, 01 Aug 2006 15:10:16 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 11/33] i386 boot: Add an ELF header to bzImage
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <1154430236812-git-send-email-ebiederm@xmission.com>
In-Reply-To: <1154430236812-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> +.macro note name, type
> +	.balign 4
> +	.int	2f - 1f			# n_namesz
> +	.int	4f - 3f			# n_descsz
> +	.int	\type			# n_type
> +	.balign 4
> +1:	.asciz "\name"
> +2:	.balign 4
> +3:
> +.endm
> +.macro enote
> +4:	.balign 4
> +.endm
>   

This is very similar to the macro I introduced in the Paravirt note 
segment patch.  Do think they should be made common?

> +/* Elf notes to help bootloaders identify what program they are booting.
> + */
> +
> +/* Standardized Elf image notes for booting... The name for all of these is ELFBoot */
> +#define ELF_NOTE_BOOT		"ELFBoot"
>   

I wonder if this should be something to suggest its Linux-specific?  Or 
do you see this being used by a wider audience?

    J
