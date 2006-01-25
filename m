Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWAYQJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWAYQJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWAYQJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:09:38 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:3492 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750804AbWAYQJh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:09:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=jen8CasjAvyc2Bp/dHbDUkT0o7zh2DGAe/RBg1vk0x3CmfbpsxfFOzomVMxtB1HaVihELzdgxfvSez6Eaj+RoTqASANLve7nQFxYFWS49cLCa/C2DdUeZa8+J99nXz3gBR0t94kdWB8xU3riF6xiKgvfHPrmbblSZhPx8lw1Xrs=
Date: Wed, 25 Jan 2006 17:09:04 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: bernd@firmix.at, vonbrand@inf.utfsm.cl, linux-os@analogic.com,
       ram.gupta5@gmail.com, mloftis@wgops.com, barryn@pobox.com,
       a1426z@gawab.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-Id: <20060125170904.5e31e1e2.diegocg@gmail.com>
In-Reply-To: <20060125150516.GB8490@mail.shareable.org>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	<1138181033.4800.4.camel@tara.firmix.at>
	<20060125150516.GB8490@mail.shareable.org>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 25 Jan 2006 15:05:16 +0000,
Jamie Lokier <jamie@shareable.org> escribió:

> Mozilla / Firefox / Opera in particular.  300MB is not funny on a
> laptop which cannot be expanded beyond 192MB.  Are there any usable
> graphical _small_ web browsers around?  Usable meaning actually works
> on real web sites with fancy features.

Opera is probably the best browser when it comes to "features per byte
of memory used", so if that isn't useful....there's a minimo web browser
(http://www.mozilla.org/projects/minimo/) It's supposed to be designed
for mobile devices, but it may be usable on normal
computers.

The X server itself doesn't eat too many memory. In my box (radeon
9200SE graphic card) the X server only eats 11 MB of RAM - not too
much in my opinion for a 20-years-old code project which according
to the X developers it has many areas where it could be cleaned up.

The X server will grow its size because applications store the
images in the X server. And the X server is supposed to be
network-transparent, so apps send to the x server the data, not
a "reference to the data" (ie: a path to a file), so (i think) the
file cannot be mmap'ed to share the file in memory: there're still
some apps (or so I've heard) which send a image to the server
and keep a private copy in their own address space so the memory 
needed to store those images is *doubled* (gnome used to keep
*three* copies of the background image, one in nautilus, other
in gnome-settings-daemon and another in the X server, and
gnome-terminal keeps another copy when transparency is enabled)


Also, fontconfig allocates ~100 KB of memory per program launched.
There're patches to fix that by creating a mmap'able cache which is
shared between all the applications which has been merged in the
development version. I think there're many low-hanging fruits at
all levels, the problem is not just mozilla & friends
