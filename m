Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263120AbREWPDf>; Wed, 23 May 2001 11:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263122AbREWPD2>; Wed, 23 May 2001 11:03:28 -0400
Received: from mail.inup.com ([194.250.46.226]:6148 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263119AbREWPDH>;
	Wed, 23 May 2001 11:03:07 -0400
Date: Wed, 23 May 2001 17:02:15 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523170215.C8075@pc8.lineo.fr>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de> <20010523163758.C7823@pc8.lineo.fr> <20010523164036.A24809@gruyere.muc.suse.de> <20010523165028.A7917@pc8.lineo.fr> <20010523165557.A25277@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010523165557.A25277@gruyere.muc.suse.de>; from ak@suse.de on Wed, May 23, 2001 at 16:55:57 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe you and It's sure that I have not tested all cases.
So do you see a way to use a private data buffer ?

Christophe

On Wed, 23 May 2001 16:55:57 Andi Kleen wrote:
> On Wed, May 23, 2001 at 04:50:28PM +0200, christophe barbé wrote:
> > I don't know about socket but I allocate myself the skbuff and I set
> the
> > destructor (and previously the pointer value is NULL). So I don't
> overwrite
> > a destructor.
> 
> That just means you didn't test all cases; e.g. not TCP or UDP
> send/receive.
> 
> 
> 
> > 
> > I believe net/core/sock.c is not involved in my problem but I can be
> wrong.
> > What is worrying me is that I don't know who clones my skbuff and why.
> 
> skbuffs are cloned all over the stack for various reasons.
> 
>  
> > To said everything, I know who clones my skbuff because it causes a
> oops
> > when it tries to free my buffer If I use my destructor.
> 
> Because you're mistakely using a private field.
> 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com

