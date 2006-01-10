Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932607AbWAJUpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932607AbWAJUpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932617AbWAJUpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:45:12 -0500
Received: from [195.23.16.24] ([195.23.16.24]:21124 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S932616AbWAJUpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:45:09 -0500
Message-ID: <43C41CCE.8070208@grupopie.com>
Date: Tue, 10 Jan 2006 20:45:02 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       tony.luck@intel.com, Systemtap <systemtap@sources.redhat.com>,
       Jim Keniston <jkenisto@us.ibm.com>, Keith Owens <kaos@sgi.com>
Subject: Re: [patch 1/2] [BUG]kallsyms_lookup_name should return the text
 addres
References: <20060110203912.007577046@csdlinux-2.jf.intel.com> <20060110204045.712982192@csdlinux-2.jf.intel.com>
In-Reply-To: <20060110204045.712982192@csdlinux-2.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anil S Keshavamurthy wrote:
> [...]
> The bug is kallsyms_lookup_name() -> module_kallsyms_lookup_name(mod, name)
> search the name in the given module and returns the address when
> name is matched. This address very well could be the address of 'U' type
> which is different address than 't' type.
> [...]

>  	for (i = 0; i < mod->num_symtab; i++)
> -		if (strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0)
> +		if ((strcmp(name, mod->strtab+mod->symtab[i].st_name) == 0) &&
> +			(mod->symtab[i].st_info == 't'))

This conflicts with a similar patch from Keith Owens earlier this week.

In his patch he did "mod->symtab[i].st_info != 'U'" instead of 
"mod->symtab[i].st_info == 't'".

I actually prefer Keith's version as it is the one which solves the bug 
by changing as least as possible the current behavior.

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?
