Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932323AbVIMGCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbVIMGCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVIMGCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:02:46 -0400
Received: from 66-23-228-155.clients.speedfactory.net ([66.23.228.155]:46526
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S932323AbVIMGCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:02:46 -0400
Date: Tue, 13 Sep 2005 01:58:32 -0400
From: Sonny Rao <sonny@burdell.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       brking@us.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.13-mm3
Message-ID: <20050913055832.GA28971@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Jiri Slaby <jirislaby@gmail.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
	brking@us.ibm.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20050912194032.GA12426@kevlar.burdell.org> <200509122106.j8CL6WPk006092@wscnet.wsc.cz> <20050912214945.GA17729@kevlar.burdell.org> <20050912221023.GB18215@kevlar.burdell.org> <4326229B.6040002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4326229B.6040002@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 02:51:39AM +0200, Jiri Slaby wrote:
> Sonny Rao napsal(a):
> 
> >On Mon, Sep 12, 2005 at 05:49:45PM -0400, Sonny Rao wrote:
> > 
> >
> >>--- linux-2.6.13-mm3/drivers/char/hvc_console.c~orig	2005-09-12 
> >>16:37:14.434077464 -0500
> >>+++ linux-2.6.13-mm3/drivers/char/hvc_console.c	2005-09-12 
> >>16:37:25.466998360 -0500
> >>@@ -597,7 +597,7 @@ static int hvc_poll(struct hvc_struct *h
> >>
> >>	/* Read data if any */
> >>	for (;;) {
> >>-		count = tty_buffer_request_room(tty, N_INBUF);
> >>+		int count = tty_buffer_request_room(tty, N_INBUF);
> >>
> >>		/* If flip is full, just reschedule a later read */
> >>		if (count == 0) {
> >>@@ -633,7 +633,7 @@ static int hvc_poll(struct hvc_struct *h
> >>			tty_insert_flip_char(tty, buf[i], 0);
> >>		}
> >>
> >>-		if (tty->flip.count)
> >>+		if (tty->buf.tail->used)
> >>   
> >>
> Is there any better way to gather this info? I think, that this was my 
> bad idea. Some encapsulation needed.
> 

I agree, this is ugly as hell.  I don't know if the tty stuff was
ever supposed to be used this way.  Given the revamp, and if this usage is
legal, perhaps the addition of a generic wrapper to the API is
warranted.

Sonny
