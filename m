Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSE1Upy>; Tue, 28 May 2002 16:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316927AbSE1Un6>; Tue, 28 May 2002 16:43:58 -0400
Received: from [195.39.17.254] ([195.39.17.254]:59292 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316910AbSE1UlX>;
	Tue, 28 May 2002 16:41:23 -0400
Date: Tue, 28 May 2002 21:20:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Lee Irwin III <wli@holomorphy.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
Message-ID: <20020528192041.GA189@elf.ucw.cz>
In-Reply-To: <20020521222858.GA14737@elf.ucw.cz> <20020527194018.GQ14918@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > +
> > +			for(;;) {
> > +				if(!curr) {
> > +//					printk("FIXME: this should not happen but it does!!!");
> > +					break;
> > +				}
> > +				if(p != memlist_entry(curr, struct page, list)) {
> > +					curr = memlist_next(curr);
> > +					if (curr == head)
> > +						break;
> > +					continue;
>                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                                        deep trouble here and in the if ()
> 
> On Wed, May 22, 2002 at 12:28:59AM +0200, Pavel Machek wrote:
> > +				}
> > +				return 1 << order;
> > +			}
> > +		} while(order--);
> > +		spin_unlock_irqrestore(&zone->lock, flags);
> > +
> > +	}
> > +	return 0;
> > +}
> > +#endif /* CONFIG_SOFTWARE_SUSPEND */
> 
> The rest is okay...
> 
> I'd try writing it this way, and though I've not tested it, I've walked
> buddy lists a few times in the past week or two:

It dies with NULL pointer dereference. Perhaps "that should not happen
but it does?".
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
