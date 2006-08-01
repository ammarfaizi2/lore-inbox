Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932668AbWHALgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932668AbWHALgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbWHALgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:36:50 -0400
Received: from [195.23.16.24] ([195.23.16.24]:57273 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932668AbWHALgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:36:49 -0400
Message-ID: <44CF3CCE.9010209@grupopie.com>
Date: Tue, 01 Aug 2006 12:36:46 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
Subject: Re: [PATCH 8/33] kallsyms.c: Generate relocatable symbols.
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <11544302331578-git-send-email-ebiederm@xmission.com>
In-Reply-To: <11544302331578-git-send-email-ebiederm@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Print the addresses of non-absolute symbols relative to _text
> so that ld will generate relocations.  Allowing a relocatable
> kernel to relocate them.  We can't actually use the symbol names
> because kallsyms includes static symbols that are not exported
> from their object files.
> 
> [...]
>  	output_label("kallsyms_addresses");
>  	for (i = 0; i < table_cnt; i++) {
> -		printf("\tPTR\t%#llx\n", table[i].addr);
> +		if (toupper(table[i].sym[0]) != 'A') {
> +			printf("\tPTR\t_text + %#llx\n",
> +				table[i].addr - _text);
> +		} else {
> +			printf("\tPTR\t%#llx\n", table[i].addr);
> +		}

Doesn't this break kallsyms for almost everyone?

kallsyms addresses aren't used just for displaying, but also to find 
symbols from their addresses (from the stack trace, etc.).

Am I missing something?

-- 
Paulo Marques - www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
