Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263113AbREWOvp>; Wed, 23 May 2001 10:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263114AbREWOv0>; Wed, 23 May 2001 10:51:26 -0400
Received: from mail.inup.com ([194.250.46.226]:32787 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S263113AbREWOvU>;
	Wed, 23 May 2001 10:51:20 -0400
Date: Wed, 23 May 2001 16:50:28 +0200
From: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
To: Andi Kleen <ak@suse.de>
Cc: =?ISO-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>,
        Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523165028.A7917@pc8.lineo.fr>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de> <20010523163758.C7823@pc8.lineo.fr> <20010523164036.A24809@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010523164036.A24809@gruyere.muc.suse.de>; from ak@suse.de on Wed, May 23, 2001 at 16:40:36 +0200
X-Mailer: Balsa 1.1.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know about socket but I allocate myself the skbuff and I set the
destructor (and previously the pointer value is NULL). So I don't overwrite
a destructor.

I believe net/core/sock.c is not involved in my problem but I can be wrong.
What is worrying me is that I don't know who clones my skbuff and why.

To said everything, I know who clones my skbuff because it causes a oops
when it tries to free my buffer If I use my destructor.

Christophe

On Wed, 23 May 2001 16:40:36 Andi Kleen wrote:
> On Wed, May 23, 2001 at 04:37:58PM +0200, christophe barbé wrote:
> > It seems to not be the case, because my destructor is called.
> 
> It is called, but you overwrote the kernel destructor and therefore
> broke the socket memory accounting completely; causing all kinds of 
> problems.
> 
> > Could you point me the code where you think this method is already
> used?
> 
> net/core/sock.c
> 
> 
> -Andi
> 
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

