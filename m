Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWHGPk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWHGPk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWHGPk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:40:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:1295 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932172AbWHGPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:40:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SCtzA4VUUDsCbR7GB4yHZdDc+osUl7zx6iTC5qntmrsPUUmH9zHsUPsc3J52RXqoblLs+2J/SdNkhEAdytzc7cJwQn1dk6W691BY8+Z+QywaDvVPfsDoX2n67mgpO5rApcXu1Dw5xrVyx8j9IxV5ACGTLs88dctSMn+nb4nWoM0=
Message-ID: <41840b750608070840o76cc605bj76602d83825af4d3@mail.gmail.com>
Date: Mon, 7 Aug 2006 18:40:23 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 02/12] hdaps: Use thinkpad_ec instead of direct port access
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807135551.GF4032@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492333054-git-send-email-multinymous@gmail.com>
	 <20060807135551.GF4032@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > +#define ABORT_INIT(msg) { printk(KERN_ERR "hdaps init: %s\n", msg); goto bad; }
>
> No.. macro with embedded goto is *evil*.

OK. But it does makes the init function much longer and harder to read.


> > +     if (data.val[0xF]!=0x00)
> > +             ABORT_INIT("check1");
>
> !=0 in if is evil...

Sure, when zero is special, like for booleans or integer or pointers.
But this is a status byte value, I don't want to mistreat it just
because all its bits are unset. Otherwise, imagine the non-systematic
mess this will become:

	if (data.val[0x1]!=0x00 ||
	    data.val[0x2]!=0x60 ||
	    data.val[0x3]!=0x00 ||
	    data.val[0xF]!=0x00)
		ABORT_INIT("check2");

> > +     if (mode==0x00)
>
> if !mode ?

Likewise.

  Shem
