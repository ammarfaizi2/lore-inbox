Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292754AbSBZTzO>; Tue, 26 Feb 2002 14:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292766AbSBZTyz>; Tue, 26 Feb 2002 14:54:55 -0500
Received: from ns.suse.de ([213.95.15.193]:22801 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292754AbSBZTyr>;
	Tue, 26 Feb 2002 14:54:47 -0500
Date: Tue, 26 Feb 2002 20:54:22 +0100
From: Dave Jones <davej@suse.de>
To: petter wahlman <petter@bluezone.no>
Cc: linux-kernel@vger.kernel.org, info@melware.de
Subject: Re: [PATCH] 2.4.18 Eicon ISDN driver fix.
Message-ID: <20020226205422.N2222@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	petter wahlman <petter@bluezone.no>, linux-kernel@vger.kernel.org,
	info@melware.de
In-Reply-To: <1014679267.27236.6.camel@BadEip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1014679267.27236.6.camel@BadEip>; from petter@bluezone.no on Tue, Feb 26, 2002 at 08:26:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 08:26:18PM +0100, petter wahlman wrote:
 > +++ linux-2.4.18-pw/drivers/isdn/eicon/eicon_mod.c      Mon Feb 25

 > -                       if (user)
 > +                       if (user) {
 > +                               spin_unlock_irqrestore(&eicon_lock,
 > flags);
 >                                 copy_to_user(p, skb->data, cnt);
 > +                               spin_lock_irqsave(&eicon_lock, flags);
 > +                       }

What happens if something else adds/removes to card->statq, or
frees the skb after you drop the lock?  I'm not familiar with
this code, but from a quick look, it looks like this introduces
a race no ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
