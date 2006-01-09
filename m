Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWAIUhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWAIUhu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWAIUhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:37:50 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:51945 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751322AbWAIUht convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:37:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uDaM7yMWTIjR5jF3rzuZwVGoG4tYz5T1i+wzhsGXXTbRYpk3O3uuToL/zeJ5T37WfwLqh01t5hGaOr9e0x4He5b2JdzFmoTu/0rddsSWZlw+ovNBF2MkaoqIfdTiBAZQzHzfhNPYOX36c7kJIM5wCzA2TydBQWjevizrnQVf9vU=
Message-ID: <9a8748490601091237s57071e57mbd2c4172a0e4dd@mail.gmail.com>
Date: Mon, 9 Jan 2006 21:37:49 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Mouse stalls (again) with 2.6.15-mm2
Cc: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 12/21/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On 12/11/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > On 12/11/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > >
> > > > To stop resync attempts do:
> > > >
> > > >         echo -n 0 > /sys/bus/serio/devices/serioX/resync_time
> > > >
> > > > where serioX is serio port asociated with your mouse.
> > > >
> > > This cures the problem nicely with no obvious ill effects with the
> > > mouse plugged into the KVM...
> > >
> >
> > Jesper,
> >
> > Could you please try applying the attached patch to -mm and see if you
> > still have "resync failed" messages when you don't "echo 0" into
> > resync_time attribute?
> >
> I applied the patch to 2.6.15-rc5-mm3, took out the "echo 0 to
> resync_time" workaround that I had in rc.local and I no longer see the
> "resync failed" messages in dmesg.
> With this patch applied everything seems to be working OK with the
> mouse attached to the KVM.
>

Hi Dmitry,

I'm sorry to report that this problem made a comeback :-(
With 2.6.15-mm2 I again get the mouse stalls and these messages in dmesg :

[   64.351000] psmouse.c: resync failed, issuing reconnect request
[   94.210000] psmouse.c: resync failed, issuing reconnect request
[  132.850000] psmouse.c: resync failed, issuing reconnect request
[  148.498000] psmouse.c: resync failed, issuing reconnect request
[  185.414000] psmouse.c: resync failed, issuing reconnect request
[  220.509000] psmouse.c: resync failed, issuing reconnect request
[  375.436000] psmouse.c: resync failed, issuing reconnect request
[  406.410000] psmouse.c: resync failed, issuing reconnect request
[  419.382000] psmouse.c: resync failed, issuing reconnect request
[  432.016000] psmouse.c: resync failed, issuing reconnect request
[  448.275000] psmouse.c: resync failed, issuing reconnect request
[  462.244000] psmouse.c: resync failed, issuing reconnect request
[  477.461000] psmouse.c: resync failed, issuing reconnect request
[  490.851000] psmouse.c: resync failed, issuing reconnect request
[  533.566000] psmouse.c: resync failed, issuing reconnect request
[  563.348000] psmouse.c: resync failed, issuing reconnect request
[  580.606000] psmouse.c: resync failed, issuing reconnect request
[  620.961000] psmouse.c: resync failed, issuing reconnect request
[  639.404000] psmouse.c: resync failed, issuing reconnect request
[  690.256000] psmouse.c: resync failed, issuing reconnect request
[  698.772000] psmouse.c: resync failed, issuing reconnect request
[  716.679000] psmouse.c: resync failed, issuing reconnect request

2.6.15 is fine.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
