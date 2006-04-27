Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWD0HKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWD0HKc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWD0HKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:10:32 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:43946 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750754AbWD0HKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:10:31 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Simple header cleanups
Date: Thu, 27 Apr 2006 10:10:06 +0300
User-Agent: KMail/1.8.2
Cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <1146104023.2885.15.camel@hades.cambridge.redhat.com> <1146107871.2885.60.camel@hades.cambridge.redhat.com> <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604262028130.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271010.06711.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 April 2006 06:31, Linus Torvalds wrote:
> 
> On Thu, 27 Apr 2006, David Woodhouse wrote:
> > 
> > Agreed. And distributions and library maintainers _will_ fix them. Are
> > we to deny those people the tools which will help them to keep track of
> > our breakage and submit patches to fix it?
> 
> No. As mentioned, as long as the target audience is distributions and 
> library maintainers, I definitely think we should do help them as much as 
> possible. Our problems have historically been "random people" who have 
> /usr/include/linux being the symlink to "kernel source of the day", which 
> is an unsupportable situation.

Maybe we should have a script which processes kernel's include/linux/*
files and produces sanitized set of headers (by deleting
"#ifdef __KERNEL__" blocks, etc), which will be treated at
*the* official kernel<->userspace API and will be used by glibc etc?

Such "kernel header sanitizator" script is to be maintained
and distributed as part of kernel tree.

glibc people will then know where to look/what part of kernel to patch
if they will stumble on incorrect sanitized header. I.e., they will need
to either fix original kernel header so that translation of it becomes ok
(for example, a missing #ifdef __KERNEL) or by modifying
sanitizator script.
--
vda
