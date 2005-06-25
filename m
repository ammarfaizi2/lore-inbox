Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVFYTNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVFYTNm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 15:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVFYTNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 15:13:42 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:1229
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261248AbVFYTN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 15:13:28 -0400
Message-ID: <42BD9EBD.8040203@linuxwireless.org>
Date: Sat, 25 Jun 2005 13:13:17 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Paul Sladen <thinkpad@paul.sladen.org>, linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>,
       "'Vojtech Pavlik'" <vojtech@suse.cz>, borislav@users.sourceforge.net,
       "'Yani Ioannou'" <yani.ioannou@gmail.com>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [ltp] IBM HDAPS Someone interested? (Accelerometer)
References: <1119559367.20628.5.camel@mindpipe> <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net> <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>
>  
>
>>>Yup, it's just doing port IO.  Get a kernel debugger for windows like
>>>softice and this will be trivial to RE.
>>>READ_PORT_USHORT / WRITE_PORT_UCHAR / READ_PORT_UCHAR
>>>      
>>>
>>There are 3 ports involved.  The 0xed "non-existant delay port" and a pair
>>of ports that are through the Super-I/O / IDE.  They are used in a
>>index+value setup similar to reading/writing the AT keyboard
>>    
>>
>>>controller.
>>>      
>>>
>
>I think you got it... 2ports seem like enough for some kind of small
>u-controller...
>
>  
>
>>>From what I remember, my conclusion was that these instructions were the
>>ones to park the heads and then lock the IDE bus.  It's a couple of months
>>ago, but somewhere I have the simplified version of what it was doing...
>>    
>>
>
>Don't think so... parking heads will go through IDE layer...
>								Pavel
>
>  
>
I have a question here, how do you guys think that the head is parked, 
is it done by the controller directly, which then sends the command to 
the HD to park the head, or this is done by the operating system in some 
kind of way?

I think the OS or user space is too slow like to react to send a park 
command to the hard drive, so this most be done directly by the embedded 
controller, but still I think it needs some input from the OS, to 
initialize it's settings. i.e. after all, in windows you do have the 
settings in the software for HDAPS, but it looks like it is _not_ 
managed by the operating system at all if there is some type of action 
to  be taken. This is also probably why HDAPS won't kick in until 
booted, and that is because it needs to load its config setup by the 
software.

This is what I think, please correct me if I'm saying something crazy.


OS booted, sends settings to the controller, if settings changed, the OS 
will send the settings again to the controller. -> once the controller 
has the configuration from the user, which is in Windows, loaded by 
default, then the controller reacts depending on it's output from the 
accelerometer, sending inmediate commands or parking the head of the HD.

Then also, the OS is either notified about the movement, or actually it 
starts reading from the controller, for example, when doing the 3D view.

The 3D view software takes some time loading, if it would be normally 
monitoring, then It wouldn't take the 4 seconds it takes. I think the OS 
only reads to give the user a clue of their nice feature, but is all 
really done with the controller-> HD.

After all, IBM testing says that HDAPS worked perfectly from a 70cm fall.

.Alejandro

