Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281425AbRKMBdm>; Mon, 12 Nov 2001 20:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281433AbRKMBdd>; Mon, 12 Nov 2001 20:33:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52217
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281428AbRKMBd0>; Mon, 12 Nov 2001 20:33:26 -0500
Date: Mon, 12 Nov 2001 17:33:18 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.15-pre4 compile error
Message-ID: <20011112173318.H32099@mikef-linux.matchmail.com>
Mail-Followup-To: Louis Garcia <louisg00@bellsouth.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1005614871.24361.0.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005614871.24361.0.camel@tiger>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 08:27:51PM -0500, Louis Garcia wrote:
> 
> setup.c: In funtion 'c_start':
> setup.c:2791: subscripted value is neither array nor pointer
> setup.c:2792: warning: control reaches end of non-void function
> make[1]: *** [setup.o] Error 1
> 

This patch, (from RML) will fix it.

It's already been posted...

diff -u linux-2.4.15-pre4/include/asm-i386/processor.h linux/include/asm-i386/processor.h 
--- linux-2.4.15-pre4/include/asm-i386/processor.h	Mon Nov 12 15:17:47 2001+++ linux/include/asm-i386/processor.h	Mon Nov 12 15:40:32 2001
@@ -76,7 +76,7 @@
 extern struct cpuinfo_x86 cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #else
-#define cpu_data &boot_cpu_data
+#define cpu_data (&boot_cpu_data)
 #define current_cpu_data boot_cpu_data
 #endif
 
	Robert Love
