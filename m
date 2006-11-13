Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWKMVOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWKMVOh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933049AbWKMVOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:14:37 -0500
Received: from kurby.webscope.com ([204.141.84.54]:54213 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932476AbWKMVOg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:14:36 -0500
Message-ID: <4558DF23.5080207@linuxtv.org>
Date: Mon, 13 Nov 2006 16:09:55 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: =?ISO-8859-1?Q?Jos=E9_Su=E1rez?= <j.suarez.agapito@gmail.com>,
       linux-dvb@linuxtv.org, Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "pasky@ucw.cz" <pasky@ucw.cz>,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>
Subject: Re: [linux-dvb] Avermedia 777 misbehaves after remote hack merged
 into v4l-dvb tree
References: <200611131711.46626.j.suarez.agapito@gmail.com> <45589E2E.7070304@linuxtv.org> <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611130842010.22714@g5.osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 13 Nov 2006, Michael Krufky wrote:
>> Mauro -- that patch needs fixing / more testing before it goes to mainstream...
>>
>> Could you please remove that changeset from your git tree before Linus pulls it?
> 
> Too late. Already pulled and pushed out.
> 
> Looking at the patch, one obvious bug stands out: the new case statement 
> for SAA7134_BOARD_AVERMEDIA_777 doesn't have a "break" at the end.
> 
> José, can you test this trivial patch and see if it fixes things?
> 
> 		Linus
> 
> ---
> diff --git a/drivers/media/video/saa7134/saa7134-input.c b/drivers/media/video/saa7134/saa7134-input.c
> index 7f62403..dee8355 100644
> --- a/drivers/media/video/saa7134/saa7134-input.c
> +++ b/drivers/media/video/saa7134/saa7134-input.c
> @@ -202,6 +202,7 @@ int saa7134_input_init1(struct saa7134_d
>  		/* Without this we won't receive key up events */
>  		saa_setb(SAA7134_GPIO_GPMODE1, 0x1);
>  		saa_setb(SAA7134_GPIO_GPSTATUS1, 0x1);
> +		break;
>  	case SAA7134_BOARD_KWORLD_TERMINATOR:
>  		ir_codes     = ir_codes_pixelview;
>  		mask_keycode = 0x00001f;


Thanks for the fix, Linus... I see that you've already pushed this into git, so
I've added it to my v4l-dvb hg development tree.

Jose, you can use this tree for testing, if you don't want to apply the patch by hand.

Mauro, please pull from:

http://linuxtv.org/hg/~mkrufky/v4l-dvb

for the following:

- saa7134: Fix missing 'break' for avermedia card case

 saa7134-input.c |    1 +
 1 file changed, 1 insertion(+)

Cheers,

Michael Krufky

