Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSERNar>; Sat, 18 May 2002 09:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSERNaq>; Sat, 18 May 2002 09:30:46 -0400
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:28655 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S313157AbSERNaq>; Sat, 18 May 2002 09:30:46 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.15 IDE 62
Date: Fri, 17 May 2002 03:27:49 +0100
Message-Id: <20020517022750.10790@smtp.wanadoo.fr>
In-Reply-To: <3CE4EC29.3090205@evision-ventures.com>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>1. The fact that there are some cases where the initialization code
>doesn't necessarily go down to the host chip drivers right now.

Well, I'd rather see the init code be some kind of "lib" called
by the host driver, but well...

>2. Most of the current code...

Sure ;) Note that the real point I missed is about broken controllers
that can't grok dealing with simultaneous requests on both channels
(like cmd640) in which case, you probably need the same request
queue to serialize access to both of them. In practice, that means
more or less dealing with both channels like the same way we do
with slave vs. master.

My understanding though is that the block layer can't (yet ?) quite
deal with a single request queue for several target devices, and
it seems that the whole point of the old "busy" flag along with
andre taskfile stuff was to perform some kind of fair arbitration
between which channels/targets got a chance to process requests.

>BTW> The code will be much cleaner in the upcomming ide 65, since
>the allocation of the structures shared between two channels will be
>simple pushed down to the corresponding host chip drivers instead of
>the "match search" done after the channles have been initialized.

Great ! We are slowly going toward a real host controller driver
template finally ;)

>Since most of the host chip drivers are not reentrant anyway we will
>be able to save quite a lot of allocation code as well.


