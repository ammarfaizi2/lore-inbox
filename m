Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDJGt3>; Wed, 10 Apr 2002 02:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSDJGt2>; Wed, 10 Apr 2002 02:49:28 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:4586 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S312491AbSDJGt1>; Wed, 10 Apr 2002 02:49:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.5.8-pre3 breaks init, compile problem
Date: Wed, 10 Apr 2002 00:43:45 -0600
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02041000434505.00758@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init/main.o: In function `start_kernel':
init/main.o(.text.init+0x622): undefined reference to `setup_per_cpu_areas'
make: *** [vmlinux] Error 1

Reason?

Patch alters main.c to:

#ifndef CONFIG_SMP
...do some stuff (not including setup_per_cpu_areas)
#else

	#ifdef __GENERIC_PER_CPU
		define    setup_per_cpu_areas that does something
	#else
		define 	 setup_per_cpu_areas that doesn't do anything
	#endif
#endif

setup_per_cpu_areas(); in start_kernel is called and comes out undefined for 
my single processor - Athlon XP 1600+ 

