Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbRGBCtM>; Sun, 1 Jul 2001 22:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266032AbRGBCtC>; Sun, 1 Jul 2001 22:49:02 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39692 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S265797AbRGBCsy>; Sun, 1 Jul 2001 22:48:54 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: rhw@MemAlpha.CX, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Re: 2.4.6p6: dep_{bool,tristate} $CONFIG_ARCH_xxx bugs 
In-Reply-To: Your message of "Sun, 01 Jul 2001 19:25:11 MST."
             <200107020225.TAA02230@adam.yggdrasil.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 12:48:26 +1000
Message-ID: <22864.994042106@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Jul 2001 19:25:11 -0700, 
"Adam J. Richter" <adam@yggdrasil.com> wrote:
>	Does anyone know if there is any code that would break if
>we put quotation marks around the $CONFIG_xxxx references in the
>dep_xxx commands in all of the Config.in files?

That has the same problem that AC was worried about.  Variables that
used to be treated as "undefined, don't care" are now treated as
"undefined, assume n and forbid".

As long as there is any ambiguity about how a rule is meant to treat
undefined variables, treating all undefined variables as 'n' is not
safe.  Before making a global change like this, first verify that no
rule treats undefined variables as "don't care".  Otherwise something
will break.

