Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVH3LZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVH3LZg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 07:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbVH3LZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 07:25:36 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:1259 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751365AbVH3LZf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 07:25:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mFGEycKzj8pgeVO3QNCDyK7NYEeYgNlaHx4MmvQykLDmn19ZLKHPucWkjcsgo2sufIZwCAJSkziJ1N8vz/qD6XWVa7+giJV8dxpjN55G6Ucq3wz6NtRvcPNgybUls93UtYf/qIinsaRZ12YVsvAhrmPmiek8nnq7gdrAzON5xlw=
Message-ID: <9a8748490508300425442b84e8@mail.gmail.com>
Date: Tue, 30 Aug 2005 13:25:29 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] isdn_v110 warning fix
Cc: linux-kernel@vger.kernel.org, Thomas Pfeiffer <pfeiffer@pds.de>,
       isdn4linux@listserv.isdn4linux.de, Karsten Keil <kkeil@suse.de>,
       Kai Germaschewski <kai.germaschewski@gmx.de>
In-Reply-To: <20050830082033.GB12449@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508300105.44247.jesper.juhl@gmail.com>
	 <20050830082033.GB12449@mipter.zuzino.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Tue, Aug 30, 2005 at 01:05:43AM +0200, Jesper Juhl wrote:
> > drivers/isdn/i4l/isdn_v110.c:523: warning: `ret' might be used uninitialized in this function
> 
> > --- linux-2.6.13-orig/drivers/isdn/i4l/isdn_v110.c
> > +++ linux-2.6.13/drivers/isdn/i4l/isdn_v110.c
> > @@ -516,11 +516,11 @@
> 
> > -isdn_v110_stat_callback(int idx, isdn_ctrl * c)
> > +isdn_v110_stat_callback(int idx, isdn_ctrl *c)
> >  {
> >       isdn_v110_stream *v = NULL;
> >       int i;
> > -     int ret;
> > +     int ret = 0;
> 
> ret is used only in isdn_v110_stat_callback()::case ISDN_STAT_BSENT.
> It's possible for it to be unused only if passed c->parm.length is 0.
> Do you see codepaths that can do it?
> 
No, I don't see any codepaths that could lead to it being used uninitialized. 
I made the patch for two reasons;  1) To silence the warning, and I
guess it's simply the right thing to do.   2) To make sure the code
behaves in a resonably sane way in case the situation
c->parm.length==0 should somehow happen in the future.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
