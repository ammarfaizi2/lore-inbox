Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267943AbUIPLX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267943AbUIPLX5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 07:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUIPLX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 07:23:57 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:42120 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S267943AbUIPLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 07:23:14 -0400
Subject: Re: Suspend2 Merge: e820 table support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916111438.GB5467@elf.ucw.cz>
References: <1095332590.3324.166.camel@laptop.cunninghams>
	 <20040916111438.GB5467@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1095333881.4932.194.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 16 Sep 2004 21:24:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-09-16 at 21:14, Pavel Machek wrote:
> Please, do not put ifdefs around #includes and statements like

Ah. Sorry. Will correct.

> ClearPageNosave. (And is it neccessary at all? I'd just say that all
> pages that are Reserved are Nosave automatically.)

Hmm. Long time since I thought about that. I'll check.

> > +#ifdef CONFIG_SOFTWARE_SUSPEND2
> > +			/*
> > +			 * Mark nosave pages
> > +			 */
> > +			if (addr >= (void *)&__nosave_begin && addr < (void *)&__nosave_end)
> > +				SetPageNosave(mem_map+tmp);
> > +		} else
> > +			/*
> > +			 * Non-RAM pages are always nosave
> > +			 */
> > +			SetPageNosave(mem_map+tmp);
> > +#else
> > +		}
> > +#endif
> > +	}
> 
> Current -mm code does something funny with Nosave; I'm not sure it
> will not try to free them after resume. I have fix in my tree but it
> is little tested.

Double negative: you think current mm may try to free Nosave pages after
resume? I haven't updated to the latest -mm yet, but will see if I can
try tomorrow.

Thanks for the feedback.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

