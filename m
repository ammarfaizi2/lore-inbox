Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWGYHdN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWGYHdN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 03:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWGYHdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 03:33:13 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:38175 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751232AbWGYHdM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 03:33:12 -0400
Date: Tue, 25 Jul 2006 09:32:08 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725073208.GA10601@suse.de>
References: <Pine.LNX.4.64.0607171605500.6761@scrub.home> <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com> <Pine.LNX.4.64.0607171718140.6762@scrub.home> <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com> <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com> <Pine.LNX.4.64.0607171902310.6762@scrub.home> <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com> <f96157c40607180238s1bfe0ca2te1d4d72dbe8626fd@mail.gmail.com> <f96157c40607190326t1071377bvb426e00d6f427660@mail.gmail.com> <f96157c40607240834i5ba3ca5cma51eec9fa34558bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607240834i5ba3ca5cma51eec9fa34558bc@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24 2006, gmu 2k6 wrote:
> the problem I have with hangs is related to changes in CFQ and that
> CFQ is now the default. 2.6.17-git12 had the problem but booting
> it with elevator=deadline fixes the hang.
> 
> symptoms encountered during git-bisecting between v2.6.17 and v2.6.18-rc1:
> A hang while starting network services
> B hang while trying to login
>   1 on remote console [not SSH] it hang after typing <uid><CR>
>   1 via OpenSSH it hang after typing <pwd><CR> when doing slogin root@<IP>
> 
> A is the problem I got in the first place and this seems to be the
> case since 2.6.17-git11 definitely although git-bisect pointed me at
> the following
> changeset which is included since 2.6.17-git12:
> 
> caaa5f9f0a75d1dc5e812e69afdbb8720e077fd3
> by Jens Axboe
> titled "[PATCH] cfq-iosched: many performance fixes"
> 
> strange enough it also hangs with 2.6.17-git11 which did not include that
> one changeset yet.

So perhaps your bisect isn't 100% trust worthy? Can you do a manual
-gitX bisect to see which 2.6.17-gitX introduced the problem?

Also please put a serial console or similar on the machine, so you can
log + store the sysrq+t output.

-- 
Jens Axboe

