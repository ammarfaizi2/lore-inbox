Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130738AbQKGJzv>; Tue, 7 Nov 2000 04:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130822AbQKGJzm>; Tue, 7 Nov 2000 04:55:42 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:26116 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130738AbQKGJz3>; Tue, 7 Nov 2000 04:55:29 -0500
Message-ID: <3A07D199.8F9EFFD1@idb.hist.no>
Date: Tue, 07 Nov 2000 10:55:37 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Oliver Xymoron <oxymoron@waste.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <E13steH-0006cy-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > It would probably be better (in this case) to increment the module count
> > when the mixer settings go above 0, and decrement it when the settings
> > go totally to 0.  This prevents an unwanted unload.
> 
> Thats about 200 lines of code and also about 50,000 emails complaining people
> cannot unload sound stuff.

Still, it is so logical.  Modules cannot be unloaded when in use.
"use" is usually "someone having the device open".  But
"someone listening to pass-through sound" is effectively using
the mixer - the module is in use in another way.  Network drivers
don't have a /dev/xxx to open/close either.

Having to turn off the master volume before unloading makes sense
to me.  (The driver may still free up DMA buffers when
nobody need them, i.e. when /dev/dsp haven't been used for some time.)


Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
