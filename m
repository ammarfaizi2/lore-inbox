Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUL0XOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUL0XOZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 18:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbUL0XOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 18:14:24 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:64728 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S261996AbUL0XAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 18:00:55 -0500
Message-ID: <41D0942B.8020109@penguincomputing.com>
Date: Mon, 27 Dec 2004 15:00:59 -0800
From: Philip Pokorny <ppokorny@penguincomputing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LM Sensors <sensors@Stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
CC: Greg KH <greg@kroah.com>
Subject: Re: [RFC] I2C: Remove the i2c_client id field
References: <20041227230402.272fafd0.khali@linux-fr.org>
In-Reply-To: <20041227230402.272fafd0.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So only the drives I wrote use the ID in a meaningful way?

What do you propose to replace the ID value in the debug messages with? 
 Ideally it would be the things you mention that uniquely identify the 
chip in question (bus number and address)

How hard are those values to get at?  Do we have to chase possibly NULL 
pointers?

:v)

Jean Delvare wrote:

>Hi Greg, hi all,
>
>While porting various hardware monitoring drivers to Linux 2.6 and
>otherwise working on i2c drivers in 2.6, I found that the i2c_client
>structure has an "id" field (of type int) which is mostly unused. I am
>not exactly sure why it was introduced in the first place, and since the
>i2c subsystem code was significantly reworked since, it might not
>actually matter.
>
>Most hardware monitoring drivers allocate a unique (per driver) id
>through an incremented static global variable, and never use it. Some
>(lm85 and most notably adm1026) use the value in debug messages. I saw
>various video drivers appending the id value to the client name between
>square brackets, while others would set the id field to -1 and then
>leave it alone. The i2c core itself doesn't use this field.
>
>Using this field to identify a client doesn't make much sense to me, for
>the following reasons:
>
>1* A client is already uniquely identified by the combination of the
>number of the bus it sits on and the address it is located at on this
>bus.
>
>2* With the implementation described above, the id will possibly change
>depending on which i2c bus drivers are loaded and the order they were
>loaded in. As a consequence, you can't rely on its value from
>user-space, and its usability in kernel-space isn't obvious either.
>
>3* As a matter of fact, no driver in the kernel tree uses this field
>except for debugging (and even then with no obvious benefit), with only
>a few exceptions where I could easily change the code so it wouldn't
>need this field anymore.
>
>Thus, I propose that we simply get rid of this field, so as to save some
>memory space and kill some useless code. If anyone really ever needs to
>carry some sort of id attached to an i2c_client structure, this is
>private data and can be added to whatever structure the data field is
>pointing to for this particular driver.
>
>Unless someone objects with valid reasons, I am going to send patches to
>kill the i2c_client id field. I have everything ready, but don't know
>exactly how I should send them. The difficulty comes from the relatively
>large number of affected drivers (50) and the fact that they spread over
>very different subsystems (the big ones are i2c and media/video, plus
>half a dozen drivers in acorn/char, macintoch and sound).
>
>Greg, can you tell me if you would take such a patch, and how I would
>have to split it for you to accept it?
>
>Thanks,
>  
>


