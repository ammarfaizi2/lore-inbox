Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVBJAqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVBJAqI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 19:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVBJAqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 19:46:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:50878 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261992AbVBJAqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 19:46:02 -0500
Date: Wed, 9 Feb 2005 16:46:01 -0800
From: Chris Wright <chrisw@osdl.org>
To: Jonathan Ho <jonathanho15@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] string lib redundancy and whitespace clarity fixes
Message-ID: <20050209164601.K469@build.pdx.osdl.net>
References: <420AAB9D.6010801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <420AAB9D.6010801@gmail.com>; from jonathanho15@gmail.com on Wed, Feb 09, 2005 at 04:32:29PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Ho (jonathanho15@gmail.com) wrote:
> Fixed some weird whitespace, solved redundancies (applies to v2.6.10).
> 
> Signed-off-by: Jonathan Ho <jonathanho15@gmail.com>
> 
> --- lib/string.c    Fri Dec 24 13:35:25 2004
> +++ \documents and settings\jonathan\desktop/string.c    Wed Feb 09 

This won't apply nicely with -p1.  Nor will it apply against
current -bk (which no longer has bcopy in it, for example).

> 16:21:28 2005
> @@ -38,7 +38,7 @@ int strnicmp(const char *s1, const char
>      /* Yes, Virginia, it had better be unsigned */
>      unsigned char c1, c2;
>  
> -    c1 = 0;    c2 = 0;
> +    c1 = c2 = 0;
>      if (len) {
>          do {
>              c1 = *s1; c2 = *s2;
> @@ -253,12 +253,12 @@ EXPORT_SYMBOL(strncmp);
>   * @s: The string to be searched
>   * @c: The character to search for
>   */
> -char * strchr(const char * s, int c)
> +char *strchr(const char * s, int c)
>  {
> -    for(; *s != (char) c; ++s)
> +    for( ; *s != (char) c; s++)
>          if (*s == '\0')
>              return NULL;
> -    return (char *) s;
> +    return (char *)s;

For this kind of CodingStyle cleanup, I think it's probably not worth it.  
Unless you have other changes and fixes planned in the area.

>  }
>  EXPORT_SYMBOL(strchr);
>  #endif
> @@ -390,14 +390,14 @@ EXPORT_SYMBOL(strcspn);
>   * @cs: The string to be searched
>   * @ct: The characters to search for
>   */
> -char * strpbrk(const char * cs,const char * ct)
> +char * strpbrk(const char *cs, const char *ct)
>  {
> -    const char *sc1,*sc2;
> +    const char *sc1, *sc2;
>  
> -    for( sc1 = cs; *sc1 != '\0'; ++sc1) {
> -        for( sc2 = ct; *sc2 != '\0'; ++sc2) {
> +    for(sc1 = cs; *sc1 != '\0'; sc1++) {
> +        for(sc2 = ct; *sc2 != '\0'; sc2++) {

Neither of these is CodingStyle compliant ;-)  Take a look at what
Lindent does (not perfect, but good rule of thumb).

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
