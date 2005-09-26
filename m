Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbVIZNcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbVIZNcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVIZNcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:32:46 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:44440 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932123AbVIZNcp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:32:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MRJGypyWX7oFNquXV8I22cQA8YWlnIxiNB9GJMUNjtZB0wqPiEqMovzTKKoSYKq0eQoe2v59KQtG6D/mbhGatVR1VcGhW8tIgM7o0Z/1JBQ7vgFBPO8x26xEZImibatliGoj9Ss8Dw3kjSd7k544BBWl9fObw/JTMqjf2PF1CpE=
Message-ID: <9e473391050926063264010349@mail.gmail.com>
Date: Mon, 26 Sep 2005 09:32:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: usb-snd-audio breakage
In-Reply-To: <20050926033805.GB22376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910509251927484a70c7@mail.gmail.com>
	 <9e4733910509251943277f077a@mail.gmail.com>
	 <20050926033805.GB22376@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So module and proc code will strip white space, but sysfs won't strip
white space. Where is the consistency?

On 9/25/05, Dave Jones <davej@redhat.com> wrote:
> On Sun, Sep 25, 2005 at 10:43:11PM -0400, Jon Smirl wrote:
>  > The Redhat FC4 installer is adds index=0 in modprobe.conf. The index
>  > parameter appears to have been removed fron snd-usb-audio.
>  >
>  > There are two issues:
>  > 1) should index have been left as a non-functioning param so that
>  > existing installs won't break.
>  > 2) Why didn't I get a decent error message about index being the
>  > problem instead of the message about `'
>
> This patch really should have been merged for 2.6.13
> but somehow fell through the cracks. I don't think it
> even landed in -mm
>
>                 Dave
>
>
>
> Name: Ignore trailing whitespace on kernel parameters correctly: Fixed version
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
>
> Dave Jones says:
>
> ... if the modprobe.conf has trailing whitespace, modules fail to load
> with the following helpful message..
>
>         snd_intel8x0: Unknown parameter `'
>
> Previous version truncated last argument.
>
> Index: linux-2.6.13-rc6-git7-Module/kernel/params.c
> ===================================================================
> --- linux-2.6.13-rc6-git7-Module.orig/kernel/params.c   2005-08-10 16:12:45.000000000 +1000
> +++ linux-2.6.13-rc6-git7-Module/kernel/params.c        2005-08-16 14:31:16.000000000 +1000
> @@ -80,8 +80,6 @@
>         int in_quote = 0, quoted = 0;
>         char *next;
>
> -       /* Chew any extra spaces */
> -       while (*args == ' ') args++;
>         if (*args == '"') {
>                 args++;
>                 in_quote = 1;
> @@ -121,6 +119,9 @@
>                 next = args + i + 1;
>         } else
>                 next = args + i;
> +
> +       /* Chew up trailing spaces. */
> +       while (*next == ' ') next++;
>         return next;
>  }
>
> @@ -134,6 +135,9 @@
>         char *param, *val;
>
>         DEBUGP("Parsing ARGS: %s\n", args);
> +
> +       /* Chew leading spaces */
> +       while (*args == ' ') args++;
>
>         while (*args) {
>                 int ret;
>
>
>


--
Jon Smirl
jonsmirl@gmail.com
