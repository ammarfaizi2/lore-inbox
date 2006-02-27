Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWB0BsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWB0BsT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWB0BsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:48:19 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:24268 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750739AbWB0BsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:48:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=cE6tEju8t4WKpffqN20ulXkxYj9HVDajE33/SWk7qXakggAEpHL0IGmQVRvHk2vqKpTXmfR97efCLF8ksYWUt4RX2M/e/xn+dVXWSAp21rHYIuToG2KkV5W9PP9YB1mvB5jk1IwBT6Zz28R71mnl6sAdZhFYgxNF7H9taURSb00=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060227002254.GA4393@dmt.cnet>
References: <5KvnZ-4uN-27@gated-at.bofh.it> <4401F5E3.3090003@shaw.ca>
	 <20060226215627.GB4979@dmt.cnet>
	 <1140987370.5178.9.camel@shogun.daga.dyndns.org>
	 <20060227002254.GA4393@dmt.cnet>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 17:48:15 -0800
Message-Id: <1141004895.17427.13.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 18:22 -0600, Marcelo Tosatti wrote:
> On Sun, Feb 26, 2006 at 12:56:10PM -0800, Chris Largret wrote:
> > $ readelf -S vmlinux
> > There are 52 section headers, starting at offset 0x2548488:
> 
> <snip>
> 
> >   [49] .shstrtab         STRTAB           0000000000000000  02548212
> >        0000000000000273  0000000000000000           0     0     1
> >   [50] .symtab           SYMTAB           0000000000000000  02549188
> >        00000000000b3898  0000000000000018          51   20791     8
> >   [51] .strtab           STRTAB           0000000000000000  025fca20
> >        0000000000096692  0000000000000000           0     0     1
> 
> More than 40MB, that should partially explain it...

Ouch. I hadn't noticed that and will have to see about bringing that
down a little. It's the same size when compiling without SMP, and the
OOM Killer doesn't cause problems then. There is something else that is
causing these problems.

>From using ls on the *.o files, it appears (as expected) that most of
this is the built-in drivers. The pruning should be fun. :)

--
Chris Largret <http://daga.dyndns.org>

