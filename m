Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbWJXVix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbWJXVix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422637AbWJXViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:38:52 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:3632 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S1422634AbWJXViv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:38:51 -0400
Date: Tue, 24 Oct 2006 14:38:50 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Avi Kivity <avi@qumranet.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: kvm_create() (was Re: [PATCH 0/7] KVM: Kernel-based Virtual Machine)
Message-ID: <20061024213850.GA7529@hexapodia.org>
References: <4537818D.4060204@qumranet.com> <20061019173151.GD4957@rhun.haifa.ibm.com> <4537BD27.7050509@qumranet.com> <200610211816.27964.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211816.27964.arnd@arndb.de>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have much clue what the context of this is, but one chunk caught
my eye:

On Sat, Oct 21, 2006 at 06:16:27PM +0200, Arnd Bergmann wrote:
> Your example above could translate to something like:
> 
>    int kvm_fd = kvm_create("/kvm/my_vcpu")
>    int mem_fd = openat(kvm_fd, "mem", O_RDWR);

Based just on this snippet, it seems to me that kvm_create() could be
simply:
    open("/kvm/my_vcpu", O_CREAT | O_EXCL | O_DIRECTORY, 0777);

(Which currently seems to silently mask out O_DIRECTORY, but seems to me
should be a synonym for mkdir().)

-andy
