Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBJQXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBJQXt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 11:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBJQXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 11:23:49 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:19916 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932120AbWBJQXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 11:23:48 -0500
Date: Fri, 10 Feb 2006 11:23:12 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-reply-to: <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602101123.12299.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20060208162828.GA17534@voodoo> <43EC8F22.nailISDL17DJF@burner>
 <5a2cf1f60602100738r465dd996m2ddc8ef18bf1b716@mail.gmail.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 February 2006 10:38, jerome lacoste wrote:
>On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
>> "D. Hazelton" <dhazelton@enter.net> wrote:
>> > And does cdrecord even need libscg anymore? From having actually
>> > gone through your code, Joerg, I can tell you that it does serve a
>> > larger purpose. But at this point I have to ask - besides cdrecord
>> > and a few other _COMPACT_ _DISC_ writing programs, does _ANYONE_
>> > use libscg? Is it ever used to access any other devices that are
>> > either SCSI or use a SCSI command protocol (like ATAPI)?  My point
>> > there is that you have a wonderful library, but despite your
>> > wishes, there is no proof that it is ever used for anything except
>> > writing/ripping CD's.
>>
>> Name a single program (not using libscg) that implements user space
>> SCSI and runs on as many platforms as cdrecord/libscg does.
>
>I have 2 technical questions, and I hope that you will take the time
>to answer them.
>
>1) extract from the README of the latest stable cdrtools package:
>
>        Linux driver design oddities
> ****************************************** Although cdrecord supports
> to use dev=/dev/sgc, it is not recommended and it is unsupported.
>
>        The /dev/sg* device mapping in Linux is not stable! Using
> dev=/dev/sgc in a shell script may fail after a reboot because the
> device you want to talk to has moved to /dev/sgd. For the proper and
> OS independent dev=<bus>,<tgt>,<lun> syntax read the man page of
> cdrecord.
>
>My understanding of that is you say to not use dev=/dev/sgc because it
>isn't stable. Now that you've said that bus,tgt,lun is not stable on
>Linux (because of a "Linux bug") why is the b,t,l scheme preferred
>over the /dev/sg* one ?
>
>
>2) design question:
>
>- cdrecord scans then maps the device to the b,t,l scheme.
>- the libsg uses the b,t,l ids in its interface to perform the
> operations
>
>So now, if cdrecord could have a new option called -scanbusmap that
>displays the mapping it performs in a way that people can parse the
>output, I think that will solve most issues.
>
>cdrecord already has this information available, it just doesn't
> display it:
>
>$ cdrecord debug=2 dev=ATAPI -scanbus 2>&1 | grep INFO
>INFO: /dev/hdc, (host0/bus1/target0/lun0) will be mapped on the
>schilly bus No 0 (0,0,0)
>INFO: /dev/hdd, (host0/bus1/target1/lun0) will be mapped on the
>schilly bus No 0 (0,1,0)

And here I'd call the -scanbus output broken, extremely so, and in a 
manner that makes all of your arguments rather specious.  I've tried to 
stay the hell out of this thread because its clearly a pissing match 
between some with excessive ego's, but this example requires an answer.

[root@coyote]# cdrecord debug=2 dev=ATAPI -scanbus 2>&1 | grep INFO
INFO: /dev/hdd, (host0/bus1/target1/lun0) will be mapped on the schilly 
bus No 0 (0,1,0)
INFO: /dev/hdc, (host0/bus1/target0/lun0) will be mapped on the schilly 
bus No 0 (0,0,0)
INFO: /dev/hda, (host0/bus0/target0/lun0) will be mapped on the schilly 
bus No 1 (1,0,0)

The above make very little sense, and argues against Jorg's assertions 
that his way is the 'correct' way.

Since when in the hello is /dev/hda NOT the first device in this 
so-called mapping scheme? 

This is clearly broken, but I have no trouble at all burning whatever I 
want to burn when using /deb/hdc at the target in k3b.

True, cdrecord does place that target at 0,0,0 but that has to be 
because of some mechanation in the cdrecord code to defeat what really 
should be common sense that says /dev/hdc SHOULD be 1,0,0 as its the 
first device found on the 2nd buss(or cable as some would call it).

Now, take this next as a users statement, not from the point of a coder 
although I have written some in past decades when the machinery was a 
little simpler.  Now I'm just an old codger user at 71.

So how Jorg, can you justify your reticence to make use of a system that  
linux has, and which clearly works now since very close to the 2.6 
kernel series transition?  Your constant harping on how solaris does it 
is as distastefull as some winderz dweeb coming in here to try and 
evangelize windows use.  This IS linux, and our numbers probably exceed 
solaris users by a factor of at least 10.  We're here, and unless a 
buss hits Linus and no similar minded person is named as his successor, 
get over it.  You are drasticly outnumbered.

We just want it to work and we don't care about your mostly FUD, often 
silly, usually specious/empty arguments because no facts are ever 
stated more than once over a given 5 year period.  We are all in your 
view expected to have photographic memory.  Not guilty here, we do have 
other concerns in life.

>It could perform in the following way:
>
>$ cdrecord dev=ATAPI  -scanbusmap
>...
>
>0,0,0 <= /dev/hdc
>0,1,0 <= /dev/hdd
>
>
>Are you accepting such a patch?
>
>Jerome

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
