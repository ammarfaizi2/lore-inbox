Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136087AbREBXEb>; Wed, 2 May 2001 19:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136073AbREBXEV>; Wed, 2 May 2001 19:04:21 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:12039 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136058AbREBXEG>;
	Wed, 2 May 2001 19:04:06 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Paul J Albrecht <pjalbrecht@home.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Debuggers, KDB or KGDB? 
In-Reply-To: Your message of "Wed, 02 May 2001 16:06:15 EST."
             <01050216532701.00700@CB57534-A> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 May 2001 09:03:55 +1000
Message-ID: <5003.988844635@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001 16:06:15 -0500, 
Paul J Albrecht <pjalbrecht@home.com> wrote:
>I'd like to know more about your plans to enhance KDB with source level debug
>capability.

Use a combination of gdb and kdb.  kdb to support kernel internals, gdb
to take the kdb output and add source level data.  It needs two
machines, one that is running to support gdb, the second machine is
being debugged, with a serial console between them.

The problem will be stopping gdb from making assumptions about the
machine being debugged.  Instead of changing gdb code, use a gdb
wrapper program to intercept user commands and gdb serial protocol and
convert them to kdb commands.

>Would you have to boot an unstripped kernel executable whenever you
>wanted to debug?

Boot, no.  But the machine running gdb will need an copy of the
unstripped vmlinux and module objects to get the debug information.

