Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRDHSq7>; Sun, 8 Apr 2001 14:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132587AbRDHSqt>; Sun, 8 Apr 2001 14:46:49 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:55763 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S132586AbRDHSqk>;
	Sun, 8 Apr 2001 14:46:40 -0400
To: Russell Coker <russell@coker.com.au>
Cc: linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au
Subject: Re: struct stat{st_blksize} for /dev entries in 2.4.3
In-Reply-To: <01040823491919.25703@lyta>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 08 Apr 2001 11:46:25 -0700
In-Reply-To: Russell Coker's message of "Sun, 8 Apr 2001 23:49:19 +1000"
Message-ID: <m3snjjnsam.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Coker <russell@coker.com.au> writes:

> diff -ru textutils-2.0/src/cat.c textutils-new/src/cat.c
> --- textutils-2.0/src/cat.c     Sun Apr  8 22:55:10 2001
> +++ textutils-new/src/cat.c     Sun Apr  8 23:23:54 2001
> @@ -790,6 +790,9 @@
>        if (options == 0)
>         {
>           insize = max (insize, outsize);
> +#ifdef _SC_PHYS_PAGES
> +         insize = max (insize, sysconf(_SC_PAGESIZE));
> +#endif
>           inbuf = (unsigned char *) xmalloc (insize);
>  
>           simple_cat (inbuf, insize);

The #ifdef is certainly wrong.  And there is no guarantee that any of
the _SC_* constants are defined as macros.  You'll have to add a
configure test.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
