Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262223AbVAKTle@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262223AbVAKTle (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVAKTlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:41:24 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:34614 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262383AbVAKTkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:40:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=eAkuc8EFn1cNE/Q8SwyIz/cUsNgQlTQOjPVn799jVMDFVFxA82Yl+JLDhPDNaVwuV2p8kl8ZYfkKVcIH+4z6Njqj3qeXOtp0QIxQ+GaSz7OOx6Hn8sUFnnO8Ma/eYVwcZsq242L7Jdu+ZjwzCvSIeeCpJJ7vzpVQIi8tMNTNiuk=
Message-ID: <8746466a0501111140194fbc7f@mail.gmail.com>
Date: Tue, 11 Jan 2005 12:40:31 -0700
From: Dave <dave.jiang@gmail.com>
Reply-To: Dave <dave.jiang@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: clean way to support >32bit addr on 32bit CPU
Cc: linux-kernel@vger.kernel.org, smaurer@teja.com, linux@arm.linux.org.uk,
       dsaxena@plexity.net, drew.moseley@intel.com
In-Reply-To: <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <8746466a050110153479954fd2@mail.gmail.com>
	 <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005 16:09:57 -0800 (PST), Linus Torvalds
<torvalds@osdl.org> wrote:
> 
> 
> On Mon, 10 Jan 2005, Dave wrote:
> >
> > After all said and done, the struct resource members start and end
> > must support 64bit integer values in order to work. On a 64bit arch
> > that would be fine since unsigned long is 64bit. However on a 32bit
> > arch one must use unsigned long long to get 64bit.
> 
> We really should make "struct resource" use u64's. It's wrong even on x86,
> but we've never seen any real problems in practice, so we've had little
> reason to bother.
> 
> This has definitely come up before, maybe there's even some old patch
> floating around. It should be as easy as just fixing up "start/end" to be
> "u64" (and perhaps move them to the beginning of the struct to make sure
> packing is ok on all architectures), and fixing any fall-out.
> 
>                 Linus
> 

Shall I change the PCI resource stuff also to be u64 or leave that
alone?  Currently I think we assume on 32bit processors all PCI
resources are in the first 4GB region. Just wondering if that should
be left alone....

-- 
-= Dave =-

Software Engineer - Advanced Development Engineering Team 
Storage Component Division - Intel Corp. 
mailto://dave.jiang @ intel
http://sourceforge.net/projects/xscaleiop/
----
The views expressed in this email are
mine alone and do not necessarily 
reflect the views of my employer
(Intel Corp.).
