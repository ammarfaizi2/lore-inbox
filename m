Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTLWIhj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265049AbTLWIhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:37:39 -0500
Received: from main.gmane.org ([80.91.224.249]:6345 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264953AbTLWIhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:37:37 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: Re: synaptics mouse jitter in 2.6.0
Date: Tue, 23 Dec 2003 03:37:43 -0500
Message-ID: <pan.2003.12.23.08.37.38.378082@voxel.net>
References: <Pine.LNX.4.58.0312222127530.18261@localhost.localdomain> <200312222238.17076.dtor_core@ameritech.net> <200312230241.52168.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 02:41:49 -0500, Dmitry Torokhov wrote:

> On Monday 22 December 2003 10:38 pm, Dmitry Torokhov wrote:
>> On Monday 22 December 2003 09:40 pm, Thomas Molina wrote:
>> > I am running Fedora Core 1 updated on a Presario 12XL325 laptop.  For
>> > a long time during the 2.5 series I couldn't use the synaptics
>> > support. As a result, I haven't tested this for some time.  I just
>> > compiled a fresh 2.6.0 tree, included synaptics support and now I am
>> > getting mouse jitter.
>> >
> <..SKIP..>
>>
>> Right, I think I see it. The mousedev module does not do any smoothing
>> of the reported coordinates which would cause the jitter you are
>> seeing. Normally drivers do 3- or 4-point average.
>>
>> I'll cook up something to fix it. Meanwhile could you give a try Peter
>> Osterlund XFree86 Synaptics driver:
>> http://w1.894.telia.com/~u89404340/touchpad/index.html
>>
> 
> OK, here it is. It will apply against 2.6.0 although will complain about
> some offsets as I have extra stuff in my tree...
> 
> Dmitry
> 
[...]

This works a lot better than both -mm1 and stock 2.6.0's mouse behavior
for me; 2.6.0 likes to drop packets inside the interrupt handler and make
the mouse jump to the edge of the screen, and 2.6.0-mm1 likes to move the
pointer between the time I take my finger off the touchpad and hit the
mouse button.  This appears to fix both issues; however, I still see the
following in logs:

Dec 23 03:33:53 spiral kernel: Synaptics driver lost sync at byte 4
Dec 23 03:33:53 spiral kernel: Synaptics driver lost sync at byte 1
Dec 23 03:33:53 spiral kernel: Synaptics driver resynced.
Dec 23 03:33:55 spiral kernel: Synaptics driver lost sync at byte 1
Dec 23 03:33:55 spiral last message repeated 4 times
Dec 23 03:33:55 spiral kernel: Synaptics driver resynced.



