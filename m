Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVE0EBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVE0EBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 00:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVE0EBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 00:01:13 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:54251 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261661AbVE0EBI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 00:01:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bAXW8aIdzn7NrZSAz2uDIr3yMU1HjnITzVeIlLpMtvEeVb6OlC+HCa7EU/TVYGjI+acNiVjPrNhhl/Eor/ry0zQMCQD+2sXVFV3xRd8k5bP+bAscrp8JBxqWq8CbjZToOaIQIqtmrqx7xyPYwGcYoIv5umskcdXD8LIcQSqxIfw=
Message-ID: <311601c9050526210119abb8d8@mail.gmail.com>
Date: Thu, 26 May 2005 22:01:07 -0600
From: "Eric D. Mudama" <edmudama@gmail.com>
Reply-To: "Eric D. Mudama" <edmudama@gmail.com>
To: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: [PATCH][2.6.12-rc4][SATA] sil driver - Blacklist Maxtor disk
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <20050524162710.55401.qmail@web88008.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050524162710.55401.qmail@web88008.mail.re2.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't believe that drive is vulnerable to the traditionally
described SI issue, as it's based on  Marvell bridge IP.  If that
drive was vulnerable, so would be the drives of more than one other
large vendor.  I would bet something else is actually the root cause,
and by using smaller transfers or something you're just hiding the
race condition, not fixing a root cause.

(obviously i'd love to see a bus trace of the hang in action, but not
everyone can swap their cars for bus analyzers...)

--eric

On 5/24/05, Shawn Starr <shawn.starr@rogers.com> wrote:
> Yes, I know we shouldn't do this, but at the current
> time, this seems to fix DMA READ/WRITE timeout
> problems. This also may fix the sata_nv driver as
> well, but this seems indicate that there is a lowlevel
> problem with the SATA subsystem.
> 
> Signed-off-by: Shawn Starr <shawn.starr@rogers.com>
> 
> --- sata_sil.c.old      2005-05-24 12:19:20.312197269
> -0400
> +++ sata_sil.c  2005-05-11 14:05:26.000000000 -0400
> @@ -93,6 +93,7 @@ struct sil_drivelist {
>         { "ST380011ASL",        SIL_QUIRK_MOD15WRITE
> },
>         { "ST3120022ASL",       SIL_QUIRK_MOD15WRITE
> },
>         { "ST3160021ASL",       SIL_QUIRK_MOD15WRITE
> },
> +       { "Maxtor 6Y080M0",     SIL_QUIRK_MOD15WRITE
> },
>         { "Maxtor 4D060H3",     SIL_QUIRK_UDMA5MAX },
>         { }
>  };
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ide" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
