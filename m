Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbREWO5F>; Wed, 23 May 2001 10:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263116AbREWO4z>; Wed, 23 May 2001 10:56:55 -0400
Received: from ns.suse.de ([213.95.15.193]:21521 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263115AbREWO4w>;
	Wed, 23 May 2001 10:56:52 -0400
Date: Wed, 23 May 2001 16:55:57 +0200
From: Andi Kleen <ak@suse.de>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523165557.A25277@gruyere.muc.suse.de>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de> <20010523163758.C7823@pc8.lineo.fr> <20010523164036.A24809@gruyere.muc.suse.de> <20010523165028.A7917@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523165028.A7917@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Wed, May 23, 2001 at 04:50:28PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 04:50:28PM +0200, christophe barbé wrote:
> I don't know about socket but I allocate myself the skbuff and I set the
> destructor (and previously the pointer value is NULL). So I don't overwrite
> a destructor.

That just means you didn't test all cases; e.g. not TCP or UDP send/receive.



> 
> I believe net/core/sock.c is not involved in my problem but I can be wrong.
> What is worrying me is that I don't know who clones my skbuff and why.

skbuffs are cloned all over the stack for various reasons.

 
> To said everything, I know who clones my skbuff because it causes a oops
> when it tries to free my buffer If I use my destructor.

Because you're mistakely using a private field.


-Andi
