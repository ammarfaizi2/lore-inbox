Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWGKPDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWGKPDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 11:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWGKPDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 11:03:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:45718 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750965AbWGKPDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 11:03:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IWK8Zz9qoCXBXkZv1P763HrVxT9xjJVHp5V1H54MGDQt5xiNokFjio37HCcBZnhFtnH3mBfOfrJtJC8NXQd1hxkQQ9FPlM8/eezV4YD/mdi45z/wYr47p5yQi8d0lIJ1oLrBPs4kTBDyVU2Xttd7JSn2NIOllcVRlGRXTBgJpYg=
Message-ID: <6bffcb0e0607110802w4f423854rb340227331084596@mail.gmail.com>
Date: Tue, 11 Jul 2006 17:02:59 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <b0943d9e0607110556v50185b9i5443dabedba46152@mail.gmail.com>
	 <6bffcb0e0607110617g36f7123dm2b5f0e88b10cbcaa@mail.gmail.com>
	 <b0943d9e0607110628w60a436f7t449714eb4a3200ca@mail.gmail.com>
	 <6bffcb0e0607110649s464840a9sf04c7537809436b1@mail.gmail.com>
	 <b0943d9e0607110702p60f5bf3fg910304bfe06ec168@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> On 11/07/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> > System hangs when I try "cat /sys/kernel/debug/memleak". Here is what
> > I found in a log file.
>
> Can you disable DEBUG_MEMLEAK_ORPHAN_FREEING? That's mainly used for
> debugging but I don't think it is was causing the hang. I haven't
> changed the locking mechanism since version 0.7 but maybe some other
> bug made its way in.

It is DEBUG_MEMLEAK_ORPHAN_FREEING issue. Disabling it solved the problem.

orphan pointer 0xc6113bec (size 28):
  c017392a: <__kmalloc_track_caller>
  c01631b1: <__kzalloc>
  c010b7d7: <legacy_init_iomem_resources>
  c010b89c: <request_standard_resources>
  c0100b8b: <do_initcalls>
  c0100c3d: <do_basic_setup>
  c0100cdb: <init>

This is most common
orphan pointer 0xf5a6fd60 (size 39):
  c0173822: <__kmalloc>
  c01df500: <context_struct_to_string>
  c01df679: <security_sid_to_context>
  c01d7eee: <selinux_socket_getpeersec_dgram>
  f884f019: <unix_get_peersec_dgram>
  f8850698: <unix_dgram_sendmsg>
  c02a88c2: <sock_sendmsg>
  c02a9c7a: <sys_sendto>

cat /tmp/ml.txt | grep -c selinux_socket_getpeersec_dgram
8442

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
