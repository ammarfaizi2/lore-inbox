Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263673AbTEYSwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 14:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263681AbTEYSwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 14:52:06 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:55194 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263673AbTEYSwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 14:52:05 -0400
Date: Sun, 25 May 2003 14:16:22 -0400
From: Ben Collins <bcollins@debian.org>
To: Ren? Scharfe <l.s.r@web.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Edgar Toernig <froese@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525181622.GD602@phunnypharm.org>
References: <20030525112150.3994df9b.l.s.r@web.de> <3ED0FC58.D1F04381@gmx.de> <20030525210509.09429aaa.l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030525210509.09429aaa.l.s.r@web.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 25, 2003 at 09:05:09PM +0200, Ren? Scharfe wrote:
> On Sun, 25 May 2003 19:24:40 +0200 Edgar Toernig <froese@gmx.de> wrote:
> > Ren? Scharfe wrote:
> > > +       if (bufsize == 0)
> > > +               return 0;
> > 
> >                   return ret; ???
> 
> Yes, Samba's and the BSDs' strlcpy() deviate in that point. It's a very
> unusual case to have a zero-sized buffer, though, so probably it doesn't
> matter much.
> 
> Anyway, I corrected this. Patch below contains a "BSD-compatible" version,
> and also a strlcat().
> 
> Ben, I think this one is better than your's because it's shorter and
> already GPL'd (there's not more license than C code :). Linus?

> +size_t strlcat(char *dest, const char *src, size_t bufsize)
> +{
> +	size_t len1 = strlen(dest);
> +	size_t len2 = strlen(src);
> +	size_t ret = len1 + len2;
> +
> +	if (len1+len2 >= bufsize)
> +		len2 = bufsize - (len1+1);
> +	if (len2 > 0) {
> +		memcpy(dest+len1, src, len2);
> +		dest[len1+len2] = '\0';
> +	}
> +	return ret;
> +}
> +#endif

Your strlcat doesn't take into consideration that a zero bufsize could
mean that dest is not NUL-terminated, in which case strlen(dest) could
blow up in your face. Since strlcpy can handle zero bufsize, strlcat
should be able to handle being called just after strlcpy being called
with zero bufsize (see my patch).

I personally am not concerned either way, but it is definitely worth
noting.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
