Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318288AbSHPKCJ>; Fri, 16 Aug 2002 06:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSHPKCJ>; Fri, 16 Aug 2002 06:02:09 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:57096 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S318288AbSHPKCI>; Fri, 16 Aug 2002 06:02:08 -0400
Message-Id: <200208161001.g7GA1mp24413@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reduce stack usage of sanitize_e820_map
Date: Fri, 16 Aug 2002 12:58:38 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020815174825.F29874@redhat.com>
In-Reply-To: <20020815174825.F29874@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 August 2002 19:48, Benjamin LaHaise wrote:
> Hello,
>
> Currently, sanitize_e820_map uses 0x738 bytes of stack.  The patch below
> moves the arrays into __initdata, reducing stack usage to 0x34 bytes.

Is that a real problem? sanitize_e820_map will be called just once at init
time...

> +struct change_member change_point_list[2*E820MAX] __initdata;
> +struct change_member *change_point[2*E820MAX] __initdata;
> +struct e820entry *overlap_list[E820MAX] __initdata;
> +struct e820entry new_bios[E820MAX] __initdata;

Does this enlarge on-disk kernel image?
Shouldn't they be static?

>  static int __init sanitize_e820_map(struct e820entry * biosmap, char *
> pnr_map) {
> -	struct change_member {
> -		struct e820entry *pbios; /* pointer to original bios entry */
> -		unsigned long long addr; /* address for this change point */
> -	};
> -	struct change_member change_point_list[2*E820MAX];
> -	struct change_member *change_point[2*E820MAX];
> -	struct e820entry *overlap_list[E820MAX];
> -	struct e820entry new_bios[E820MAX];
>  	struct change_member *change_tmp;
>  	unsigned long current_type, last_type;
>  	unsigned long long last_addr;

--
vda
