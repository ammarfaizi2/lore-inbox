Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRAXKNX>; Wed, 24 Jan 2001 05:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131567AbRAXKNN>; Wed, 24 Jan 2001 05:13:13 -0500
Received: from Cantor.suse.de ([194.112.123.193]:38663 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129729AbRAXKM7>;
	Wed, 24 Jan 2001 05:12:59 -0500
Mail-Copies-To: never
To: Daniel Phillips <phillips@innominate.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile dnotify example w/o glibc 2.2 headers
In-Reply-To: <01012410434304.16618@gimli>
From: Andreas Jaeger <aj@suse.de>
Date: 24 Jan 2001 11:12:57 +0100
In-Reply-To: <01012410434304.16618@gimli> (Daniel Phillips's message of "Wed, 24 Jan 2001 10:27:54 +0100")
Message-ID: <hoy9w1xnpy.fsf@gee.suse.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@innominate.de> writes:

> <plug>dnotify is cool, check it out</plug>
> 
> If you want to compile the example in Documentation/dnotify.txt and
> you don't have glibc 2.2 headers installed you have 3 choices:
> 
>   1) Upgrade to glibc 2.2
>   2) Hunt for the missing symbols in the 2.4 source tree
>   3) Apply this patch
> 
> Option (1) is recommended of course, but if you're lazy (like me)
> then...
> 
> --- 2.4.0/Documentation/dnotify.txt~	Mon Jan 22 16:04:32 2001
> +++ 2.4.0/Documentation/dnotify.txt	Mon Jan 22 16:04:25 2001
> @@ -63,6 +63,17 @@
>  	#include <stdio.h>
>  	#include <unistd.h>
>  	
> +	#ifndef F_NOTIFY 	/* pre-glibc 2.2? */

If you're checking for glibc 2.2 or newer, better use:
#if __GLIBC__ == 2 && __GLIBC_MINOR__ >= 2

Andreas
> +	#define F_NOTIFY	1026
> +	#define DN_ACCESS	0x00000001	/* File accessed */
> +	#define DN_MODIFY	0x00000002	/* File modified */
> +	#define DN_CREATE	0x00000004	/* File created */
> +	#define DN_DELETE	0x00000008	/* File removed */
> +	#define DN_RENAME	0x00000010	/* File renamed */
> +	#define DN_ATTRIB	0x00000020	/* File changed attibutes */
> +	#define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
> +	#endif
> +
>  	static volatile int event_fd;
>  	
>  	static void handler(int sig, siginfo_t *si, void *data)

-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
