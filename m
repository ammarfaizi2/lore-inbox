Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbTEGPoE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbTEGPoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:44:04 -0400
Received: from mail.convergence.de ([212.84.236.4]:63379 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264057AbTEGPoA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:44:00 -0400
Message-ID: <3EB92CB1.7050400@convergence.de>
Date: Wed, 07 May 2003 17:56:33 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
References: <3EB7DCF0.2070207@convergence.de> <20030506214918.A18262@infradead.org> <3EB8CFA2.5090405@convergence.de> <20030507102857.C14040@infradead.org>
In-Reply-To: <20030507102857.C14040@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph, Linus,

>>The code does not behave differently. If DVB_DEVFS_ONLY is set, then the 
>>old chardev register interface is omitted.

> Which is a different behaviour, now you can't create a device node
> manually anymor.

I won't insist on keeping code that I haven't written. My only point is 
that we use the code in set-top-boxes, where every byte is valuable. But 
  I suspect that there are numerous other places where we could safe 
bytes... 8-)

 >  Also note that the feature you rely on here (devfs
 > presetting file->private_data) will go away in the next round of
 > patches,
 > see Al Viro's patchit for a generic replacement that works with or
 > without devfs.

Ok.

>>There is a functional dependency between the dvb-core and the actual dvb 
>>driver. So there is no need to increase the module count of the dvb-core 
>>if a new adapter is registered IMHO, because you cannot unload the 
>>dvb-core before the driver anyway.

> Okay, you're right I should have read more of the code to get the global
> picture.  You still wan't an owner field for at least struct dvb_device
> device, though - but the try_module_get must go into dvb_generic_open
> and maybe in more other places where you use the "backend" modules.

I don't get that, sorry. The backend modules have functional 
dependencies and register/deregister upon loading/unloading. There is 
never a call from the dvb-core to the backend modules. Do I really need 
an owner field then?

CU
Michael.



