Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264002AbRFTQSM>; Wed, 20 Jun 2001 12:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263997AbRFTQSC>; Wed, 20 Jun 2001 12:18:02 -0400
Received: from sncgw.nai.com ([161.69.248.229]:32641 "EHLO mcafee-labs.nai.com")
	by vger.kernel.org with ESMTP id <S263946AbRFTQRx>;
	Wed, 20 Jun 2001 12:17:53 -0400
Message-ID: <XFMail.20010620092104.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010619200442.E30785@work.bitmover.com>
Date: Wed, 20 Jun 2001 09:21:04 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Cc: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Michael Rothwell <rothwell@holly-springs.nc.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20-Jun-2001 Larry McVoy wrote:
> On Tue, Jun 19, 2001 at 10:57:38PM -0400, Michael Rothwell wrote:
>> On 19 Jun 2001 20:01:56 +0100, Alan Cox wrote:
>> 
>> > Linux inherits several unix properties which are not friendly to good
>> > state
>> > based programming - lack of good AIO for one.
>> 
>> Oh, how I would love for select() and poll() to work on files... or for
>> any other working AIO mothods to be present.
>> 
>> What would get broken if things were changed to let select() work for
>> filesystem fds?
> 
> I asked Linus for this a long time ago and he pointed out that you couldn't
> make it work over NFS, at least not nicely.  It does seem like that could 
> be worked around by having a "poll daemon" which knew about all the things
> being waited on and checked them.  Or something.
> 
> I'd like it too.  And I'd like a callback for iocompletion, a way to do
> preread(fd, len).

I'll be more than happy to have IO completion only at socket level.
Something like :


struct iocompletion ioc;

fcntl(sfd, F_SETFL, fcntl(sfd, F_GETFL, 0) | O_NONBLOCK);

ioc.event = IOC_READ;
ioc.callback = data_ready;
ioc.data = session_data;

fcntl(sfd, F_ADDIOC, (long) &ioc);


This would be pretty nice.




- Davide

