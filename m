Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbVHXUbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVHXUbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVHXUbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:31:36 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:59031 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932095AbVHXUbf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:31:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+F3j3h2RZTUCZfqRpm/SOdpGT6G5OC9iixhINoPi1U7Ve020pyalDQxGUq7Ri4RgfYWY9/iexLWxjexc19sUEqRNoOfOO3IXU+sg7p9WRrF+wlhtsD2156Ml7xC+v45heHPh+KT8QvJARenPe9nlfUKB0eGSGb9axjr4mNNiLA=
Message-ID: <9a87484905082413312b5a603a@mail.gmail.com>
Date: Wed, 24 Aug 2005 22:31:34 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] exterminate strtok - usr/gen_init_cpio.c
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
In-Reply-To: <430CD530.7000509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508242108.53198.jesper.juhl@gmail.com>
	 <430CD4A1.80005@didntduck.org> <430CD530.7000509@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/05, Jeff Garzik <jgarzik@pobox.com> wrote:
> Brian Gerst wrote:
> > Jesper Juhl wrote:
> >
> >> Convert strtok() use to strsep() in usr/gen_init_cpio.c
> >>
> >> I've compile tested this patch and it compiles fine.
> >> I build a 2.6.13-rc6-mm2 kernel with the patch applied without
> >> problems, and
> >> the resulting kernel boots and runs just fine (using it right now).
> >> But despite this basic testing it would still be nice if someone would
> >> double-check that I haven't made some silly mistake that would break
> >> some other setup than mine.
> >>
> >>
> >> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> >> ---
> >>
> >>  gen_init_cpio.c |   31 ++++++++++++++++++++++---------
> >>  1 files changed, 22 insertions(+), 9 deletions(-)
> >>
> >> --- linux-2.6.13-rc6-mm2-orig/usr/gen_init_cpio.c    2005-06-17
> >> 21:48:29.000000000 +0200
> >> +++ linux-2.6.13-rc6-mm2/usr/gen_init_cpio.c    2005-08-24
> >> 18:58:21.000000000 +0200
> >> @@ -438,7 +438,7 @@ struct file_handler file_handler_table[]
> >>  int main (int argc, char *argv[])
> >>  {
> >>      FILE *cpio_list;
> >> -    char line[LINE_SIZE];
> >> +    char *line, *ln;
> >>      char *args, *type;
> >>      int ec = 0;
> >>      int line_nr = 0;
> >> @@ -455,7 +455,14 @@ int main (int argc, char *argv[])
> >>          exit(1);
> >>      }
> >>
> >> -    while (fgets(line, LINE_SIZE, cpio_list)) {
> >> +    ln = malloc(LINE_SIZE);
> >
> >
> > Why change to malloc()?  This is a userspace program.  It doesn't have
> > the kernel stack constraints.
> 
> Good catch, agreed.
> 
> I prefer the code as-is, with LINE_SIZE stack allocations.
> 
The reason I did it like that was that strsep takes offense at
strsep(&line, ...) when line is allocated on the stack. So I just
changed it around to being malloc()'ed and things were good.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
