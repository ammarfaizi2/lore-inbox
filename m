Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270801AbTG0OmF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 10:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270806AbTG0OmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 10:42:05 -0400
Received: from nice-1-a7-62-147-78-242.dial.proxad.net ([62.147.78.242]:19974
	"EHLO monpc") by vger.kernel.org with ESMTP id S270801AbTG0OmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 10:42:02 -0400
From: Guillaume Chazarain <gfc@altern.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Date: Sun, 27 Jul 2003 17:00:17 +0200
X-Priority: 3 (Normal)
In-Reply-To: <200307271157.19010.kernel@kolivas.org>
Message-Id: <YWZVOVR72A8A5FQN7586LHRMFDLIW.3f23e901@monpc>
Subject: Re: [PATCH] O9int for interactivity
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
X-Mailer: Opera 6.06 build 1145
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

27/07/03 03:57:19, Con Kolivas <kernel@kolivas.org> wrote:

>On Sun, 27 Jul 2003 07:20, Guillaume Chazarain wrote:
>> Hi Con,
>>
>> Strange your activate() function in O9. Isn't it?
>> It doesn't care that much about sleep_time.
>>
>> So here is a very simple trouble maker.
>
>Yes I know it's a way to make something fairly cpu intensive remain 
>interactive. However since it sleeps long enough (2ms at 1000Hz is just 
>enough), it doesn't bring the machine to a standstill, and is easily 
>killable. I doubt it is worth working around this, but I'm open to your 
>comments about variations on this theme that might be a problem.

The previous code was a mistake. (Calling clock() before sleeping is quite dumb...)
Here is another one.  If you put the right value in MHZ, (maybe more, maybe less, I dunno),
I bet you won't get out without power cycling your box...


#include <unistd.h>

#define MHZ 450 /* Your CPU Mhz */
#define COUNT (MHZ * 1000)

#define PRIO_LEVELS 10

int main(void)
{
    int i;

    fork();
    fork();

    /* Climb all priority levels. */
    for (i = 0; i < PRIO_LEVELS; i++)
        usleep(1);

    for (;;) {
        usleep(1); /* get one point. */
        for (i = 0; i < COUNT; i++); /* lose one point. */
    }

    return 0;
}



Guillaume




