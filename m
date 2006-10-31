Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423456AbWJaOyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423456AbWJaOyt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423458AbWJaOyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:54:49 -0500
Received: from 195-13-16-24.net.novis.pt ([195.23.16.24]:22507 "EHLO
	bipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1423456AbWJaOys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:54:48 -0500
Message-ID: <454763B5.1050204@grupopie.com>
Date: Tue, 31 Oct 2006 14:54:45 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Franck <vagabon.xyz@gmail.com>
CC: Miguel Ojeda <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 full] drivers: add LCD support
References: <20061013023218.31362830.maxextreme@gmail.com>	 <45364049.3030404@innova-card.com> <453C8027.2000303@innova-card.com>	 <653402b90610230556y56ef2f1blc923887f049094d4@mail.gmail.com>	 <453CE85B.2080702@innova-card.com>	 <653402b90610230908y2be5007dga050c78ee3993d81@mail.gmail.com>	 <cda58cb80610231015i4b59a571kaea5711ae1659f0d@mail.gmail.com>	 <653402b90610260755t75b3a539rb5f54bad0688c3c1@mail.gmail.com>	 <cda58cb80610271303p29f6f1a2vc3ebd895ab36eb53@mail.gmail.com> <653402b90610271325l1effa77eq179ca1bda135445@mail.gmail.com> <4545C52A.5010105@innova-card.com> <4545FCB1.8030900@grupopie.com> <45470513.4070507@innova-card.com>
In-Reply-To: <45470513.4070507@innova-card.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Franck Bui-Huu wrote:
> Paulo Marques wrote:
>> Franck Bui-Huu wrote:
>>> An application might want to display quickly a set of images, not for
>>> doing animations but rather displaying 'fake' greyscale images.
>>
>> To do "fake" greyscale you would need to synchronize with the actual
>> refresh of the controller or you will have very ugly aliasing artifacts.
>>
>> Since there is no hardware interface to know when the controller is
>> refreshing, I don't think this is one viable usage scenario.
> 
> eh ?? Did you read my email before ? That was the point I was trying
> to raise... and starting the refresh stuff _only_ when the device is
> mmaped seems to me a good trade off.

I think we are violently agreeing about the optimal way of doing things.

But maybe I didn't explain my point about the "fake" greyscale in the 
best way, though.

There are two distinct "refresh"'s involved here: one is when the driver 
writes its software buffer into the display internal memory using the 
parallel port interface.

The other is when the actual display controller refresh that goes 
through all the common lines, etc., using the values on its internal 
memory to update the segment voltages.

The problem is that there is no way to know about the internal refresh 
that the controller does. So if you update its memory very frequently to 
try to produce a "fake" greyscale image, your updates will alias with 
the refresh rate of the actual display controller and you will see all 
sorts of strange effects on the display.

> Aynywas it seems that the discusion about the design is closed and
> won't lead to interesting things...

Only because we're mostly in agreement about what should be done ;)

But if you have other interesting things to suggest, I haven't seen 
Miguel reject any suggestions by other developers, yet (very much on the 
contrary, to be honest).

-- 
Paulo Marques
Software Development Department - Grupo PIE, S.A.
Phone: +351 252 290600, Fax: +351 252 290601
Web: www.grupopie.com

"The face of a child can say it all, especially the
mouth part of the face."
