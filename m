Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVIXOxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVIXOxA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 10:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVIXOw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 10:52:59 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:55118 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbVIXOw7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 10:52:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ij5cEpiLGfd4gg/ps6+kJF1FOZvVm3UPfGMVcI1WNLkyY3DnOZj9DjPylxsSRE5Wj+ybZ/gZoqQ1njQFTnkQwpY5A90zubVXfRKWv9yYDnMeVM95kxxl5DQyVdHJLacsFw2jednva9iYKoB2M1hYaBgg3+xvbnOOo4UYMyGoOMs=
Message-ID: <9a8748490509240752436ef7b2@mail.gmail.com>
Date: Sat, 24 Sep 2005 16:52:28 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: [PATCH] Unify sys_tkill() and sys_tgkill()
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0509231913550.5348@shell3.speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Vadim Lobanov <vlobanov@speakeasy.net> wrote:
> Hi,
>
> The majority of the sys_tkill() and sys_tgkill() function code is
> duplicated between the two of them. This patch pulls the duplication out
> into a separate function -- do_tkill() -- and lets sys_tkill() and
> sys_tgkill() be simple wrappers around it. This should make it easier to
> maintain in light of future changes.
>

A few nitpicks ... :

[snip]
> +static int do_tkill(int tgid, int pid, int sig)

I would probably have made this

  static inline int do_tkill(int tgid, int pid, int sig)


[snip]
> +       if (p && ((tgid <= 0) || (p->tgid == tgid))) {

Why all the extra parenthesis?

   if (p && (tgid <= 0 || p->tgid == tgid)) {


[snip]
> +       return (do_tkill(tgid, pid, sig));

return is not a function

   return do_tkill(tgid, pid, sig);

[snip]
> +       return (do_tkill(0, pid, sig));

again, get rid of the pointless extra parens

   return do_tkill(0, pid, sig);


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
