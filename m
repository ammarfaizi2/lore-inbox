Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbUJ0Bcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUJ0Bcm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 21:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbUJ0Bcm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 21:32:42 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:38777 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261526AbUJ0Bck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 21:32:40 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: Input: sunkbd concern
Date: Tue, 26 Oct 2004 20:32:27 -0500
User-Agent: KMail/1.6.2
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
References: <200410221833.04057.dtor_core@ameritech.net> <20041026180622.14fc6268.davem@davemloft.net>
In-Reply-To: <20041026180622.14fc6268.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410262032.27938.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 October 2004 08:06 pm, David S. Miller wrote:
> On Fri, 22 Oct 2004 18:33:04 -0500
> Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> 
> > I have been looking at sunkbd.c and it seems that it attaches not only to
> > ports that speak SUNKBD protocol but also to ports that do not specify any
> > protocol:
> > 
> > 	if ((serio->type & SERIO_PROTO) && (serio->type & SERIO_PROTO) != SERIO_SUNKBD)
> > 		return;
> > 
> > Was that an oversight or it was done intentionally?
> 
> I believe it is intentional.
> 
> If SERIO_PROTO bits are all clear, this is supposed to have
> a special meaning in that any keyboard driver can claim
> the serio line.
> 
> So if it's the "wildcard" zero value, or specifically SERIO_SUNKBD,
> we'll attach to it.
> 

I would buy if I see another keyboard doing this, but so far only sunkbd
does this. The rest of keyboards connecting to a RS232-type ports require
exact protocol match...

The background is that I am trying to create a bus "match" function for
serio and trying to understand the requirements... 
 
-- 
Dmitry
