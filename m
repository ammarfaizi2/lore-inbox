Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbRF2OVm>; Fri, 29 Jun 2001 10:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266095AbRF2OVc>; Fri, 29 Jun 2001 10:21:32 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:52743 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266093AbRF2OVQ>;
	Fri, 29 Jun 2001 10:21:16 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Fri, 29 Jun 2001 07:10:51 MST."
             <200106291410.HAA10170@baldur.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Jun 2001 00:21:09 +1000
Message-ID: <27582.993824469@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jun 2001 07:10:51 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	The Config.in files in linux-2.4.6-pre6 have at least 28 cases
>where a dep_bool or dep_tristate of the following form:
>	dep_bool CONFIG_SOMETHING $CONFIG_ARCH_somearch
>	I will put together patch to convert this to ugly but correct
>"if then; ... ; fi" statements later today if nobody has any better
>suggestions.

Create arch/Config.in which contains

  define_bool CONFIG_ARCH_i386 n
  define_bool CONFIG_ARCH_ia64 n
  define_bool CONFIG_ARCH_sparc n

etc., then change each of the arch/xxx/Config.in files to
source arch/Config.in as their first line first.  Still ugly but the
mainline configs will be much more readable.  It also guarantees that
any future tests on $CONFIG_ARCH_somearch will work, even if the code
does not use if statements.

