Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261858AbVCYWox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbVCYWox (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbVCYWoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:44:32 -0500
Received: from mail.stdbev.com ([63.161.72.3]:41400 "EHLO
	mail.standardbeverage.com") by vger.kernel.org with ESMTP
	id S261858AbVCYWns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:43:48 -0500
Message-ID: <f2efeeee48c1ed6eb1438b103c5a5559@stdbev.com>
Date: Fri, 25 Mar 2005 16:43:50 -0600
From: "Jason Munro" <jason@stdbev.com>
Subject: Re: 2.6.12-rc1-mm3 (cannot read cd-rom, 2.6.12-rc1 is OK)
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <elenstev@mesatop.com>
Reply-to: <jason@stdbev.com>
In-Reply-To: <20050325142336.12687e09.akpm@osdl.org>
References: <20050325002154.335c6b0b.akpm@osdl.org>
            <42446B86.7080403@mesatop.com>
            <424471CB.3060006@mesatop.com>
            <20050325122433.12469909.akpm@osdl.org>
            <4244812C.3070402@mesatop.com>
            <761c884705af2ea412c083d849598ca7@stdbev.com>
            <20050325140654.430714e2.akpm@osdl.org>
            <20050325142336.12687e09.akpm@osdl.org>
X-Mailer: Hastymail 1.4-CVS
x-priority: 3
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4:23:36 pm 03/25/05 Andrew Morton <akpm@osdl.org> wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> >  It's the new rock-ridge bounds checking.
>
> Try this, please?
>
> diff -puN fs/isofs/rock.c~rock-handle-directory-overflows-fix
> fs/isofs/rock.c --- 25/fs/isofs/rock.c~rock-handle-directory-overflows
> -fix    Fri Mar 25 14:21:32 2005
> +++ 25-akpm/fs/isofs/rock.c    Fri Mar 25 14:22:01 2005
> @@ -218,12 +218,12 @@ repeat:
>          if (rr->len < 3)
>              goto out;    /* Something got screwed up here */
>          sig = isonum_721(rs.chr);
> +        if (rock_check_overflow(&rs, sig))
> +            goto eio;
>          rs.chr += rr->len;
>          rs.len -= rr->len;
>          if (rs.len < 0)
>              goto eio;    /* corrupted isofs */
> -        if (rock_check_overflow(&rs, sig))
> -            goto eio;
>
>          switch (sig) {
>          case SIG('R', 'R'):
> @@ -316,12 +316,12 @@ repeat:
>          if (rr->len < 3)
>              goto out;    /* Something got screwed up here */
>          sig = isonum_721(rs.chr);
> +        if (rock_check_overflow(&rs, sig))
> +            goto eio;
>          rs.chr += rr->len;
>          rs.len -= rr->len;
>          if (rs.len < 0)
>              goto eio;    /* corrupted isofs */
> -        if (rock_check_overflow(&rs, sig))
> -            goto eio;
>
>          switch (sig) {
>  #ifndef CONFIG_ZISOFS        /* No flag for SF or ZF */
> @@ -694,12 +694,12 @@ repeat:
>          if (rr->len < 3)
>              goto out;    /* Something got screwed up here */
>          sig = isonum_721(rs.chr);
> +        if (rock_check_overflow(&rs, sig))
> +            goto out;
>          rs.chr += rr->len;
>          rs.len -= rr->len;
>          if (rs.len < 0)
>              goto out;    /* corrupted isofs */
> -        if (rock_check_overflow(&rs, sig))
> -            goto out;
>
>          switch (sig) {
>          case SIG('R', 'R'):
> _

This fixes it here.

\__  Jason Munro
 \__ jason@stdbev.com
  \__ http://hastymail.sourceforge.net/

