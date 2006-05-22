Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWEVOdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWEVOdo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWEVOdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:33:43 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:65259 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S1750858AbWEVOdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:33:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=AD5vX5rGBkCEyHiUTBUMVR23ReYrbe8S3+4OsXOr8CMXbXe0leb+bp0AfV/TWJgrd8u3jtbRoa12ZM3YwsX8BCxb63Z4lPjCI3aS2F05dBfItXsFRHMnucyPgIKzeZpnYhJ+oCO8USA+gc4cbye7yrDsNDSSbf3HSl4dpETTZI8=;
Date: Mon, 22 May 2006 18:32:54 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060522143254.GA28456@ms2.inr.ac.ru>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org> <1148220651.3902.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148220651.3902.24.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> any chance to get a coredump ?

Been there... ld-linux in glibc-2.3.2 is broken: it does not understand
relocatable VDSO. If vsyscall-sysenter.so is not absolute, which is
the case with exec-shield patch, it dereferences not-relocated pointers
in .dynamic and segfaults.

BTW original Gerd Hoffman's patch as submitted by Rusty works
with libc-2.3.2, it generates good absolute VDSO.

Alexey
