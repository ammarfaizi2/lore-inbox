Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWBNCJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWBNCJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 21:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWBNCJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 21:09:41 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:22509 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750924AbWBNCJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 21:09:40 -0500
Message-ID: <43F13BDF.3060208@cfl.rr.com>
Date: Mon, 13 Feb 2006 21:09:35 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Alan Stern <stern@rowland.harvard.edu>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Flames over -- Re: Which is simpler?
References: <Pine.LNX.4.44L0.0602131601220.4754-100000@iolanthe.rowland.org> <43F11A9D.5010301@cfl.rr.com> <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com>
In-Reply-To: <BCC8C7FA-25A2-4460-A667-5AA88BF5BC6D@mac.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> 
> No, that information is the most reliable that can be obtained.  It 
> tells us that we can no longer make any guarantees about the device or 
> its state.  The USB spec is quite clear on this point.
> 

That is what it says but the kernel is interpreting it as "this device 
HAS been removed" rather than "this device MAY have been removed".  That 
is wrong and should be fixed.

> 
> Except we can't reliably decide that.  Say I plug my USB camera in, 
> mount it, and download some pictures.  I then suspend the computer, 
> unplug the camera after suspending, take more pictures, plug it back in 
> and resume.  That's a fairly reasonable situation and the computer 
> considering the camera's state to be unchanged would be a serious bug 
> and probably result in data loss.  By contrast, just considering the 
> camera to be spontaneously unplugged would cause no more data loss than 
> actually spontaneously unplugging the flash drive.
> 

But again, that would be user error and thus, the data loss can not be 
avoided and is their fault.  Having data loss result from user error is 
far more acceptable than having data loss ALLWAYS result from a 
perfectly acceptable user action, namely hibernating the machine and 
resuming it some time later without altering anything.  You already 
teach users not to unplug the drive without ejecting it from the desktop 
first, why should you also force them to eject before hibernating?

> 
> This is why hardware suspend is a good thing.  When I suspend and resume 
> my laptop, there are _no_ USB disconnects.  The controller puts all the 
> hubs into low-power mode, but it never disconnects them or causes problems.
> 

That's fantastic for your system, but not all systems will maintain 
standby power to USB, and users expect to be able to suspend to disk and 
not loose data, just like they do with non USB drives.

> 
> No, you have this wrong.  The USB spec indicates that the device _HAS_ 
> changed and all old state should be thrown away (even the address).  
> There is no way around that issue.  USB was designed to support hardware 
> suspend; you can put all the hardware in low-power mode and still be 
> able to detect changes.

That's great, except that feature is not always used so you must be able 
to live without it.  The fact that the hardware flag is set is no 
indication that the hardware HAS changed, you said so yourself; all it 
knows is that the bus/device lost power.  The use case we are talking 
about is one in which power loss happens, but the device is still the 
same, and so access to it should not be interrupted.

> 
> In fact, I would argue that turning off all the busses completely when 
> you want to maintain a connection to a device is broken.  If you want to 
> maintain the connection, you should keep the busses powered.  Otherwise, 
> according to the USB spec, it's the _kernel_ that is terminating the 
> connection, and assuming that it exists after explicitly terminating it 
> is wrong.
> 

Yes, assuming that it exists is wrong.  Probing the hardware and seeing 
that it exists and is _probably_ the same device is entirely different. 
  In that case it is preferable to assume the probable case rather than 
the improbable one because it will lead to less data loss.



