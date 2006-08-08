Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWHHJQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWHHJQu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 05:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWHHJQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 05:16:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8871 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWHHJQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 05:16:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HmLr1nU4RHckDIZPg7Sp3X0TRsE2bpk8ToPrx9WQ09Wkojq9Lh9yveyEsxkk7xsXO45JWwJWK7hAn8UpxDA9VBNijo6V6cZeLNCg07a7ZQdHupCGr80MgbqVzWm+hK5W2T6tCnmbsD5nZ/3TbMf5Vrw4jZKBPi79Yme5BhCriU8=
Message-ID: <41840b750608080216l58f56030v9c766427f8582f4c@mail.gmail.com>
Date: Tue, 8 Aug 2006 12:16:47 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807232415.GE2759@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <1154849246822-git-send-email-multinymous@gmail.com>
	 <20060807140222.GG4032@ucw.cz>
	 <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com>
	 <20060807232415.GE2759@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
> Okay, so what about ..
>
> #define CONVERT(x) *(s16*)(data.val+x) * (hdaps_invert?-1:1);
>
> ...or better inline function?

Actually, some models require fancier transformations. This was
supposed to be reserved for a future patch, but might as well prepare
the infrastructure:

/* Some models require an axis transformation to the standard reprsentation */
static void transform_axes(int inx, int iny, int *outx, int *outy) {
	*outx = inx * (hdaps_invert?-1:1);
	*outy = iny * (hdaps_invert?-1:1);
}
...
	/* Parse position data: */
	transform_axes(*(s16*)(data.val+EC_ACCEL_IDX_XPOS1),
	               *(s16*)(data.val+EC_ACCEL_IDX_YPOS1), &pos_x, &pos_y);

	/* Parse so-called "variance" data: */
	transform_axes(*(s16*)(data.val+EC_ACCEL_IDX_XPOS2),
	               *(s16*)(data.val+EC_ACCEL_IDX_YPOS2), &var_x, &var_y);


  Shem
