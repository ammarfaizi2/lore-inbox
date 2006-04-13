Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWDMJ2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWDMJ2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbWDMJ2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:28:38 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:24236 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S964858AbWDMJ2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:28:37 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ALSA STABLE 3/3] a few more -- unregister platform device again if probe was unsuccessful
Date: Thu, 13 Apr 2006 11:26:34 +0200
User-Agent: KMail/1.9.1
References: <443DAD5C.8080007@keyaccess.nl>
In-Reply-To: <443DAD5C.8080007@keyaccess.nl>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       Greg KH <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131126.35841.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rene,

On Thursday, 13. April 2006 03:46, you wrote:
> And finally, unregister on probe failure for sound/drivers,
> sound/arm/sa11xx-uda1341.c and sound/ppc/powermac.c.
> 
>    sound/arm/sa11xx-uda1341.c    |   14 +++++++++-----
>    sound/drivers/dummy.c         |    4 ++++
>    sound/drivers/mpu401/mpu401.c |    4 ++++
>    sound/drivers/mtpav.c         |   14 +++++++++-----
>    sound/drivers/serial-u16550.c |    4 ++++
>    sound/drivers/virmidi.c       |    4 ++++
>    sound/ppc/powermac.c          |   14 +++++++++-----
>    7 files changed, 43 insertions(+), 15 deletions(-)

This is inserting lots of duplicate and control heavy code.
It looks like the same pattern and is using just platform_xxx funxtions.

Any counter-examples with a different pattern, which you converted in
a different manner?

Wouldn't it be more useful to do these checks in 
platform_register_simple() and return the proper error value there?

Or just create a small helper, if this have to be done seperate.

Greg, what do you think here?


Regards

Ingo Oeser
