Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310488AbSCRH3Y>; Mon, 18 Mar 2002 02:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311229AbSCRH3O>; Mon, 18 Mar 2002 02:29:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5643 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310334AbSCRH25>;
	Mon, 18 Mar 2002 02:28:57 -0500
Message-ID: <3C959716.6040308@mandrakesoft.com>
Date: Mon, 18 Mar 2002 02:28:22 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Altaparmakov <aia21@cam.ac.uk>
CC: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <3C945A5A.9673053F@zip.com.au> <5.1.0.14.2.20020317131910.0522b490@pop.cus.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov wrote:

> We don't need fadvise IMHO. That is what open(2) is for. The streaming 
> request you are asking for is just a normal open(2). It will do read 
> ahead which is perfect for streaming (of data size << RAM size in its 
> current form).
>
> When you want large data streaming, i.e. you start getting worried 
> about memory pressure, then you want open(2) + O_DIRECT. No caching 
> done. Perfect for large data streams and we have that already. I agree 
> that you may want some form of asynchronous read ahead with passed 
> pages being dropped from the cache but that could be just a open(2) + 
> O_SEQUENTIAL (doesn't exist yet).
>
> All of what you are asking for exists in Windows and all the semantics 
> are implemented through a very powerful open(2) equivalent. I don't 
> see why we shouldn't do the same. It makes more sense to me than 
> inventing yet another system call...



I disagree, and here's the main reasons:

* fadvise(2) usefulness extends past open(2).  It may be useful to call 
it at various points during runtime.

* I think putting hints in open(2) is the wrong direction to go.  Hints 
have a potential to be very flexible.  open(2) O_xxx bits are not to be 
squandered lightly, while I see a lot more value in being a little more 
loose and free with the bit assignment for an "fadvise mask" (just a 
list of hint bits).  IMO it should be easier to introduce and retire 
hints, far easier than O_xxx flags.

    Jeff




