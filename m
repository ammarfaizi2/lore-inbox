Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWFLOQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWFLOQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbWFLOQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:16:08 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:14139 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752001AbWFLOQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:16:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HwFlRvM8KbfkEaDA6O8h/0YzmzviwVJ1ud7KmKz5M+ZhvcxzD2z1859rF64vO2lwlDtW+D7dPYqcKWSIoGn5WhjtWeYNdq2YIOq0McmH4tW+51Gdc8KfNDZ7rhqE6UhWT4PRn5/OuR/NX2BkX2yIvAYJvtxn6fsnX5UhbGpUuDw=
Message-ID: <448D7716.5070205@gmail.com>
Date: Mon, 12 Jun 2006 22:15:50 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Knut Petersen <Knut_Petersen@t-online.de>, hramrach@centrum.cz
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>	<448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>	<448D5B4F.5080504@gmail.com> <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
In-Reply-To: <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Suchanek wrote:
> On 6/12/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>> Non-experimental behaviour really should be to allow unbinding
>>> only if the framebuffer driver allows it. The fbcon and vt layer simply
>>> does not know if it is safe, and thus they have to interrogate the
>>> hardware layer that knows the answer.
>>>
>>> Your current proposal is to allow unbinding and removal of the framebuffer
>>> driver and the fbcon layer, no matter what the result will be. I don´t think
>>> that this is ok.  There is  John User that tries to switch to text mode, and
>>> he will complain if it does leave his hardware in an unusable state.
>> This I disagree with you.  The view that an operation should be totally
>> done 100% within the kernel is very utopic.  We already have features that
>> require both the kernel and userspace for them to work. The nearest example
>> is suspend/resume. It's good if you can make suspend/resume work without
>> additional effort, but that's not the case. Majority of users still need
>> utilities such as vbetool.
> 
> Well, I guess that the fb driver should try to restore the original
> mode (ie text mode on x86) on unload. And it is either considered
> flawed if it doesnt or it should indicate somewhere that it does not
> know how to unload itself.

Well, failure to implement proper suspend and resume by a driver does not
stop the entire suspend/resume process, does it? Even if it results
in a blank screen. It doesn't because we have a userspace options and
tools that complements the kernel side. So why should it be any different
in this case? 

Some drivers, i810fb and rivafb, saves the hardware state on the
first open, and restores the hardware state on the last close. This
is usually sufficient for them to restore the hardware to VGA text
mode on unload. It would be nice if we can implement something like this
for all drivers, but failure to do so should not be a reason to stop the
entire process.

> I like the possibility to change X resolution using fbset (from inside
> X). I use it to correct problems caused by crashed X programs that
> change resolution. But I run X with the UseFbDev option. The X server
> would be probably quite unhappy if I removed the fb driver but since
> it uses the fb device the driver should not unload.

If X is using fbdev, then X is also holding a reference count on the
driver.  And the driver will not unload even if you try to.

Tony
