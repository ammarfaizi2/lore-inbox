Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312859AbSDJLjc>; Wed, 10 Apr 2002 07:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312834AbSDJLjc>; Wed, 10 Apr 2002 07:39:32 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:52376 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S312610AbSDJLja>; Wed, 10 Apr 2002 07:39:30 -0400
Date: Wed, 10 Apr 2002 13:39:27 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8-pre3 linking error
Message-ID: <20020410113927.GE28413@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	"Udo A. Steinberg" <reality@delusion.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CB418B7.BB5CFEB9@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 12:49:27PM +0200, Udo A. Steinberg wrote:

> 2.5.8-pre3 fails to link here:
> 
> init/main.o: In function `start_kernel':
> init/main.o(.text.init+0x681): undefined reference to `setup_per_cpu_areas'
> 

Apply this:

===== init/main.c 1.39 vs edited =====
--- 1.39/init/main.c	Fri Mar 15 15:01:31 2002
+++ edited/init/main.c	Wed Apr 10 10:35:38 2002
@@ -271,6 +271,10 @@
 #define smp_init()	do { } while (0)
 #endif
 
+static inline void setup_per_cpu_areas(void)
+{
+}
+
 #else
 
 #ifdef __GENERIC_PER_CPU

-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
