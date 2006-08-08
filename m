Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbWHHKGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWHHKGE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 06:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964777AbWHHKGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 06:06:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:49910 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964776AbWHHKGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 06:06:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S/5aGdXSVTdGq5XDQEpVMUzIsLQxrIObB2KAd75JgH/STu43jdZ+ITFP7ENRmlwtWhMaiPyNirGqOg8RE2o3LoocEnRtzOwYj/oP8CDaGuI8CK7pDfe8d87wap/VurBL9KJZUj9YB7M8+PmG6vJGQR99hJCq7aKTmQDt2FAVIho=
Message-ID: <41840b750608080306w584b7524v746c688fa3d58342@mail.gmail.com>
Date: Tue, 8 Aug 2006 13:06:00 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 03/12] hdaps: Unify and cache hdaps readouts
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060808092133.GB4245@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <1154849246822-git-send-email-multinymous@gmail.com>
	 <20060807140222.GG4032@ucw.cz>
	 <41840b750608070914h5817b8b0m977141be455067c4@mail.gmail.com>
	 <20060807232415.GE2759@elf.ucw.cz>
	 <41840b750608080216l58f56030v9c766427f8582f4c@mail.gmail.com>
	 <20060808092133.GB4245@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Pavel Machek <pavel@suse.cz> wrote:
>         /* Parse position data: */
>         x = *(s16*)(data.val+EC_ACCEL_IDX_XPOS1);
>         y = *(s16*)(data.val+EC_ACCEL_IDX_YPOS1);
>         transform_axes(&x, &y);
>
> ...which looks even better to me.

Yes, that's elegant.
But it made me realize there's a race condition here (and and also in
the mainline driver): the global pos_x, rest_x etc. could be updated
while an attribute's show_* function is called. Ugh. I guess I need to
sprinkle spinlocks all over the place.

  Shem
