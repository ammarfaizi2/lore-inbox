Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUIVQnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUIVQnp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 12:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUIVQno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 12:43:44 -0400
Received: from relay.pair.com ([209.68.1.20]:58895 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S266245AbUIVQnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 12:43:42 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4151AB3D.3040003@kegel.com>
Date: Wed, 22 Sep 2004 09:41:33 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: arjanv@redhat.com
Subject: Re: 2.6.8 link failure for powerpc-970?
References: <414E93BC.4080107@kegel.com> <1095669339.2800.3.camel@laptop.fenrus.com> <4150EF69.1060007@kegel.com>
In-Reply-To: <4150EF69.1060007@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Kegel wrote:
>> On Mon, 2004-09-20 at 10:24, Dan Kegel wrote:
>>
>>> I'm trying to verify that I can build toolchains and compile
>>> and link kernels for a large set of CPU types using simple kernel 
>>> config files.
>>> I'm also somewhat foolishly trying to do all this with gcc-3.4.2.
>>> So any problems I run into are a bit hard to pin down to
>>> compiler, kernel, or user error, since this is mostly new territory 
>>> for me.  ...
> 
> arch/ppc64/kernel/built-in.o(.text+0xdc44): In function `.sys32_ipc':
> : undefined reference to `.compat_sys_shmctl'
 > ...

Could it be a config problem?  My config file was from 'allnoconfig', I think, and has
$ egrep 'SYSV|COMPAT' .config
CONFIG_COMPAT=y
# CONFIG_SYSVIPC is not set
compat_sys_shmctl is in ipc/compat.c, and is enabled by CONFIG_SYSVIPC_COMPAT,
which depends on CONFIG_SYSVIPC, which is off.

The reference to compat_sys_shmctl seems to be in
./arch/ia64/ia32/sys_ia32.c
./arch/ppc64/kernel/sys_ppc32.c
./arch/x86_64/ia32/ipc32.c
./arch/s390/kernel/compat_linux.c
and appears to not be conditioned on CONFIG_SYSVIPC_COMPAT.
Seems like linking problems are expected unless you turn on
CONFIG_SYSVIPC and CONFIG_SYSVIPC_COMPAT.

I turned 'em on and am trying again.
- Dan

-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
