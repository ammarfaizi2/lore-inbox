Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTCPH2w>; Sun, 16 Mar 2003 02:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262519AbTCPH2w>; Sun, 16 Mar 2003 02:28:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:26129 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262500AbTCPH2v>;
	Sun, 16 Mar 2003 02:28:51 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.64-1 
In-reply-to: Your message of "Mon, 10 Mar 2003 20:24:57 -0800."
             <20030311042457.GL465@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 Mar 2003 18:39:30 +1100
Message-ID: <15821.1047800370@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 20:24:57 -0800, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>Enable NUMA-Q's to run with more than 32 cpus by introducing a bitmap
>ADT and using it for cpu bitmasks on i386. Only good for up to 60 cpus;
>64x requires support for node-local cluster ID to physical node routes.
>diff -urpN linux-2.5.64/arch/i386/kernel/cpu/proc.c cpu-2.5.64-1/arch/i386/kernel/cpu/proc.c
>-	if (!(cpu_online_map & (1<<n)))
>+	if (!cpu_isset(n, cpu_online_map))
	if (!cpu_online(n))

Any main line code that explicitly refers to cpu_online_map is an
ongoing maintenance problem.  Nothing should refer to cpu_online_map
except the encapsulating macros such as cpu_online().

