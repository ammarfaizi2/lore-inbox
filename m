Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262719AbRE3Kk0>; Wed, 30 May 2001 06:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbRE3KkG>; Wed, 30 May 2001 06:40:06 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:46720 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262719AbRE3KkE>;
	Wed, 30 May 2001 06:40:04 -0400
Message-ID: <3B14CDF8.492356F5@mandrakesoft.com>
Date: Wed, 30 May 2001 06:39:52 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, andrewm@uow.edu.au,
        p_gortmaker@yahoo.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net #3
In-Reply-To: <200105300041.CAA04507@green.mif.pg.gda.pl> <29071.991213917@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> ankry@green.mif.pg.gda.pl said:
> > -#ifdef CONFIG_ISAPNP
> > +#if defined(CONFIG_ISAPNP) || (defined(CONFIG_ISAPNP_MODULE) && defined(MODULE))
> 
> The result here would be a 3c509 module which differs depending on whether
> the ISAPNP module happened to be compiled at the same time or not.

In and of itself, that is an acceptable result.  We simply cannot take
into kernel configuration variations between two kernel builds.  If you
build your isapnp module with one configuration, and your 3c509 module
with another config, consider yourself lucky that it works at all.


> The ISAPNP-specific parts of the code aren't large. Please consider
> including them unconditionally instead.

I probably agree with you and Paul, but I'll have to give it a bit more
thought.  Past a certain point, bus support needs to be in its own
driver, similar to drivers/sound/{sb_card,sb_common}.c.  But in this
particular case, that would be overkill.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
