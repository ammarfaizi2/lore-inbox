Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWCTMqW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWCTMqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWCTMqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:46:22 -0500
Received: from s93.xrea.com ([218.216.67.44]:42883 "HELO s93.xrea.com")
	by vger.kernel.org with SMTP id S932264AbWCTMqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:46:21 -0500
Message-Id: <200603201245.AA00848@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
Date: Mon, 20 Mar 2006 21:45:43 +0900
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Jim Crilly <jim@why.dont.jablowme.net>, linux-kernel@vger.kernel.org
Subject: Re: Faster resuming of suspend technology.
From: Jun OKAJIMA <okajima@digitalinfra.co.jp>
In-Reply-To: <200603130907.03944.ncunningham@cyclades.com>
References: <200603130907.03944.ncunningham@cyclades.com>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> But you have to read all of the pages at some point so the hard disk is
>> going to be the bottleneck no matter what you do. And since Suspend2
>> currently saves the cache as a contiguous stream, possibly compressed, it
>> should be a good bit faster than seeking around the disk loading the files
>> from the filesystem.
>
>Agreed.
>

First, sorry for delaying to reply. I needed time to consider.
The conclusionis, "I also agree".
BTW, this discussion continues in CK list also.
If folks have interest about faster resuming with background swap reading,
check CK list. Of course, I agree the CK list discussion also. Background
reading for suspend image is almost same as what I imagined when I posted
first. Although I am not sure about the implementation, like that extending
swap prefetch feature or such is the best way or not.



>> > >> Especially, your way has problem if you boot( resume ) not from HDD
>> > >> but for example, from NFS server or CD-R or even from Internet.
>> > >
>> > >Resuming from the internet? Scary. Anyway, I hope I'll understand better
>> > > what you're getting at after your next reply.
>> >
>> > In Japan, it is not so scary.
>> > We have 100Mbps symmetric FTTH ( optical Fiber To The Home), and
>> > more than 1M homes have it, and price is about 30USD/month.
>> > With this, theoretically you can download 600MB ISO image in one min,
>> > and actually you can download 100MBytes suspend image within 30sec.
>> > So, not click to run (e.g. Java applet) but "click to resume" is not
>> > dreaming but rather feasible. You still think it is scary on this
>> > situation?
>>
>> I don't think the scary part is speed, but security. I for one wouldn't
>> want to resume from an image hosted on a remote machine unless I had some
>> way to be sure it wasn't tampered with, like gpg signing or something.
>
>Another issues is that at the moment, hotplugging is work in progress. In 
>order to resume, you currently need the same kernel build you're booting 
>with, and the same hardware configuration in the resumed system. As hotplug 
>matures, this restriction might relax, and we could probably come up with a 
>way around the former restriction, but at the moment, it really only makes 
>sense to try to resume an image you created using the same machine.
>

Wait, wait. Let make it clear that what we are discussing.

For me, the theme is "faster resuming with suspend technology", not swsusp2.
I mean, in this point of view, the most practical candidate for now would be
Xen suspend, not swsusp2. Of course, hotplugging once comes, swsusp2 will be
a good candidate also, and hopefully what I call "generic suspend image"
would be possible.

I admit that Jim Crilly's concern is right, but with using Xen suspend,
it can be solved very easily. What you do is just like this:
[Xen DOM0]# wget http://www.geocity.com/1235089/suspend_image/debian.image
[Xen DOM0]# gpg --verify debian.image
[Xen DOM0]# xen --resume debian.image


                 --- Okajima, Jun. Tokyo, Japan.
