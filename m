Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbUD2VAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbUD2VAn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbUD2U7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:59:18 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:3083 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263093AbUD2Uyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:54:49 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>,
       Mikael Pettersson <mikpe@user.it.uu.se>
Subject: Re: [PATCH][2.6.6-rc3] gcc-3.4.0 fixes
Date: Thu, 29 Apr 2004 23:54:37 +0300
User-Agent: KMail/1.5.4
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1PX8S-5z2-23@gated-at.bofh.it> <4090CB31.6090300@softhome.net>
In-Reply-To: <4090CB31.6090300@softhome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404292354.37091.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 April 2004 12:30, Ihar 'Philips' Filipau wrote:
> Mikael Pettersson wrote:
> > This patch fixes three warnings from gcc-3.4.0 in 2.6.6-rc3:
> > - drivers/char/ftape/: use of cast-as-lvalue
> >  		if (get_unaligned((__u32*)ptr)) {
> > -			++(__u32*)ptr;
> > +			ptr += sizeof(__u32);
> >  		} else {
>
>    Can anyone explain what is the problem with this?
>    To me it seems pretty ligitimate code - why it was outlawed in gcc 3.4?

cast is not a lvalue. ++(__u32*)ptr is nonsense, just like ++4.

>    Previous code was agnostic to type of ptr, but you code presume ptr
> being char pointer (to effectively increment by 4 bytes).

This would be agnostic too:

ptr = (void*) ((char*)ptr + sizeof(__u32));
--
vda

