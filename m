Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268195AbUHKVGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268195AbUHKVGH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268222AbUHKVGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:06:07 -0400
Received: from mail1.srv.poptel.org.uk ([213.55.4.13]:29403 "HELO
	mail1.srv.poptel.org.uk") by vger.kernel.org with SMTP
	id S268195AbUHKVGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:06:01 -0400
Message-ID: <411A89BB.60505@phonecoop.coop>
Date: Wed, 11 Aug 2004 22:03:55 +0100
From: Alan Jenkins <sourcejedi@phonecoop.coop>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cd burning: kernel / userspace?
References: <41189AA2.3010908@phonecoop.coop> <20040810220528.GA17537@animx.eu.org> <4119DFB0.6050204@phonecoop.coop> <20040811164109.GA18761@animx.eu.org>
In-Reply-To: <20040811164109.GA18761@animx.eu.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>Some good awkward questions there :). 
>>    
>>
>
>Yup =)
>
>  
>
>>I agree that cdrwcontrol/dd seems silly.  I think you would still want 
>>to use a commandline tool like cdrecord.
>>    
>>
>
>I dunno, with all the talk about the dev=x,y,z stuff.  I'm kinda used to it,
>but why the hell should I have to -scanbus everytime I decide to use a usb
>cdrw/dvdrw?  Even using /dev, it's still interesting since I don't use udev
>right now.  The way that 2.6 does things is rather nice.  I wish I could do
>that on 2.4 with my usb hard drive.
>
>back to the point.  A cdrwcontrol/dd script wouldn't be so bad.  I know how
>they hate things to be in the kernel, but somethings just don't work well in
>user space
>  
>
A script would be cool, but dd doesn't do the memory locking and real 
time priority stuff.  I don't know how important this is - how old your 
hardware would have to be for you to get "coasters" (buffer underun) 
without it.

>>I need to get to know the technical details better - I understand the 
>>instances you listed from the users point of view, but not from the 
>>point of view of what gets written to the disk and how.
>>    
>>
>
>I had ideas about that...  If you're burning one session, it would be easy
>to have the driver prepare the disk, count the amount of data and once the
>device is closed, it can do the fixate.  Userspace is freed up at this point
>and it can optionally eject the disk.  Just depending on the options
>presented.
>
>It would get a bit cumbersom to do data/audio (or just audio) if you don't
>do dao.  Maybe it would be better to have a cdrwtool that once it sets up
>the ioctls, it can read a stream (stdin or a file) and basically be
>cdrecord.  However, it won't have to drive the cdrw.
>
>  
>
Theres an option in cdrecord to fixate an arbitrary disk (one without a 
TOC for whatever reason), and one not to fixate the disk you're writing, 
so it looks like fixation could and should be done on demand using an 
ioctl.  You'd also need ioctls to deal with multiple sessions.

I think most people would want a cdrwtool that basically pretends to be 
cdrecord (in some ways ;), because thats the most intuitive way to do it 
- even if you can do everything you want to with cdrwtool for the ioctls 
and dd for the data.

I've definitely underestimated the problems with my idea, and I can't 
see any tangible benefits which couldn't be obtained by hacking 
cdrecord.  Idealistically, its the right thing to do - but in practice 
its unessecary, I'm not up to the job, and its not attractive enough for 
someone to pick up.  After packet writing is seamlessly merged into the 
uniform cdrom driver it might start looking more important, and I might 
have learnt enough to at least implement a proof of concept.  I'm still 
interested in hashing out more details and potential benefits.
