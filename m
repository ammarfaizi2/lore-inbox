Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWDUVpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWDUVpj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWDUVpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:45:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32195 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964785AbWDUVpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:45:38 -0400
Date: Fri, 21 Apr 2006 14:48:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: hzhong@gmail.com, jmorris@namei.org, dwalker@mvista.com,
       linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Message-Id: <20060421144802.695a1fc9.akpm@osdl.org>
In-Reply-To: <20060421144233.1201cf07.akpm@osdl.org>
References: <4449486F.8020108@gmail.com>
	<20060421144233.1201cf07.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> #define __check_likely(expr, value)
> 	({
> 		static struct likeliness likeliness;
> 		do_check_likely(__FILE__, __LINE__, &likeliness, value);
> 	})
> 

#define __check_likely(expr, value)
	({
		static struct likeliness likeliness = {
			.file = __FILE__,
			.line = __LINE__,
		};
		do_check_likely(&likeliness, value);
	})

